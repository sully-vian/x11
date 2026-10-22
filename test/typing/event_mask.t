Event flags can be or-ed into an eventMask, with noEventMask:

  $ cat > event_mask_or.ml <<EOF
  > open X11
  > let _ : eventMask =
  >   button3MotionMask ||| button4MotionMask ||| focusChangeMask ||| noEventMask
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c event_mask_or.ml

Every kind of event flag fits a SETofEVENT:

  $ cat > event_mask_all_tags.ml <<EOF
  > open X11
  > let _ : eventMask =
  >   keyPressMask ||| buttonPressMask ||| enterWindowMask ||| exposureMask
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c event_mask_all_tags.ml

A modifier isn't an event, so select_input refuses it:

  $ cat > select_input_modifier.ml <<EOF
  > open X11
  > let f dpy w = select_input dpy w shiftMask
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c select_input_modifier.ml
  File "select_input_modifier.ml", line 2, characters 33-42:
  2 | let f dpy w = select_input dpy w shiftMask
                                       ^^^^^^^^^
  Error: The value shiftMask has type [> `Key ] X11.mask
         but an expression was expected of type
           X11.eventMask =
             [ `DeviceEvent | `Event | `PointerDeviceEvent | `PointerEvent ]
             X11.mask
         The second variant type does not allow tag(s) `Key
  [2]
