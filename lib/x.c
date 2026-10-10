#include "utils.h"
#include <X11/Xlib.h>
#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#define caml_None Val_int(0) // None is 0

extern value Val_xwindowattributes(XWindowAttributes *);

CAMLprim value caml_XGetWindowAttributes(value v_display, value v_window) {
  CAMLparam2(v_display, v_window);
  Display *display = (Display *)Field(v_display, 0);
  Window window = (Window)Field(v_window, 0);
  XWindowAttributes attributes;
  XGetWindowAttributes(display, window, &attributes);
  value v_attributes = Val_xwindowattributes(&attributes);
  CAMLreturn(v_attributes);
}
