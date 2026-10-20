open Xevent
open Xwindowattributes
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

(* Its only failure is not being able to intern WM_PROTOCOLS *)
let set_wm_protocols : display -> window -> atom list -> unit =
 fun dpy window protocols ->
  let protocols = Ctypes.CArray.of_list atom protocols in
  ignore
    (C.Functions.set_wm_protocols_stub dpy window
       (Ctypes.CArray.start protocols)
       (Ctypes.CArray.length protocols))
