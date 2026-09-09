#include <X11/Xlib.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

/* Bypassing linker drop for testing */
#include "../lib/x11_stubs.c"

CAMLprim value test_gen_key_event(value unit) {
  CAMLparam1(unit);
  XEvent ev = {.xkey = {.type = KeyPress,
                        .serial = 100,
                        .send_event = 1,
                        .display = (Display *)0x1234,
                        .window = 10,
                        .root = 20,
                        .subwindow = 30,
                        .time = 1000,
                        .x = 50,
                        .y = 60,
                        .x_root = 70,
                        .y_root = 80,
                        .state = 5,
                        .keycode = 13,
                        .same_screen = 1}};
  CAMLreturn(x11_event_to_ocaml(&ev));
}

CAMLprim value test_gen_button_event(value unit) {
  CAMLparam1(unit);
  XEvent ev = {.xbutton = {.type = ButtonPress,
                           .serial = 101,
                           .send_event = 0,
                           .display = (Display *)0x5678,
                           .window = 11,
                           .root = 21,
                           .subwindow = 31,
                           .time = 2000,
                           .x = 51,
                           .y = 61,
                           .x_root = 71,
                           .y_root = 81,
                           .state = 6,
                           .button = 1,
                           .same_screen = 1}};
  CAMLreturn(x11_event_to_ocaml(&ev));
}

CAMLprim value test_gen_motion_event(value unit) {
  CAMLparam1(unit);
  XEvent ev = {.xmotion = {.type = MotionNotify,
                           .serial = 102,
                           .send_event = 1,
                           .display = (Display *)0x9ABC,
                           .window = 12,
                           .root = 22,
                           .subwindow = 32,
                           .time = 3000,
                           .x = 52,
                           .y = 62,
                           .x_root = 72,
                           .y_root = 82,
                           .state = 7,
                           .same_screen = 0}};
  CAMLreturn(x11_event_to_ocaml(&ev));
}

CAMLprim value test_gen_expose_event(value unit) {
  CAMLparam1(unit);
  XEvent ev = {.xexpose = {.type = Expose,
                           .serial = 103,
                           .send_event = 0,
                           .display = (Display *)0xDEF0,
                           .window = 13,
                           .x = 100,
                           .y = 200,
                           .width = 800,
                           .height = 600,
                           .count = 2}};
  CAMLreturn(x11_event_to_ocaml(&ev));
}

CAMLprim value test_gen_configure_event(value unit) {
  CAMLparam1(unit);
  XEvent ev = {.xconfigure = {.type = ConfigureNotify,
                              .serial = 104,
                              .send_event = 1,
                              .display = (Display *)0x1111,
                              .event = 40,
                              .window = 14,
                              .x = 300,
                              .y = 400,
                              .width = 1024,
                              .height = 768,
                              .border_width = 2,
                              .above = 50,
                              .override_redirect = 0}};
  CAMLreturn(x11_event_to_ocaml(&ev));
}
