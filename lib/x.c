#include "ctypes_cstubs_internals.h"
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
  CAMLlocal1(v_event);

  // 1. Unwrap the outer block (Tag 0, Size 1)
  value inner_block = Field(v_display, 0);

  // 2. Access the second field of the inner block (Tag 0, Size 3)
  value custom_block = Field(inner_block, 1);

  // 3. Extract the data pointer from the custom block (Tag 255) and dereference
  // it
  Display *display = *(Display **)Data_custom_val(custom_block);
  printf("display: %p\n", display);
  Display *display2 =
      *(Display **)Data_custom_val(Field(Field(v_display, 0), 1));
  printf("display2: %p\n", display2);
  Display *display3 =
      *(Display **)((void *)(((value *)((((volatile value *)(( // expanded macros
                                 ((volatile value *)(v_display))[0])))[1]))) +
                             1));
  printf("display3: %p\n", display3);
  Display *display4 = (Display *)CTYPES_ADDR_OF_FATPTR(
      v_display); // macro used in generated stubs
  printf("display4: %p\n", display4);
  Display *display5 = (Display *)((void *)(*((intnat *)(( // expanded macro
      void *)(((value *)((((volatile value *)(v_display))[1]))) + 1)))));
  printf("display5: %p\n", display5);

  // Fetch the event using the correctly unwrapped raw C pointer
  XEvent event;
  XNextEvent(display3, &event);

  // Assuming you have Val_xevent implemented somewhere
  v_event = Val_xevent(&event);

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

CAMLprim value caml_XCloseDisplay(value v_display) {
  printf("unwrapping fat pointer\n");
  void *display = CTYPES_ADDR_OF_FATPTR(v_display);
  printf("calling XCloseDisplay\n");
  XCloseDisplay(display);
  return Val_unit;
}
