#include <X11/Xlib.h>
#include <caml/alloc.h>
#include <caml/fail.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

void caml_failwith_fmt(const char *fmt, ...) {
  char buffer[256];
  va_list args;
  va_start(args, fmt);
  vsnprintf(buffer, sizeof(buffer), fmt, args);
  va_end(args);
  caml_failwith(buffer);
}

#define WRAP_XID(x) caml_copy_nativeint(x)
#define WRAP_PTR(x) caml_copy_nativeint((intptr_t)x)

CAMLprim value x11_event_to_ocaml(XEvent *event) {
  CAMLparam0();
  CAMLlocal2(v_record, v_event);

  switch (event->type) {
  case KeyPress:
  case KeyRelease:
    v_record = caml_alloc(14, 0); // 14 fields
    Store_field(v_record, 0, Val_int(event->xkey.serial));
    Store_field(v_record, 1, Val_bool(event->xkey.send_event));
    Store_field(v_record, 2, WRAP_PTR(event->xkey.display));
    Store_field(v_record, 3, WRAP_XID(event->xkey.window));
    Store_field(v_record, 4, WRAP_XID(event->xkey.root));
    Store_field(v_record, 5, WRAP_XID(event->xkey.subwindow));
    Store_field(v_record, 6, WRAP_XID(event->xkey.time));
    Store_field(v_record, 7, Val_int(event->xkey.x));
    Store_field(v_record, 8, Val_int(event->xkey.y));
    Store_field(v_record, 9, Val_int(event->xkey.x_root));
    Store_field(v_record, 10, Val_int(event->xkey.y_root));
    Store_field(v_record, 11, Val_int(event->xkey.state));
    Store_field(v_record, 12, Val_int(event->xkey.keycode));
    Store_field(v_record, 13, Val_bool(event->xkey.same_screen));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case ButtonPress:
  case ButtonRelease:
    v_record = caml_alloc(14, 0); //  14 fields
    Store_field(v_record, 0, Val_int(event->xbutton.serial));
    Store_field(v_record, 1, Val_bool(event->xbutton.send_event));
    Store_field(v_record, 2, WRAP_PTR(event->xbutton.display));
    Store_field(v_record, 3, WRAP_XID(event->xbutton.window));
    Store_field(v_record, 4, WRAP_XID(event->xbutton.root));
    Store_field(v_record, 5, WRAP_XID(event->xbutton.subwindow));
    Store_field(v_record, 6, WRAP_XID(event->xbutton.time));
    Store_field(v_record, 7, Val_int(event->xbutton.x));
    Store_field(v_record, 8, Val_int(event->xbutton.y));
    Store_field(v_record, 9, Val_int(event->xbutton.x_root));
    Store_field(v_record, 10, Val_int(event->xbutton.y_root));
    Store_field(v_record, 11, Val_int(event->xbutton.state));
    Store_field(v_record, 12, Val_int(event->xbutton.button));
    Store_field(v_record, 13, Val_bool(event->xbutton.same_screen));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case MotionNotify:
    v_record = caml_alloc(13, 0); // 13 fields
    Store_field(v_record, 0, Val_int(event->xmotion.serial));
    Store_field(v_record, 1, Val_bool(event->xmotion.send_event));
    Store_field(v_record, 2, WRAP_PTR(event->xmotion.display));
    Store_field(v_record, 3, WRAP_XID(event->xmotion.window));
    Store_field(v_record, 4, WRAP_XID(event->xmotion.root));
    Store_field(v_record, 5, WRAP_XID(event->xmotion.subwindow));
    Store_field(v_record, 6, WRAP_XID(event->xmotion.time));
    Store_field(v_record, 7, Val_int(event->xmotion.x));
    Store_field(v_record, 8, Val_int(event->xmotion.y));
    Store_field(v_record, 9, Val_int(event->xmotion.x_root));
    Store_field(v_record, 10, Val_int(event->xmotion.y_root));
    Store_field(v_record, 11, Val_int(event->xmotion.state));
    Store_field(v_record, 12, Val_bool(event->xmotion.same_screen));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case Expose:
    v_record = caml_alloc(9, 0); // 9 fields
    Store_field(v_record, 0, Val_int(event->xexpose.serial));
    Store_field(v_record, 1, Val_bool(event->xexpose.send_event));
    Store_field(v_record, 2, WRAP_PTR(event->xexpose.display));
    Store_field(v_record, 3, WRAP_XID(event->xexpose.window));
    Store_field(v_record, 4, Val_int(event->xexpose.x));
    Store_field(v_record, 5, Val_int(event->xexpose.y));
    Store_field(v_record, 6, Val_int(event->xexpose.width));
    Store_field(v_record, 7, Val_int(event->xexpose.height));
    Store_field(v_record, 8, Val_int(event->xexpose.count));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  case ConfigureNotify:
    v_record = caml_alloc(12, 0); // 12 fields
    Store_field(v_record, 0, Val_int(event->xconfigure.serial));
    Store_field(v_record, 1, Val_bool(event->xconfigure.send_event));
    Store_field(v_record, 2, WRAP_PTR(event->xconfigure.display));
    Store_field(v_record, 3, WRAP_XID(event->xconfigure.event));
    Store_field(v_record, 4, WRAP_XID(event->xconfigure.window));
    Store_field(v_record, 5, Val_int(event->xconfigure.x));
    Store_field(v_record, 6, Val_int(event->xconfigure.y));
    Store_field(v_record, 7, Val_int(event->xconfigure.width));
    Store_field(v_record, 8, Val_int(event->xconfigure.height));
    Store_field(v_record, 9, Val_int(event->xconfigure.border_width));
    Store_field(v_record, 10, WRAP_XID(event->xconfigure.above));
    Store_field(v_record, 11, Val_bool(event->xconfigure.override_redirect));
    v_event = caml_alloc(1, event->type);
    Store_field(v_event, 0, v_record);
    break;

  default:
    caml_failwith_fmt("Unsupported event type %d", event->type);
  }
  CAMLreturn(v_event);
}
