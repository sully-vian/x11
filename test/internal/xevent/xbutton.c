#include "raw_xevent.h"

CAMLprim value get_raw_button_press_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xbutton = {
                      .type = ButtonPress,
                      .serial = 100,
                      .send_event = True,
                      .display = (Display *)0x5678,
                      .window = 111,
                      .root = 222,
                      .subwindow = 333,
                      .time = 2000,
                      .x = 50,
                      .y = 75,
                      .x_root = 150,
                      .y_root = 250,
                      .state = 1,
                      .button = 1,
                      .same_screen = True,
                  }};

  CAMLreturn(raw_xevent(&event));
}
