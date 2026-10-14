#include "raw_xevent.h"

CAMLprim value get_raw_motion_notify_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xmotion = {
                      .type = MotionNotify,
                      .serial = 200,
                      .send_event = False,
                      .display = (Display *)0x9abc,
                      .window = 211,
                      .root = 212,
                      .subwindow = 213,
                      .time = 3000,
                      .x = 30,
                      .y = 40,
                      .x_root = 130,
                      .y_root = 240,
                      .state = 2,
                      .same_screen = True,
                  }};

  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_motion_notify_hint_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xmotion = {
                      .type = MotionNotify,
                      .serial = 201,
                      .x = 31,
                      .y = 41,
                      .state = Button1Mask,
                      .is_hint = NotifyHint,
                      .same_screen = True,
                  }};
  CAMLreturn(raw_xevent(&event));
}
