#include <X11/Xlib.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

/* The events are copied to static storage so their address stays valid after
   the stub returns. Each call overwrites the previous event. */
static XEvent stored_event;

static value raw_xevent(XEvent *event) {
  stored_event = *event;
  return caml_copy_nativeint((intnat)&stored_event);
}

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

CAMLprim value get_raw_expose_ev(value unit) {
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
                      .count = 3,
                  }};

  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_expose_last_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xexpose = {
                      .type = Expose,
                      .serial = 301,
                      .send_event = False,
                      .display = (Display *)0xdef1,
                      .window = 312,
                      .x = 1920,
                      .y = 1080,
                      .width = 3840,
                      .height = 2160,
                      .count = 0,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_destroy_window_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xdestroywindow = {
                      .type = DestroyNotify,
                      .serial = 150,
                      .send_event = False,
                      .display = (Display *)0x5555,
                      .event = 5001,
                      .window = 5002,
                  }};
  CAMLreturn(raw_xevent(&event));
}

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

CAMLprim value get_raw_map_notify_ev(value unit) {
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
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_map_request_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xmaprequest = {
                      .type = MapRequest,
                      .serial = 180,
                      .send_event = False,
                      .display = (Display *)0x8888,
                      .parent = 8001,
                      .window = 8002,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_configure_request_ev(value unit) {
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
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_reparent_notify_ev(value unit) {
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
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_configure_notify_ev(value unit) {
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
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_property_notify_ev(value unit) {
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
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_client_message_ev_b(value unit) {
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
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_client_message_ev_s(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xclient = {
                      .type = ClientMessage,
                      .format = 16,
                  }};
  // populate message data with dummy int array for s case
  for (int i = 0; i < 10; i++) {
    event.xclient.data.s[i] = i;
  }
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_client_message_ev_l(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xclient = {
                      .type = ClientMessage,
                      .format = 32,
                  }};
  // populate message data with dummy long array for l case
  for (long i = 0; i < 5; i++) {
    event.xclient.data.l[i] = i;
  }
  CAMLreturn(raw_xevent(&event));
}

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

CAMLprim value get_raw_destroy_window_self_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xdestroywindow = {
                      .type = DestroyNotify,
                      .serial = 151,
                      .send_event = True,
                      .display = (Display *)0x5556,
                      .event = 5003,
                      .window = 5003,
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

CAMLprim value get_raw_map_notify_override_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xmap = {
                      .type = MapNotify,
                      .serial = 171,
                      .send_event = True,
                      .display = (Display *)0x7778,
                      .event = 1,
                      .window = 7003,
                      .override_redirect = True,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_map_request_root_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xmaprequest = {
                      .type = MapRequest,
                      .serial = 181,
                      .send_event = True,
                      .display = (Display *)0x8889,
                      .parent = 1,
                      .window = 0x1e00007,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_configure_request_restack_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xconfigurerequest = {
                      .type = ConfigureRequest,
                      .serial = 191,
                      .send_event = True,
                      .display = (Display *)0x999a,
                      .parent = 1,
                      .window = 9004,
                      .x = -50,
                      .y = -20,
                      .width = 640,
                      .height = 480,
                      .border_width = 0,
                      .above = 9005,
                      .detail = Below,
                      .value_mask = CWX | CWY | CWSibling | CWStackMode,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_reparent_notify_root_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xreparent = {
                      .type = ReparentNotify,
                      .serial = 211,
                      .send_event = True,
                      .display = (Display *)0x1112,
                      .event = 2104,
                      .window = 2104,
                      .parent = 1,
                      .x = 640,
                      .y = 480,
                      .override_redirect = True,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_configure_notify_synthetic_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xconfigure = {
                      .type = ConfigureNotify,
                      .serial = 221,
                      .send_event = True,
                      .display = (Display *)0x2223,
                      .event = 2204,
                      .window = 2204,
                      .x = 1925,
                      .y = 30,
                      .width = 1280,
                      .height = 720,
                      .border_width = 0,
                      .above = None,
                      .override_redirect = False,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_property_notify_delete_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xproperty = {
                      .type = PropertyNotify,
                      .serial = 281,
                      .send_event = True,
                      .display = (Display *)0x3334,
                      .window = 2803,
                      .atom = 2804,
                      .time = 0xFFFFFFF0,
                      .state = PropertyDelete,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_mapping_notify_keyboard_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xmapping = {
                      .type = MappingNotify,
                      .serial = 340,
                      .send_event = False,
                      .display = (Display *)0x3335,
                      .window = 3401,
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
                      .window = 3402,
                      .request = MappingPointer,
                      .first_keycode = 0,
                      .count = 0,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_create_notify_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xcreatewindow = {
                      .type = CreateNotify,
                      .serial = 350,
                      .send_event = False,
                      .display = (Display *)0x3337,
                      .parent = 3501,
                      .window = 3502,
                      .x = 50,
                      .y = 60,
                      .width = 800,
                      .height = 600,
                      .border_width = 1,
                      .override_redirect = False,
                  }};
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_create_notify_override_ev(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xcreatewindow = {
                      .type = CreateNotify,
                      .serial = 351,
                      .send_event = True,
                      .display = (Display *)0x3338,
                      .parent = 3503,
                      .window = 3504,
                      .x = -1720,
                      .y = -15,
                      .width = 240,
                      .height = 32,
                      .border_width = 0,
                      .override_redirect = True,
                  }};
  CAMLreturn(raw_xevent(&event));
}
