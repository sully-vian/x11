Device event flags can be or-ed into a deviceEventMask, with noEventMask:

  $ cat > device_event_mask_or.ml <<EOF
  > open X11
  > let _ : deviceEventMask =
  >   keyPressMask ||| buttonReleaseMask ||| pointerMotionMask ||| noEventMask
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c device_event_mask_or.ml

do_not_propagate_mask is a SETofDEVICEEVENT, so it holds no crossing events:

  $ cat > do_not_propagate_crossing.ml <<EOF
  > open X11
  > let f (a : windowAttributes) = a.do_not_propagate_mask &&& enterWindowMask
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c do_not_propagate_crossing.ml
  File "do_not_propagate_crossing.ml", line 2, characters 59-74:
  2 | let f (a : windowAttributes) = a.do_not_propagate_mask &&& enterWindowMask
                                                                 ^^^^^^^^^^^^^^^
  Error: The value enterWindowMask has type [> `PointerEvent ] X11.mask
         but an expression was expected of type
           [ `DeviceEvent | `PointerDeviceEvent ] X11.mask
         The second variant type does not allow tag(s) `PointerEvent
  [2]
