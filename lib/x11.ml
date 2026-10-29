open X11_internal
include X
include C.Functions
include C.Types
include Xevent
include Xwindowattributes
include Xwindowchanges
include Mask

let create_simple_window display root (x, y) (width, height) border_width border
    background =
  create_simple_window_stub display root x y width height border_width border
    background

let move_resize_window display window (x, y) (width, height) =
  move_resize_window_stub display window x y width height
