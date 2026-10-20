open Ctypes
open Utils
open Types_generated

module Functions (F : Ctypes.FOREIGN) = struct
  open F

  let open_display =
    foreign "XOpenDisplay" (string_opt @-> returning (ptr_opt void))

  let close_display = foreign "XCloseDisplay" (display @-> returning void)
  let flush = foreign "XFlush" (display @-> returning void)

  let clear_window =
    foreign "XClearWindow" (display @-> window @-> returning void)

  let set_window_background =
    foreign "XSetWindowBackground"
      (display @-> window @-> int @-> returning void)

  let map_window = foreign "XMapWindow" (display @-> window @-> returning void)

  (* Returns None (atom 0) only when only_if_exists is set and the atom doesn't
     exist yet *)
  let intern_atom =
    foreign "XInternAtom" (display @-> string @-> bool @-> returning ulong_opt)

  (* Returns a zero Status on failure *)
  let set_wm_protocols_stub =
    foreign "XSetWMProtocols"
      (display @-> window @-> ptr atom @-> int @-> returning int)

  let store_name =
    foreign "XStoreName" (display @-> window @-> string @-> returning void)

  let create_simple_window_verbose =
    foreign "XCreateSimpleWindow"
      (display @-> window @-> int @-> int @-> int @-> int @-> int @-> int
     @-> int @-> returning window)

  let move_resize_window_verbose =
    foreign "XMoveResizeWindow"
      (display @-> window @-> int @-> int @-> int @-> int @-> returning void)

  let default_root_window =
    foreign "XDefaultRootWindow" (display @-> returning window)

  let raise_window =
    foreign "XRaiseWindow" (display @-> window @-> returning void)

  let select_input =
    foreign "XSelectInput" (display @-> window @-> eventMask @-> returning void)

  let keysym_to_keycode =
    foreign "XKeysymToKeycode" (display @-> keysym @-> returning keycode)

  let grab_button =
    foreign "XGrabButton"
      (display @-> button @-> keyMask @-> window @-> bool @-> eventMask
     @-> grab_mode @-> grab_mode @-> ulong_opt @-> int_opt @-> returning void)

  let grab_key =
    foreign "XGrabKey"
      (display @-> keycode @-> keyMask @-> window @-> bool @-> grab_mode
     @-> grab_mode @-> returning void)

  let next_event_stub =
    foreign "XNextEvent" (display @-> ptr xevent_union @-> returning void)

  (* Returns a zero Status on failure *)
  let get_window_attributes_stub =
    foreign "XGetWindowAttributes"
      (display @-> window @-> ptr xwindowattributes @-> returning int)
end
