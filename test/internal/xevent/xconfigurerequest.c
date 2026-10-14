#include "raw_xevent.h"

CAMLprim value get_raw_configure_request_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xconfigurerequest = {
                      .type = ConfigureRequest,
                      .serial = 190,
                      .send_event = False,
                      .display = (Display *)0x9999,
                      .parent = 9001,
                      .window = 9002,
                      .x = 100,
                      .y = 100,
                      .width = 800,
                      .height = 600,
                      .border_width = 1,
                      .above = 9003,
                      .detail = Above,
                      .value_mask = 15,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_configure_request_restack_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xconfigurerequest = {
                      .type = ConfigureRequest,
                      .serial = 191,
                      .send_event = True,
                      .display = (Display *)0x999a,
                      .parent = 1,
                      .window = 9004,
                      .x = -50,
                      .y = -20,
                      .width = 640,
                      .height = 480,
                      .border_width = 0,
                      .above = 9005,
                      .detail = Below,
                      .value_mask = CWX | CWY | CWSibling | CWStackMode,
                  }};
  CAMLreturn(raw_xevent(&event));
}
