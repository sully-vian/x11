#include "raw_xevent.h"

static XEvent stored_event;

value raw_xevent(XEvent *event) {
  stored_event = *event;
  return caml_copy_nativeint((intnat)&stored_event);
}
