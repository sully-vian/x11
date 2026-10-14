#include "raw_xevent.h"

CAMLprim value get_raw_reparent_notify_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xreparent = {
                      .type = ReparentNotify,
                      .serial = 210,
                      .send_event = False,
                      .display = (Display *)0x1111,
                      .event = 2101,
                      .window = 2102,
                      .parent = 2103,
                      .x = 10,
                      .y = 20,
                      .override_redirect = False,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_reparent_notify_root_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xreparent = {
                      .type = ReparentNotify,
                      .serial = 211,
                      .send_event = True,
                      .display = (Display *)0x1112,
                      .event = 2104,
                      .window = 2104,
                      .parent = 1,
                      .x = 640,
                      .y = 480,
                      .override_redirect = True,
                  }};
  CAMLreturn(raw_xevent(&event));
}
