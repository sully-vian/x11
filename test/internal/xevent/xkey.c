#include "raw_xevent.h"

CAMLprim value get_raw_key_press_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xkey = {
                      .type = KeyPress,
                      .serial = 42,
                      .send_event = False,
                      .display = (Display *)0x1234,
                      .window = 123,
                      .root = 456,
                      .subwindow = 789,
                      .time = 1000,
                      .x = 10,
                      .y = 20,
                      .x_root = 100,
                      .y_root = 200,
                      .state = 0,
                      .keycode = 65,
                      .same_screen = True,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_key_release_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xkey = {
                      .type = KeyRelease,
                      .serial = 42,
                      .send_event = False,
                      .display = (Display *)0x1234,
                      .window = 123,
                      .root = 456,
                      .subwindow = 789,
                      .time = 1000,
                      .x = 10,
                      .y = 20,
                      .x_root = 100,
                      .y_root = 200,
                      .state = 0,
                      .keycode = 65,
                      .same_screen = True,
                  }};
  CAMLreturn(raw_xevent(&event));
}
