#include "raw_xevent.h"

CAMLprim value get_raw_unmap_notify_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xunmap = {
                      .type = UnmapNotify,
                      .serial = 160,
                      .send_event = False,
                      .display = (Display *)0x6666,
                      .event = 6001,
                      .window = 6002,
                      .from_configure = False,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_unmap_notify_synthetic_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xunmap = {
                      .type = UnmapNotify,
                      .serial = 161,
                      .send_event = True,
                      .display = (Display *)0x6667,
                      .event = 1,
                      .window = 6003,
                      .from_configure = True,
                  }};
  CAMLreturn(raw_xevent(&event));
}
