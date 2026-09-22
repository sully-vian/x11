#include "utils.h"
#include <X11/Xlib.h>
#include <caml/alloc.h>
#include <caml/fail.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

value Val_xevent(XEvent *event) {
  CAMLparam0();
  CAMLlocal5(v_record, v_pos, v_root_pos, v_size, v_event);
  int off = 0;

  switch (event->type) {
  case KeyPress:
  case KeyRelease:
    v_record = caml_alloc(12, 0); // 12 fields
    Store_field(v_record, off++, Val_int(event->xkey.serial));
    Store_field(v_record, off++, Val_bool(event->xkey.send_event));
    Store_field(v_record, off++, Val_ptr(event->xkey.display));
    Store_field(v_record, off++, Val_xid(event->xkey.window));
    Store_field(v_record, off++, Val_xid(event->xkey.root));
    Store_field(v_record, off++, Val_xid(event->xkey.subwindow));
    Store_field(v_record, off++, Val_xid(event->xkey.time));
    v_pos = caml_tuple2(Val_int(event->xkey.x), Val_int(event->xkey.y));
    Store_field(v_record, off++, v_pos);
    v_root_pos =
        caml_tuple2(Val_int(event->xkey.x_root), Val_int(event->xkey.y_root));
    Store_field(v_record, off++, v_root_pos);
    Store_field(v_record, off++, Val_int(event->xkey.state));
    Store_field(v_record, off++, Val_int(event->xkey.keycode));
    Store_field(v_record, off++, Val_bool(event->xkey.same_screen));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case ButtonPress:
  case ButtonRelease:
    v_record = caml_alloc(12, 0); //  12 fields
    Store_field(v_record, off++, Val_int(event->xbutton.serial));
    Store_field(v_record, off++, Val_bool(event->xbutton.send_event));
    Store_field(v_record, off++, Val_ptr(event->xbutton.display));
    Store_field(v_record, off++, Val_xid(event->xbutton.window));
    Store_field(v_record, off++, Val_xid(event->xbutton.root));
    Store_field(v_record, off++, Val_xid(event->xbutton.subwindow));
    Store_field(v_record, off++, Val_xid(event->xbutton.time));
    v_pos = caml_tuple2(Val_int(event->xbutton.x), Val_int(event->xbutton.y));
    Store_field(v_record, off++, v_pos);
    v_root_pos = caml_tuple2(Val_int(event->xbutton.x_root),
                             Val_int(event->xbutton.y_root));
    Store_field(v_record, off++, v_root_pos);
    Store_field(v_record, off++, Val_int(event->xbutton.state));
    Store_field(v_record, off++, Val_int(event->xbutton.button));
    Store_field(v_record, off++, Val_bool(event->xbutton.same_screen));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case MotionNotify:
    v_record = caml_alloc(13, 0); // 13 fields
    Store_field(v_record, off++, Val_int(event->xmotion.serial));
    Store_field(v_record, off++, Val_bool(event->xmotion.send_event));
    Store_field(v_record, off++, Val_ptr(event->xmotion.display));
    Store_field(v_record, off++, Val_xid(event->xmotion.window));
    Store_field(v_record, off++, Val_xid(event->xmotion.root));
    Store_field(v_record, off++, Val_xid(event->xmotion.subwindow));
    Store_field(v_record, off++, Val_xid(event->xmotion.time));
    v_pos = caml_tuple2(Val_int(event->xmotion.x), Val_int(event->xmotion.y));
    Store_field(v_record, off++, v_pos);
    v_root_pos = caml_tuple2(Val_int(event->xmotion.x_root),
                             Val_int(event->xmotion.y_root));
    Store_field(v_record, off++, v_root_pos);
    Store_field(v_record, off++, Val_int(event->xmotion.state));
    Store_field(v_record, off++, Val_bool(event->xmotion.same_screen));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case Expose:
    v_record = caml_alloc(7, 0); // 7 fields
    Store_field(v_record, off++, Val_int(event->xexpose.serial));
    Store_field(v_record, off++, Val_bool(event->xexpose.send_event));
    Store_field(v_record, off++, Val_ptr(event->xexpose.display));
    Store_field(v_record, off++, Val_xid(event->xexpose.window));
    v_pos = caml_tuple2(Val_int(event->xexpose.x), Val_int(event->xexpose.y));
    Store_field(v_record, off++, v_pos);
    v_size = caml_tuple2(Val_int(event->xexpose.width),
                         Val_int(event->xexpose.height));
    Store_field(v_record, off++, v_size);
    Store_field(v_record, off++, Val_int(event->xexpose.count));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case DestroyNotify:
    v_record = caml_alloc(5, 0);
    Store_field(v_record, off++, Val_int(event->xdestroywindow.serial));
    Store_field(v_record, off++, Val_bool(event->xdestroywindow.send_event));
    Store_field(v_record, off++, Val_ptr(event->xdestroywindow.display));
    Store_field(v_record, off++, Val_xid(event->xdestroywindow.event));
    Store_field(v_record, off++, Val_xid(event->xdestroywindow.window));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case UnmapNotify:
    v_record = caml_alloc(6, 0);
    Store_field(v_record, off++, Val_int(event->xunmap.serial));
    Store_field(v_record, off++, Val_bool(event->xunmap.send_event));
    Store_field(v_record, off++, Val_ptr(event->xunmap.display));
    Store_field(v_record, off++, Val_xid(event->xunmap.event));
    Store_field(v_record, off++, Val_xid(event->xunmap.window));
    Store_field(v_record, off++, Val_bool(event->xunmap.from_configure));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case MapNotify:
    v_record = caml_alloc(6, 0);
    Store_field(v_record, off++, Val_int(event->xmap.serial));
    Store_field(v_record, off++, Val_bool(event->xmap.send_event));
    Store_field(v_record, off++, Val_ptr(event->xmap.display));
    Store_field(v_record, off++, Val_xid(event->xmap.event));
    Store_field(v_record, off++, Val_xid(event->xmap.window));
    Store_field(v_record, off++, Val_bool(event->xmap.override_redirect));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case MapRequest:
    v_record = caml_alloc(5, 0);
    Store_field(v_record, off++, Val_int(event->xmaprequest.serial));
    Store_field(v_record, off++, Val_bool(event->xmaprequest.send_event));
    Store_field(v_record, off++, Val_ptr(event->xmaprequest.display));
    Store_field(v_record, off++, Val_xid(event->xmaprequest.parent));
    Store_field(v_record, off++, Val_xid(event->xmaprequest.window));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case ConfigureRequest:
    v_record = caml_alloc(12, 0);
    Store_field(v_record, off++, Val_int(event->xconfigurerequest.serial));
    Store_field(v_record, off++, Val_bool(event->xconfigurerequest.send_event));
    Store_field(v_record, off++, Val_ptr(event->xconfigurerequest.display));
    Store_field(v_record, off++, Val_xid(event->xconfigurerequest.parent));
    Store_field(v_record, off++, Val_xid(event->xconfigurerequest.window));
    v_pos = caml_tuple2(Val_int(event->xconfigurerequest.x),
                        Val_int(event->xconfigurerequest.y));
    Store_field(v_record, off++, v_pos);
    v_size = caml_tuple2(Val_int(event->xconfigurerequest.width),
                         Val_int(event->xconfigurerequest.height));
    Store_field(v_record, off++, v_size);
    Store_field(v_record, off++,
                Val_int(event->xconfigurerequest.border_width));
    Store_field(v_record, off++, Val_xid(event->xconfigurerequest.above));
    Store_field(v_record, off++, Val_int(event->xconfigurerequest.detail));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case ReparentNotify:
    v_record = caml_alloc(9, 0); // 9 fields
    Store_field(v_record, off++, Val_int(event->xreparent.serial));
    Store_field(v_record, off++, Val_bool(event->xreparent.send_event));
    Store_field(v_record, off++, Val_ptr(event->xreparent.display));
    Store_field(v_record, off++, Val_xid(event->xreparent.event));
    Store_field(v_record, off++, Val_xid(event->xreparent.window));
    Store_field(v_record, off++, Val_xid(event->xreparent.parent));
    v_pos =
        caml_tuple2(Val_int(event->xreparent.x), Val_int(event->xreparent.y));
    Store_field(v_record, off++, v_pos);
    Store_field(v_record, off++, Val_bool(event->xreparent.override_redirect));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case ConfigureNotify:
    v_record = caml_alloc(12, 0); // 12 fields
    Store_field(v_record, off++, Val_int(event->xconfigure.serial));
    Store_field(v_record, off++, Val_bool(event->xconfigure.send_event));
    Store_field(v_record, off++, Val_ptr(event->xconfigure.display));
    Store_field(v_record, off++, Val_xid(event->xconfigure.event));
    Store_field(v_record, off++, Val_xid(event->xconfigure.window));
    v_pos =
        caml_tuple2(Val_int(event->xconfigure.x), Val_int(event->xconfigure.y));
    Store_field(v_record, off++, v_pos);
    v_size = caml_tuple2(Val_int(event->xconfigure.width),
                         Val_int(event->xconfigure.height));
    Store_field(v_record, off++, v_size);
    Store_field(v_record, off++, Val_int(event->xconfigure.border_width));
    Store_field(v_record, off++, Val_xid(event->xconfigure.above));
    Store_field(v_record, off++, Val_bool(event->xconfigure.override_redirect));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case PropertyNotify:
    v_record = caml_alloc(7, 0); // 7 fields
    Store_field(v_record, off++, Val_int(event->xproperty.serial));
    Store_field(v_record, off++, Val_bool(event->xproperty.send_event));
    Store_field(v_record, off++, Val_ptr(event->xproperty.display));
    Store_field(v_record, off++, Val_xid(event->xproperty.window));
    Store_field(v_record, off++, Val_xid(event->xproperty.atom));
    Store_field(v_record, off++, Val_xid(event->xproperty.time));
    Store_field(v_record, off++, Val_int(event->xproperty.state));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case ClientMessage:
    CAMLlocal2(v_data, v_array);
    switch (event->xclient.format) {
    case 8:
      v_array = caml_alloc(20, 0); // tag 0 for standard OCaml array
      for (int i = 0; i < 20; i++) {
        Store_field(v_array, i, Val_int(event->xclient.data.b[i]));
      }
      v_data = caml_alloc(1, 0); // tag 0 for Bytes
      Store_field(v_data, 0, v_array);
      break;
    case 16:
      v_array = caml_alloc(10, 0); // tag 0 for standard OCaml array
      for (int i = 0; i < 10; i++) {
        Store_field(v_array, i, Val_int(event->xclient.data.s[i]));
      }
      v_data = caml_alloc(1, 1); // tag 1 for Shorts
      Store_field(v_data, 0, v_array);
      break;
    case 32:
      v_array = caml_alloc(5, 0); // tag 0 for standard OCaml array
      for (int i = 0; i < 5; i++) {
        Store_field(v_array, i, Val_int(event->xclient.data.l[i]));
      }
      v_data = caml_alloc(1, 2); // tag 2 for Longs
      Store_field(v_data, 0, v_array);
      break;

    default:
      caml_failwith_fmt("Invalid ClientMessage format: %d",
                        event->xclient.format);
    }

    v_record = caml_alloc(6, 0); // 7 fields
    Store_field(v_record, off++, Val_int(event->xclient.serial));
    Store_field(v_record, off++, Val_bool(event->xclient.send_event));
    Store_field(v_record, off++, Val_ptr(event->xclient.display));
    Store_field(v_record, off++, Val_xid(event->xclient.window));
    Store_field(v_record, off++, Val_xid(event->xclient.message_type));
    Store_field(v_record, off++, v_data);
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case FocusIn:
    v_record = caml_alloc(6, 0); // 6 fields
    Store_field(v_record, off++, Val_int(event->xfocus.serial));
    Store_field(v_record, off++, Val_bool(event->xfocus.send_event));
    Store_field(v_record, off++, Val_ptr(event->xfocus.display));
    Store_field(v_record, off++, Val_xid(event->xfocus.window));
    Store_field(v_record, off++, Val_int(event->xfocus.mode));
    Store_field(v_record, off++, Val_int(event->xfocus.detail));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  default:
    caml_failwith_fmt("Unsupported event type %d", event->type);
  }
  CAMLreturn(v_event);
}
