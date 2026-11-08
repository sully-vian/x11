CW flags can be or-ed into a configureWindowMask:

  $ cat > configure_window_mask_or.ml <<EOF
  > open X11
  > let _ : configureWindowMask = cwX ||| cwY ||| cwWidth ||| cwHeight
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c configure_window_mask_or.ml

A request's mask can be tested and changed:

  $ cat > configure_request_mask.ml <<EOF
  > open X11
  > let f (ev : configureRequestEvent) =
  >   if ev.value_mask &&& cwStackMode then ev.value_mask &~ cwStackMode
  >   else ev.value_mask
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c configure_request_mask.ml

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
