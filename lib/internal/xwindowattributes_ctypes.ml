open Ctypes
open C.Types
open Xwindowattributes

let window_attributes_of_c a : windowAttributes =
  {
    pos = (getf a xwa_x, getf a xwa_y);
    size = (getf a xwa_width, getf a xwa_height);
    border_width = getf a xwa_border_width;
    depth = getf a xwa_depth;
    visual = getf a xwa_visual;
    root = getf a xwa_root;
    c_class = getf a xwa_class;
    bit_gravity = getf a xwa_bit_gravity;
    win_gravity = getf a xwa_win_gravity;
    backing_store = getf a xwa_backing_store;
    backing_planes = Unsigned.ULong.to_int (getf a xwa_backing_planes);
    backing_pixel = Unsigned.ULong.to_int (getf a xwa_backing_pixel);
    save_under = 0 <> getf a xwa_save_under;
    colormap = getf a xwa_colormap;
    map_installed = 0 <> getf a xwa_map_installed;
    map_state = getf a xwa_map_state;
    all_event_masks = Signed.Long.to_int (getf a xwa_all_event_masks);
    your_event_mask = Signed.Long.to_int (getf a xwa_your_event_mask);
    do_not_propagate_mask =
      Signed.Long.to_int (getf a xwa_do_not_propagate_mask);
    override_redirect = 0 <> getf a xwa_override_redirect;
    screen = getf a xwa_screen;
  }
