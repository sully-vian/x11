#include "raw_xevent.h"

CAMLprim value get_raw_create_notify_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xcreatewindow = {
                      .type = CreateNotify,
                      .serial = 350,
                      .send_event = False,
                      .display = (Display *)0x3337,
                      .parent = 3501,
                      .window = 3502,
                      .x = 50,
                      .y = 60,
                      .width = 800,
                      .height = 600,
                      .border_width = 1,
                      .override_redirect = False,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_create_notify_override_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xcreatewindow = {
                      .type = CreateNotify,
                      .serial = 351,
                      .send_event = True,
                      .display = (Display *)0x3338,
                      .parent = 3503,
                      .window = 3504,
                      .x = -1720,
                      .y = -15,
                      .width = 240,
                      .height = 32,
                      .border_width = 0,
                      .override_redirect = True,
                  }};
  CAMLreturn(raw_xevent(&event));
}
