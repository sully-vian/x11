#include "raw_xevent.h"

CAMLprim value get_raw_map_notify_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xmap = {
                      .type = MapNotify,
                      .serial = 170,
                      .send_event = False,
                      .display = (Display *)0x7777,
                      .event = 7001,
                      .window = 7002,
                      .override_redirect = False,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_map_notify_override_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xmap = {
                      .type = MapNotify,
                      .serial = 171,
                      .send_event = True,
                      .display = (Display *)0x7778,
                      .event = 1,
                      .window = 7003,
                      .override_redirect = True,
                  }};
  CAMLreturn(raw_xevent(&event));
}
