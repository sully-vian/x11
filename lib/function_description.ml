open Ctypes

module Functions (F : Ctypes.FOREIGN) = struct
  open F

  type display = unit ptr
  type window = Unsigned.ULong.t
  type keysym = int
  type keycode = int

  let display = ptr void
  let window = ulong
  let eventMask = int
  let keysym = int
  let keycode = int
  let grabMode = int
  let keyMask = int

  let open_display =
    foreign "XOpenDisplay" (string_opt @-> returning (ptr_opt void))

  let close_display = foreign "XCloseDisplay" (display @-> returning void)
  let flush = foreign "XFlush" (display @-> returning void)

  let move_resize_window_verbose =
    foreign "XMoveResizeWindow"
      (display @-> window @-> int @-> int @-> int @-> int @-> returning void)

  let default_root_window =
    foreign "XDefaultRootWindow" (display @-> returning window)

  let select_input =
    foreign "XSelectInput" (display @-> window @-> eventMask @-> returning void)

  let keysym_to_keycode =
    foreign "XKeysymToKeycode" (display @-> keysym @-> returning keycode)

  let grab_key =
    foreign "XGrabKey"
      (display @-> keycode @-> keyMask @-> window @-> bool @-> grabMode
     @-> grabMode @-> returning void)
end
