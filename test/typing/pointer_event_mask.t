Pointer event flags can be or-ed into a pointerEventMask, with noEventMask:

  $ cat > pointer_event_mask_or.ml <<EOF
  > open X11
  > let _ : _ pointerEventMask =
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
  Error: The value keyPressMask has type ([> `DeviceEvent ], 'a) X11.mask
         but an expression was expected of type
           ([< X11.pointerEventFlags ], 'b) X11.mask
         Type [> `DeviceEvent ] is not compatible with type
           [< X11.pointerEventFlags ] =
             [< `PointerDeviceEvent | `PointerEvent ]
         The second variant type does not allow tag(s) `DeviceEvent
  [2]

A pointerEventMask goes to a grab and, extended, to a selection, with no coercion:

  $ cat > pointer_event_mask_extended.ml <<EOF
  > open X11
  > let click : _ pointerEventMask = buttonPressMask ||| buttonReleaseMask
  > let f dpy w =
  >   grab_button dpy button1 controlMask w true click GrabModeAsync GrabModeAsync
  >     None None;
  >   select_input dpy w (click ||| exposureMask)
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c pointer_event_mask_extended.ml

Once extended, it no longer fits the grab:

  $ cat > pointer_event_mask_extended_grab.ml <<EOF
  > open X11
  > let click : _ pointerEventMask = buttonPressMask ||| buttonReleaseMask
  > let f dpy w =
  >   grab_button dpy button1 controlMask w true (click ||| exposureMask)
  >     GrabModeAsync GrabModeAsync None None
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c pointer_event_mask_extended_grab.ml
  File "pointer_event_mask_extended_grab.ml", line 4, characters 45-69:
  4 |   grab_button dpy button1 controlMask w true (click ||| exposureMask)
                                                   ^^^^^^^^^^^^^^^^^^^^^^^^
  Error: This expression has type
           ([> `Event | `PointerDeviceEvent | `PointerEvent ], 'a) X11.mask
         but an expression was expected of type
           ([< X11.pointerEventFlags ], 'b) X11.mask
         Type [> `Event | `PointerDeviceEvent | `PointerEvent ]
         is not compatible with type
           [< X11.pointerEventFlags ] =
             [< `PointerDeviceEvent | `PointerEvent ]
         The second variant type does not allow tag(s) `Event
  [2]

A function's argument has one type, so it can't do both. The caller builds the
selection instead:

  $ cat > function_argument_both.ml <<EOF
  > open X11
  > let f dpy w click =
  >   grab_button dpy button1 controlMask w true click GrabModeAsync GrabModeAsync
  >     None None;
  >   select_input dpy w (click ||| exposureMask)
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c function_argument_both.ml
  File "function_argument_both.ml", line 5, characters 32-44:
  5 |   select_input dpy w (click ||| exposureMask)
                                      ^^^^^^^^^^^^
  Error: The value exposureMask has type ([> `Event ], 'a) X11.mask
         but an expression was expected of type
           ([< X11.pointerEventFlags ], X11.union) X11.mask
         Type [> `Event ] is not compatible with type
           [< X11.pointerEventFlags ] =
             [< `PointerDeviceEvent | `PointerEvent ]
         The second variant type does not allow tag(s) `Event
  [2]
