#include "raw_xevent.h"

CAMLprim value get_raw_focus_in_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xfocus = {
                      .type = FocusIn,
                      .serial = 90,
                      .send_event = False,
                      .display = (Display *)0x5555,
                      .window = 901,
                      .mode = NotifyNormal,
                      .detail = NotifyNonlinear,
                  }};
  CAMLreturn(raw_xevent(&event));
}
