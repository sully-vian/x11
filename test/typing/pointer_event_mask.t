Pointer event flags can be or-ed into a pointerEventMask, with noEventMask:

  $ cat > pointer_event_mask_or.ml <<EOF
  > open X11
  > let _ : pointerEventMask =
  >   buttonPressMask ||| enterWindowMask ||| pointerMotionHintMask ||| noEventMask
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c pointer_event_mask_or.ml

A pointer grab reports a SETofPOINTEREVENT, so grab_button refuses a key event:

  $ cat > grab_button_key_event.ml <<EOF
  > open X11
  > let f dpy w =
  >   grab_button dpy button1 controlMask w true keyPressMask GrabModeAsync
  >     GrabModeAsync None None
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c grab_button_key_event.ml
  File "grab_button_key_event.ml", line 3, characters 45-57:
  3 |   grab_button dpy button1 controlMask w true keyPressMask GrabModeAsync
                                                   ^^^^^^^^^^^^
  Error: The value keyPressMask has type [> `DeviceEvent ] X11.mask
         but an expression was expected of type
           X11.pointerEventMask =
             [ `PointerDeviceEvent | `PointerEvent ] X11.mask
         The second variant type does not allow tag(s) `DeviceEvent
  [2]
