#include <X11/Xlib.h>
#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <string.h>

#define caml_None Val_int(0) // None is 0

extern value x11_event_to_ocaml(XEvent *event);

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

CAMLprim value caml_XSelectInput(value v_display, value v_w,
                                 value v_event_mask) {
  CAMLparam3(v_display, v_w, v_event_mask);
  Display *display = (Display *)Field(v_display, 0);
  Window w = (Window)Field(v_w, 0);
  long event_mask = Long_val(v_event_mask);
  XSelectInput(display, w, event_mask);
  CAMLreturn(Val_unit);
}

CAMLprim value caml_XNextEvent(value v_display) {
  CAMLparam1(v_display);
  Display *display = (Display *)Field(v_display, 0);
  XEvent event;

  XNextEvent(display, &event);
  value v_event = x11_event_to_ocaml(&event);
  CAMLreturn(v_event);
}

CAMLprim value caml_XMoveResizeWindow(value v_display, value v_w, value v_pos,
                                      value v_size) {
  CAMLparam4(v_display, v_w, v_pos, v_size);
  Display *display = (Display *)Field(v_display, 0);
  Window w = (Window)Field(v_w, 0);
  int x = Int_val(Field(v_pos, 0));
  int y = Int_val(Field(v_pos, 1));
  unsigned int width = (unsigned int)Int_val(Field(v_size, 0));
  unsigned int height = (unsigned int)Int_val(Field(v_size, 1));
  XMoveResizeWindow(display, w, x, y, width, height);
  CAMLreturn(Val_unit);
}

CAMLprim value caml_XGrabKey(value v_display, value v_keycode,
                             value v_modifiers, value v_grab_window,
                             value v_owner_events, value v_pointer_mode,
                             value v_keyboard_mode) {
  CAMLparam5(v_display, v_keycode, v_modifiers, v_grab_window, v_owner_events);
  CAMLxparam2(v_pointer_mode, v_keyboard_mode);
  Display *display = (Display *)Field(v_display, 0);
  KeyCode keycode = (KeyCode)Int_val(v_keycode);
  unsigned int modifiers = (unsigned int)Int_val(v_modifiers);
  Window grab_window = (Window)Field(v_grab_window, 0);
  Bool owner_events = Bool_val(v_owner_events);
  int pointer_mode = Int_val(v_pointer_mode);
  int keyboard_mode = Int_val(v_keyboard_mode);

  XGrabKey(display, keycode, modifiers, grab_window, owner_events, pointer_mode,
           keyboard_mode);
  CAMLreturn(Val_unit);
}
