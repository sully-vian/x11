#include <X11/Xlib.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

/* Declared in x11_stubs.c */
extern value x11_event_to_ocaml(XEvent *event);

CAMLprim value get_key_press_ev(value unit) {
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

CAMLprim value get_key_release_ev(value unit) {
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

CAMLprim value get_button_press_ev(value unit) {
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

CAMLprim value get_motion_notify_ev(value unit) {
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

CAMLprim value get_expose_ev(value unit) {
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

CAMLprim value get_destroy_window_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xdestroywindow = {
                      .type = DestroyNotify,
                      .serial = 150,
                      .send_event = False,
                      .display = (Display *)0x5555,
                      .event = 5001,
                      .window = 5002,
                  }};
  CAMLreturn(x11_event_to_ocaml(&event));
}

CAMLprim value get_unmap_notify_ev(value unit) {
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
  CAMLreturn(x11_event_to_ocaml(&event));
}

CAMLprim value get_map_notify_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xmap = {
                      .type = MapNotify,
                      .serial = 170,
                      .send_event = False,
                      .display = (Display *)0x7777,
                      .event = 7001,
                      .window = 7002,
                      .override_redirect = False,
                  }};
  CAMLreturn(x11_event_to_ocaml(&event));
}

CAMLprim value get_map_request_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xmaprequest = {
                      .type = MapRequest,
                      .serial = 180,
                      .send_event = False,
                      .display = (Display *)0x8888,
                      .parent = 8001,
                      .window = 8002,
                  }};
  CAMLreturn(x11_event_to_ocaml(&event));
}

CAMLprim value get_configure_request_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xconfigurerequest = {
                      .type = ConfigureRequest,
                      .serial = 190,
                      .send_event = False,
                      .display = (Display *)0x9999,
                      .parent = 9001,
                      .window = 9002,
                      .x = 100,
                      .y = 100,
                      .width = 800,
                      .height = 600,
                      .border_width = 1,
                      .above = 9003,
                      .detail = Above,
                      .value_mask = 15,
                  }};
  CAMLreturn(x11_event_to_ocaml(&event));
}

CAMLprim value get_reparent_notify_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xreparent = {
                      .type = ReparentNotify,
                      .serial = 210,
                      .send_event = False,
                      .display = (Display *)0x1111,
                      .event = 2101,
                      .window = 2102,
                      .parent = 2103,
                      .x = 10,
                      .y = 20,
                      .override_redirect = False,
                  }};
  CAMLreturn(x11_event_to_ocaml(&event));
}

CAMLprim value get_configure_notify_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xconfigure = {
                      .type = ConfigureNotify,
                      .serial = 220,
                      .send_event = False,
                      .display = (Display *)0x2222,
                      .event = 2201,
                      .window = 2202,
                      .x = 100,
                      .y = 200,
                      .width = 1024,
                      .height = 768,
                      .border_width = 2,
                      .above = 2203,
                      .override_redirect = True,
                  }};
  CAMLreturn(x11_event_to_ocaml(&event));
}

CAMLprim value get_property_notify_ev(value unit) {
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
  CAMLreturn(x11_event_to_ocaml(&event));
}

CAMLprim value get_client_message_ev_b(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xclient = {
                      .type = ClientMessage,
                      .serial = 330,
                      .send_event = True,
                      .display = (Display *)0x4444,
                      .window = 3301,
                      .message_type = 3302,
                      .format = 8,
                  }};
  // populate message data with dummy string for b case
  for (int i = 0; i < 20; i++) {
    event.xclient.data.b[i] = i + 65;
  }
  CAMLreturn(x11_event_to_ocaml(&event));
}

CAMLprim value get_client_message_ev_s(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xclient = {
                      .type = ClientMessage,
                      .format = 16,
                  }};
  // populate message data with dummy int array for s case
  for (int i = 0; i < 10; i++) {
    event.xclient.data.s[i] = i;
  }
  CAMLreturn(x11_event_to_ocaml(&event));
}

CAMLprim value get_client_message_ev_l(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xclient = {
                      .type = ClientMessage,
                      .format = 32,
                  }};
  // populate message data with dummy long array for l case
  for (long i = 0; i < 5; i++) {
    event.xclient.data.l[i] = i;
  }
  CAMLreturn(x11_event_to_ocaml(&event));
}

CAMLprim value get_focus_in_ev(value unit) {
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
  CAMLreturn(x11_event_to_ocaml(&event));
}
