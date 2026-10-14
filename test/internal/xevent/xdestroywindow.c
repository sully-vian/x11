#include "raw_xevent.h"

CAMLprim value get_raw_destroy_window_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xdestroywindow = {
                      .type = DestroyNotify,
                      .serial = 150,
                      .send_event = False,
                      .display = (Display *)0x5555,
                      .event = 5001,
                      .window = 5002,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_destroy_window_self_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xdestroywindow = {
                      .type = DestroyNotify,
                      .serial = 151,
                      .send_event = True,
                      .display = (Display *)0x5556,
                      .event = 5003,
                      .window = 5003,
                  }};
  CAMLreturn(raw_xevent(&event));
}
