#include "raw_xevent.h"

CAMLprim value get_raw_property_notify_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xproperty = {
                      .type = PropertyNotify,
                      .serial = 280,
                      .send_event = False,
                      .display = (Display *)0x3333,
                      .window = 2801,
                      .atom = 2802,
                      .time = 5000,
                      .state = PropertyNewValue,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_property_notify_delete_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xproperty = {
                      .type = PropertyNotify,
                      .serial = 281,
                      .send_event = True,
                      .display = (Display *)0x3334,
                      .window = 2803,
                      .atom = 2804,
                      .time = 0xFFFFFFF0,
                      .state = PropertyDelete,
                  }};
  CAMLreturn(raw_xevent(&event));
}
