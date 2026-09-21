#include <X11/Xlib.h>
#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <string.h>

#define caml_None Val_int(0) // None is 0

extern value x11_event_to_ocaml(XEvent *event);

CAMLprim value caml_XNextEvent(value v_display) {
  CAMLparam1(v_display);
  Display *display = (Display *)Field(v_display, 0);
  XEvent event;

  XNextEvent(display, &event);
  value v_event = x11_event_to_ocaml(&event);
  CAMLreturn(v_event);
}
