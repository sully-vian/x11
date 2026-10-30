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

let configure_window : display -> window -> windowChanges -> unit =
 fun dpy window changes ->
  let mask, c = Xwindowchanges_ctypes.window_changes_to_c changes in
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
