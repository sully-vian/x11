#include "raw_xevent.h"

CAMLprim value get_raw_expose_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xexpose = {
                      .type = Expose,
                      .serial = 300,
                      .send_event = True,
                      .display = (Display *)0xdef0,
                      .window = 311,
                      .x = 5,
                      .y = 15,
                      .width = 800,
                      .height = 600,
                      .count = 3,
                  }};

  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_expose_last_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xexpose = {
                      .type = Expose,
                      .serial = 301,
                      .send_event = False,
                      .display = (Display *)0xdef1,
                      .window = 312,
                      .x = 1920,
                      .y = 1080,
                      .width = 3840,
                      .height = 2160,
                      .count = 0,
                  }};
  CAMLreturn(raw_xevent(&event));
}
