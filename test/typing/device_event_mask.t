Device event flags can be or-ed into a deviceEventMask, with noEventMask:

  $ cat > device_event_mask_or.ml <<EOF
  > open X11
  > let _ : _ deviceEventMask =
  >   keyPressMask ||| buttonReleaseMask ||| pointerMotionMask ||| noEventMask
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c device_event_mask_or.ml

do_not_propagate_mask is a SETofDEVICEEVENT, which holds key events, so a pointer
grab refuses it:

  $ cat > do_not_propagate_grab.ml <<EOF
  > open X11
  > let f dpy w (a : windowAttributes) =
  >   grab_button dpy button1 controlMask w true a.do_not_propagate_mask GrabModeAsync
  >     GrabModeAsync None None
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c do_not_propagate_grab.ml
  File "do_not_propagate_grab.ml", line 3, characters 45-68:
  3 |   grab_button dpy button1 controlMask w true a.do_not_propagate_mask GrabModeAsync
                                                   ^^^^^^^^^^^^^^^^^^^^^^^
  Error: The field access a.do_not_propagate_mask has type
           ([> X11.deviceEventFlags ], X11.union) X11.mask
         but an expression was expected of type
           ([< X11.pointerEventFlags ], 'a) X11.mask
         Type
           [> X11.deviceEventFlags ] = [> `DeviceEvent | `PointerDeviceEvent ]
         is not compatible with type
           [< X11.pointerEventFlags ] =
             [< `PointerDeviceEvent | `PointerEvent ]
         The second variant type does not allow tag(s) `DeviceEvent
  [2]

It's still extended into a selection, with no coercion:

  $ cat > do_not_propagate_selection.ml <<EOF
  > open X11
  > let f dpy w (a : windowAttributes) =
  >   select_input dpy w (a.do_not_propagate_mask ||| exposureMask)
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c do_not_propagate_selection.ml
