#include "raw_xevent.h"

CAMLprim value get_raw_mapping_notify_keyboard_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xmapping = {
                      .type = MappingNotify,
                      .serial = 340,
                      .send_event = False,
                      .display = (Display *)0x3335,
                      .request = MappingKeyboard,
                      .first_keycode = 8,
                      .count = 248,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_mapping_notify_pointer_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xmapping = {
                      .type = MappingNotify,
                      .serial = 341,
                      .send_event = True,
                      .display = (Display *)0x3336,
                      .request = MappingPointer,
                      .first_keycode = 0,
                      .count = 0,
                  }};
  CAMLreturn(raw_xevent(&event));
}
