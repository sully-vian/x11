open Ctypes

module Functions (F : Ctypes.FOREIGN) = struct
  open F

  type display = unit ptr

  let open_display =
    foreign "XOpenDisplay" (string_opt @-> returning (ptr_opt void))

  let close_display = foreign "XCloseDisplay" (ptr void @-> returning void)
end
