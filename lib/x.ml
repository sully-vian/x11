open Xevent

external open_display : string option -> display option = "caml_XOpenDisplay"
external close_display : display -> unit = "caml_XCloseDisplay"
