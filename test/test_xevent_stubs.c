#include <X11/Xlib.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

/* Declared in x11_stubs.c */
extern value x11_event_to_ocaml(XEvent *event);

CAMLprim value get_key_press_event(value unit) {
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
  CAMLreturn(x11_event_to_ocaml(&event));
}

CAMLprim value get_key_release_event(value unit) {
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
  CAMLreturn(x11_event_to_ocaml(&event));
}

CAMLprim value get_button_press_event(value unit) {
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

  CAMLreturn(x11_event_to_ocaml(&event));
}

CAMLprim value get_motion_notify_event(value unit) {
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

  CAMLreturn(x11_event_to_ocaml(&event));
}

CAMLprim value get_expose_event(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xexpose = {
                      .type = Expose,
                      .serial = 300,
                      .send_event = True,
                      .display = (Display *)0xdef0,
                      .window = 311,
                      .x = 5,
                      .y = 15,
                      .width = 800,
                      .height = 600,
                      .count = 0,
                  }};

  CAMLreturn(x11_event_to_ocaml(&event));
}
