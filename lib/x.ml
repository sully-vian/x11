open Xevent
open C.Types
open Mask

type visual
type screen
type windowClass = int

type windowAttributes = {
  pos : int * int;
  size : int * int;
  border_width : int;
  depth : int;
  visual : visual;
  root : window;
  c_class : windowClass;
  bit_gravity : int;
  win_gravity : int;
  backing_store : int;
  backing_planes : int;
  backing_pixel : int;
  save_under : bool;
  colormap : colormap;
  map_installed : bool;
  map_state : int;
  all_event_masks : eventMask;
  your_event_mask : eventMask;
  do_not_propagate_mask : int;
  override_redirect : bool;
  screen : screen;
}

let next_event : display -> xEvent =
 fun dpy ->
  let event = Ctypes.make xevent_union in
  C.Functions.next_event_stub dpy (Ctypes.addr event);
  Xevent_ctypes.xevent_of_c event

external get_window_attributes : display -> window -> windowAttributes
  = "caml_XGetWindowAttributes"
