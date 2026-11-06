open C.Types
open Mask
open Type_description.Enums

type windowAttributes = {
  pos : int * int;
  size : int * int;
  border_width : int;
  depth : int;
  visual : visual;
  root : window;
  c_class : windowClass;
  bit_gravity : gravity;
  win_gravity : gravity;
  backing_store : backingStore;
  backing_planes : int;
  backing_pixel : int;
  save_under : bool;
  colormap : colormap;
  map_installed : bool;
  map_state : mapState;
  all_event_masks : 'a. (([> eventFlags ] as 'a), union) mask;
  your_event_mask : 'a. (([> eventFlags ] as 'a), union) mask;
  do_not_propagate_mask : 'a. (([> deviceEventFlags ] as 'a), union) mask;
  override_redirect : bool;
  screen : screen;
}
