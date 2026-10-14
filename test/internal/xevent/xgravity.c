#include "raw_xevent.h"

CAMLprim value get_raw_gravity_notify_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xgravity = {
                      .type = GravityNotify,
                      .serial = 360,
                      .send_event = False,
                      .display = (Display *)0x3339,
                      .event = 3601,
                      .window = 3602,
                      .x = 120,
                      .y = 80,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_gravity_notify_self_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xgravity = {
                      .type = GravityNotify,
                      .serial = 361,
                      .send_event = True,
                      .display = (Display *)0x333A,
                      .event = 3603,
                      .window = 3603,
                      .x = -40,
                      .y = 1050,
                  }};
  CAMLreturn(raw_xevent(&event));
}
