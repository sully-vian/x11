open C.Functions
open Xevent

type visual
type screen

type xWindowAttributes = {
  pos : int * int;
  size : int * int;
  border_width : int;
  depth : int;
  visual : visual;
  root : window;
  c_class : int;
  bit_gravity : int;
  win_gravity : int;
  backing_store : int;
  backing_planes : int;
  backing_pixel : int;
  save_under : bool;
  map_state : int;
  all_event_masks : int;
  your_event_mask : int;
  do_not_propagate_mask : int;
  override_redirect : bool;
  screen : screen;
}

external next_event : display -> xEvent = "caml_XNextEvent"
