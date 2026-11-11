open Xevent
open Xwindowattributes
open Xwindowchanges
open C.Types

let next_event : display -> xEvent =
 fun dpy ->
  let event = Ctypes.make xevent_union in
  C.Functions.next_event_stub dpy (Ctypes.addr event);
  Xevent_ctypes.xevent_of_c event

let get_window_attributes : display -> window -> windowAttributes option =
 fun dpy window ->
  let attributes = Ctypes.make xwindowattributes in
  if
    C.Functions.get_window_attributes_stub dpy window (Ctypes.addr attributes)
    = 0
  then None
  else Some (Xwindowattributes_ctypes.window_attributes_of_c attributes)

let configure_window :
    ?value_mask:int -> display -> window -> windowChanges -> unit =
 fun ?value_mask dpy window changes ->
  let mask, c = Xwindowchanges_ctypes.window_changes_to_c ?value_mask changes in
  ignore
    (C.Functions.configure_window_stub dpy window
       (Unsigned.UInt.of_int mask)
       (Ctypes.addr c))

(* X passes these as a window: None (0), PointerRoot or the window itself *)
type focus = FocusNone | FocusPointerRoot | FocusWindow of window

let set_input_focus : display -> focus -> revertTo -> time -> unit =
 fun dpy focus revert_to time ->
  let focus =
    match focus with
    | FocusNone -> Unsigned.ULong.zero
    | FocusPointerRoot -> pointerRoot
    | FocusWindow window -> window
  in
  ignore (C.Functions.set_input_focus_stub dpy focus revert_to time)

let get_input_focus : display -> focus * revertTo =
 fun dpy ->
  let focus = Ctypes.allocate window Unsigned.ULong.zero in
  let revert = Ctypes.allocate revert_to RevertToNone in
  ignore (C.Functions.get_input_focus_stub dpy focus revert);
  let focus =
    match Ctypes.( !@ ) focus with
    | w when Unsigned.ULong.equal w Unsigned.ULong.zero -> FocusNone
    | w when Unsigned.ULong.equal w pointerRoot -> FocusPointerRoot
    | w -> FocusWindow w
  in
  (focus, Ctypes.( !@ ) revert)

(* Its only failure is not being able to intern WM_PROTOCOLS *)
let set_wm_protocols : display -> window -> atom list -> unit =
 fun dpy window protocols ->
  let protocols = Ctypes.CArray.of_list atom protocols in
  ignore
    (C.Functions.set_wm_protocols_stub dpy window
       (Ctypes.CArray.start protocols)
       (Ctypes.CArray.length protocols))

(* Atoms are XIDs, whose top three bits are zero: reading the long as unsigned
   gives the same value *)
let atom_of_long : Signed.long -> atom =
 fun l -> Unsigned.ULong.of_int64 (Signed.Long.to_int64 l)

external set_error_handler_stub : unit -> unit = "x11_set_error_handler"

type errorHandler = display -> errorEvent ->unit

(* error_handler_stubs.c calls the registered function with the addresses of
   the display and the XErrorEvent, valid only during the call. An exception
   can't go back through Xlib: it ends the program as an uncaught one would. *)
let set_error_handler : errorHandler -> unit =
 fun handler ->
  let handler display error =
    let display = Ctypes.ptr_of_raw_address display in
    let error =
      Ctypes.(!@(from_voidp xerror_event (ptr_of_raw_address error)))
    in
    try handler display (Xevent_ctypes.error_of_c error)
    with exn ->
      Printexc.default_uncaught_exception_handler exn
        (Printexc.get_raw_backtrace ());
      exit 2
  in
  Callback.register "x11_error_handler" handler;
  set_error_handler_stub ()
