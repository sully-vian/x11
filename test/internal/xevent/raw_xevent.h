#ifndef RAW_XEVENT_H
#define RAW_XEVENT_H

#include <X11/Xlib.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

/* Copies [event] to static storage and returns its address as a nativeint, so
   it stays valid after the stub returns. Each call overwrites the previous
   event. */
value raw_xevent(XEvent *event);

#endif
