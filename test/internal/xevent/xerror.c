#include "raw_xevent.h"
#include <X11/Xproto.h>

/* XGetWindowAttributes on a window that doesn't exist */
CAMLprim value get_raw_bad_window_error(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xerror = {
                      .type = 0,
                      .display = (Display *)0x3337,
                      .resourceid = 0x400001,
                      .serial = 342,
                      .error_code = BadWindow,
                      .request_code = X_GetWindowAttributes,
                      .minor_code = 0,
                  }};
  CAMLreturn(raw_xevent(&event));
}

/* An extension request: codes past 127, with a minor code */
CAMLprim value get_raw_extension_error(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xerror = {
                      .type = 0,
                      .display = (Display *)0x3338,
                      .resourceid = 0,
                      .serial = 343,
                      .error_code = 255,
                      .request_code = 140,
                      .minor_code = 7,
                  }};
  CAMLreturn(raw_xevent(&event));
}
