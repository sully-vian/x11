module CI = Cstubs_internals
module CS = Ctypes_static
module CP = Ctypes_ptr
open C.Functions
open Xevent
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

external next_event_raw : (Obj.t option, unit CS.typ) CP.Fat.t -> xEvent
  = "caml_XNextEvent"

let next_event : display -> xEvent =
 fun dpy ->
  let (CI.CPointer dpy_unwrapped) = dpy in
  next_event_raw dpy_unwrapped

external get_window_attributes : display -> window -> windowAttributes
  = "caml_XGetWindowAttributes"
