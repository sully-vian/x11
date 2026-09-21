include C.Functions
include C.Types
include Xevent
include Mask

type grabMode = int

let move_resize_window display window (x, y) (width, height) =
  move_resize_window_verbose display window x y width height
