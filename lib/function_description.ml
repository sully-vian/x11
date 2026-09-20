open Ctypes

module Functions (F : Ctypes.FOREIGN) = struct
  open F

  type display = unit ptr

  let display = ptr void

  let open_display =
    foreign "XOpenDisplay" (string_opt @-> returning (ptr_opt void))

  let close_display = foreign "XCloseDisplay" (display @-> returning void)
end
