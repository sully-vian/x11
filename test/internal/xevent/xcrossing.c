#include "raw_xevent.h"

CAMLprim value get_raw_enter_notify_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xcrossing = {
                      .type = EnterNotify,
                      .serial = 400,
                      .send_event = True,
                      .display = (Display *)0x6666,
                      .window = 4001,
                      .root = 4002,
                      .subwindow = 4003,
                      .time = 6000,
                      .x = 12,
                      .y = 34,
                      .x_root = 112,
                      .y_root = 134,
                      .mode = NotifyGrab,
                      .detail = NotifyInferior,
                      .same_screen = True,
                      .focus = True,
                      .state = 4,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_leave_notify_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xcrossing = {
                      .type = LeaveNotify,
                      .serial = 410,
                      .send_event = False,
                      .display = (Display *)0x7777,
                      .window = 4101,
                      .x = 56,
                      .y = 78,
                      .x_root = 156,
                      .y_root = 178,
                      .mode = NotifyUngrab,
                      .detail = NotifyNonlinearVirtual,
                  }};
  CAMLreturn(raw_xevent(&event));
}
