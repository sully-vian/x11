#include "raw_xevent.h"

CAMLprim value get_raw_circulate_notify_bottom_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xcirculate = {
                      .type = CirculateNotify,
                      .serial = 370,
                      .send_event = False,
                      .display = (Display *)0x333B,
                      .event = 3701,
                      .window = 3702,
                      .place = PlaceOnBottom,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_circulate_notify_top_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xcirculate = {
                      .type = CirculateNotify,
                      .serial = 371,
                      .send_event = True,
                      .display = (Display *)0x333C,
                      .event = 3703,
                      .window = 3703,
                      .place = PlaceOnTop,
                  }};
  CAMLreturn(raw_xevent(&event));
}
