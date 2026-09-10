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

static inline value wrap_xid(unsigned long id) {
  return caml_copy_nativeint(id);
}
static inline value wrap_ptr(void *ptr) {
  return caml_copy_nativeint((intptr_t)ptr);
}

/* --- OCaml Field Assignment Macros --- */
#define ALLOC_RECORD(n)                                                        \
  v_record = caml_alloc(n, 0);                                                 \
  int _i = 0;

#define FIELD_INT(val) Store_field(v_record, _i++, Val_int(val))
#define FIELD_XID(val) Store_field(v_record, _i++, wrap_xid(val))
#define FIELD_PTR(val) Store_field(v_record, _i++, wrap_ptr(val))
#define FIELD_BOOL(val) Store_field(v_record, _i++, Val_int(val ? 1 : 0))

#define YIELD_EVENT(tag)                                                       \
  v_event = caml_alloc(1, tag);                                                \
  Store_field(v_event, 0, v_record);                                           \
  break;
/* ------------------------------------- */

CAMLprim value x11_event_to_ocaml(XEvent *event) {
  CAMLparam0();
  CAMLlocal2(v_record, v_event);

  switch (event->type) {
  case KeyPress:
  case KeyRelease: {
    XKeyEvent *e = &event->xkey;
    ALLOC_RECORD(14);
    FIELD_INT(e->serial);
    FIELD_BOOL(e->send_event);
    FIELD_PTR(e->display);
    FIELD_XID(e->window);
    FIELD_XID(e->root);
    FIELD_XID(e->subwindow);
    FIELD_XID(e->time);
    FIELD_INT(e->x);
    FIELD_INT(e->y);
    FIELD_INT(e->x_root);
    FIELD_INT(e->y_root);
    FIELD_INT(e->state);
    FIELD_INT(e->keycode);
    FIELD_BOOL(e->same_screen);
    YIELD_EVENT(1); // XKeyEvent tag
  }

  case ButtonPress:
  case ButtonRelease: {
    XButtonEvent *e = &event->xbutton;
    ALLOC_RECORD(14);
    FIELD_INT(e->serial);
    FIELD_BOOL(e->send_event);
    FIELD_PTR(e->display);
    FIELD_XID(e->window);
    FIELD_XID(e->root);
    FIELD_XID(e->subwindow);
    FIELD_XID(e->time);
    FIELD_INT(e->x);
    FIELD_INT(e->y);
    FIELD_INT(e->x_root);
    FIELD_INT(e->y_root);
    FIELD_INT(e->state);
    FIELD_INT(e->button);
    FIELD_BOOL(e->same_screen);
    YIELD_EVENT(2); // XButtonEvent tag
  }

  case MotionNotify: {
    XMotionEvent *e = &event->xmotion;
    ALLOC_RECORD(13);
    FIELD_INT(e->serial);
    FIELD_BOOL(e->send_event);
    FIELD_PTR(e->display);
    FIELD_XID(e->window);
    FIELD_XID(e->root);
    FIELD_XID(e->subwindow);
    FIELD_XID(e->time);
    FIELD_INT(e->x);
    FIELD_INT(e->y);
    FIELD_INT(e->x_root);
    FIELD_INT(e->y_root);
    FIELD_INT(e->state);
    FIELD_BOOL(e->same_screen);
    YIELD_EVENT(3); // XMotionEvent tag
  }

  case Expose: {
    XExposeEvent *e = &event->xexpose;
    ALLOC_RECORD(9);
    FIELD_INT(e->serial);
    FIELD_BOOL(e->send_event);
    FIELD_PTR(e->display);
    FIELD_XID(e->window);
    FIELD_INT(e->x);
    FIELD_INT(e->y);
    FIELD_INT(e->width);
    FIELD_INT(e->height);
    FIELD_INT(e->count);
    YIELD_EVENT(6); // XExposeEvent tag
  }

  case ConfigureNotify: {
    XConfigureEvent *e = &event->xconfigure;
    ALLOC_RECORD(12);
    FIELD_INT(e->serial);
    FIELD_BOOL(e->send_event);
    FIELD_PTR(e->display);
    FIELD_XID(e->event);
    FIELD_XID(e->window);
    FIELD_INT(e->x);
    FIELD_INT(e->y);
    FIELD_INT(e->width);
    FIELD_INT(e->height);
    FIELD_INT(e->border_width);
    FIELD_XID(e->above);
    FIELD_BOOL(e->override_redirect);
    YIELD_EVENT(16); // XConfigureEvent tag
  }

  default:
    caml_failwith_fmt("Unsupported event type %d", event->type);
  }

  CAMLreturn(v_event);
}
