CW flags can be or-ed into a configureWindowMask, which configure_window takes:

  $ cat > configure_window_mask_or.ml <<EOF
  > open X11
  > let m : configureWindowMask = cwX ||| cwY ||| cwWidth ||| cwHeight
  > let f dpy w = configure_window ~value_mask:m dpy w (window_changes ~x:0 ())
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c configure_window_mask_or.ml

A request's mask can be tested and changed before granting it:

  $ cat > configure_request_mask.ml <<EOF
  > open X11
  > let f dpy (ev : configureRequestEvent) =
  >   if ev.value_mask &&& cwStackMode then
  >     configure_window ~value_mask:(ev.value_mask &~ cwStackMode) dpy ev.window
  >       (window_changes ~width:(fst ev.size) ())
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c configure_request_mask.ml

keyPressMask is 1 like cwX, but an event mask isn't a value_mask:

  $ cat > configure_window_event_mask.ml <<EOF
  > open X11
  > let f dpy w = configure_window ~value_mask:keyPressMask dpy w (window_changes ())
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c configure_window_event_mask.ml
  File "configure_window_event_mask.ml", line 2, characters 43-55:
  2 | let f dpy w = configure_window ~value_mask:keyPressMask dpy w (window_changes ())
                                                 ^^^^^^^^^^^^
  Error: The value keyPressMask has type ([> `DeviceEvent ], 'a) X11.mask
         but an expression was expected of type
           ([< `ConfigureWindow ], 'b) X11.mask
         The second variant type does not allow tag(s) `DeviceEvent
  [2]

Nor is a modifier, though shiftMask is 1 too:

  $ cat > configure_window_modifier.ml <<EOF
  > open X11
  > let f dpy w = configure_window ~value_mask:shiftMask dpy w (window_changes ())
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c configure_window_modifier.ml
  File "configure_window_modifier.ml", line 2, characters 43-52:
  2 | let f dpy w = configure_window ~value_mask:shiftMask dpy w (window_changes ())
                                                 ^^^^^^^^^
  Error: The value shiftMask has type ([> `Key ], 'a) X11.mask
         but an expression was expected of type
           ([< `ConfigureWindow ], 'b) X11.mask
         The second variant type does not allow tag(s) `Key
  [2]

And a CW flag isn't an event to select:

  $ cat > select_input_cw.ml <<EOF
  > open X11
  > let f dpy w = select_input dpy w cwX
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c select_input_cw.ml
  File "select_input_cw.ml", line 2, characters 33-36:
  2 | let f dpy w = select_input dpy w cwX
                                       ^^^
  Error: The value cwX has type ([> `ConfigureWindow ], 'a) X11.mask
         but an expression was expected of type
           ([< X11.eventFlags ], 'b) X11.mask
         Type [> `ConfigureWindow ] is not compatible with type
           [< X11.eventFlags ] =
             [< `DeviceEvent | `Event | `PointerDeviceEvent | `PointerEvent ]
         The second variant type does not allow tag(s) `ConfigureWindow
  [2]
