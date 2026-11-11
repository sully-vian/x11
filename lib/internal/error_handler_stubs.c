#include <X11/Xlib.h>
#include <caml/alloc.h>
#include <caml/callback.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

/* Xlib calls the error handler from C, during whichever call received the
   error: it passes the display and the error's address to the OCaml function
   registered as "x11_error_handler", which converts the error with ctypes.
   The ctypes stubs keep the runtime lock, so the callback runs with it held.
   The OCaml side catches its own exceptions: none may unwind through Xlib.
   Xlib ignores the return value. */
static int error_handler(Display *display, XErrorEvent *error) {
  CAMLparam0();
  CAMLlocal2(display_address, error_address);
  static const value *handler = NULL;
  if (handler == NULL)
    handler = caml_named_value("x11_error_handler");
  display_address = caml_copy_nativeint((intnat)display);
  error_address = caml_copy_nativeint((intnat)error);
  caml_callback2_exn(*handler, display_address, error_address);
  CAMLreturnT(int, 0);
}

CAMLprim value x11_set_error_handler(value unit) {
  CAMLparam1(unit);
  XSetErrorHandler(error_handler);
  CAMLreturn(Val_unit);
}
