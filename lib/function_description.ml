open Ctypes

module Functions (F : Ctypes.FOREIGN) = struct
  open F

  type display = unit ptr
  type window = Unsigned.ULong.t

  let display = ptr void
  let window = ulong

  let open_display =
    foreign "XOpenDisplay" (string_opt @-> returning (ptr_opt void))

  let close_display = foreign "XCloseDisplay" (display @-> returning void)
  let flush = foreign "XFlush" (display @-> returning void)

  let move_resize_window_verbose =
    foreign "XMoveResizeWindow"
      (display @-> window @-> int @-> int @-> int @-> int @-> returning void)
end
