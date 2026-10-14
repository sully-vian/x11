#include "raw_xevent.h"

CAMLprim value get_raw_map_request_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xmaprequest = {
                      .type = MapRequest,
                      .serial = 180,
                      .send_event = False,
                      .display = (Display *)0x8888,
                      .parent = 8001,
                      .window = 8002,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_map_request_root_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xmaprequest = {
                      .type = MapRequest,
                      .serial = 181,
                      .send_event = True,
                      .display = (Display *)0x8889,
                      .parent = 1,
                      .window = 0x1e00007,
                  }};
  CAMLreturn(raw_xevent(&event));
}
