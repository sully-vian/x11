#include "utils.h"
#include <X11/Xlib.h>
#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#define caml_None Val_int(0) // None is 0

extern value Val_xevent(XEvent *);
extern value Val_xwindowattributes(XWindowAttributes *);

CAMLprim value caml_XNextEvent(value v_display) {
  CAMLparam1(v_display);
  Display *display = (Display *)Field(v_display, 0);
  XEvent event;

  XNextEvent(display, &event);
  value v_event = Val_xevent(&event);
  CAMLreturn(v_event);
}

CAMLprim value caml_XGetWindowAttributes(value v_display, value v_window) {
  CAMLparam2(v_display, v_window);
  Display *display = (Display *)Field(v_display, 0);
  Window window = (Window)Field(v_window, 0);
  XWindowAttributes attributes;
  XGetWindowAttributes(display, window, &attributes);
  value v_attributes = Val_xwindowattributes(&attributes);
  CAMLreturn(v_attributes);
}
