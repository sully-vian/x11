include C.Functions
include C.Types
include Xevent

let move_resize_window display window (x, y) (width, height) =
  move_resize_window_verbose display window x y width height
