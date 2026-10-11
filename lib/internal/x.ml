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
