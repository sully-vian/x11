#include "raw_xevent.h"

CAMLprim value get_raw_circulate_request_top_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xcirculaterequest = {
                      .type = CirculateRequest,
                      .serial = 380,
                      .send_event = False,
                      .display = (Display *)0x333D,
                      .parent = 3801,
                      .window = 3802,
                      .place = PlaceOnTop,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_circulate_request_bottom_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xcirculaterequest = {
                      .type = CirculateRequest,
                      .serial = 381,
                      .send_event = True,
                      .display = (Display *)0x333E,
                      .parent = 3803,
                      .window = 3804,
                      .place = PlaceOnBottom,
                  }};
  CAMLreturn(raw_xevent(&event));
}
