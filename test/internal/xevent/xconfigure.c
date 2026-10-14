#include "raw_xevent.h"

CAMLprim value get_raw_configure_notify_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xconfigure = {
                      .type = ConfigureNotify,
                      .serial = 220,
                      .send_event = False,
                      .display = (Display *)0x2222,
                      .event = 2201,
                      .window = 2202,
                      .x = 100,
                      .y = 200,
                      .width = 1024,
                      .height = 768,
                      .border_width = 2,
                      .above = 2203,
                      .override_redirect = True,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_configure_notify_synthetic_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xconfigure = {
                      .type = ConfigureNotify,
                      .serial = 221,
                      .send_event = True,
                      .display = (Display *)0x2223,
                      .event = 2204,
                      .window = 2204,
                      .x = 1925,
                      .y = 30,
                      .width = 1280,
                      .height = 720,
                      .border_width = 0,
                      .above = None,
                      .override_redirect = False,
                  }};
  CAMLreturn(raw_xevent(&event));
}
