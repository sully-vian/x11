open X11_internal
include X
include C.Functions
include C.Types
include Xevent
include Mask

type grabMode = int
type cursor = int

let create_simple_window display root (x, y) (width, height) border_width border
    background =
  create_simple_window_verbose display root x y width height border_width border
    background

let move_resize_window display window (x, y) (width, height) =
  move_resize_window_verbose display window x y width height

module Private = struct
  let xevent_of_raw_address address =
    Ctypes.(
      !@(from_voidp Xevent_ctypes.xevent_typ (ptr_of_raw_address address)))
end
