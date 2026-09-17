#include <X11/Xlib.h>
#include <caml/alloc.h>
#include <caml/fail.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#define caml_None Val_int(0) // None is 0

CAMLprim value caml_XOpenDisplay(value v_display_name) {
  CAMLparam1(v_display_name);
  CAMLlocal2(v_display, v_res);

  const char *display_name = NULL;

  if (v_display_name != caml_None) {
    // Some(x) is a block where Field(foo,0) is x
    display_name = String_val(Field(v_display_name, 0));
  }

  Display *res = XOpenDisplay(display_name);

  if (res == NULL) {
    CAMLreturn(caml_None);
  }

  // wrap pointer as abstract OCaml value
  v_display = caml_alloc(1, Abstract_tag);
  Field(v_display, 0) = (value)res;

  // wrap abstract OCaml value in a `Some`
  v_res = caml_alloc(1, 0);
  Field(v_res, 0) = v_display;

  CAMLreturn(v_res);
}

CAMLprim value caml_XCloseDisplay(value v_display) {
  CAMLparam1(v_display);
  Display *display = (Display *)Field(v_display, 0);
  XCloseDisplay(display);
  CAMLreturn(Val_unit);
}
