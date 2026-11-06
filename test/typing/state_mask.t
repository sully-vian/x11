Modifiers and button masks can be or-ed into a stateMask:

  $ cat > state_mask_or.ml <<EOF
  > open X11
  > let _ : stateMask = shiftMask ||| controlMask ||| button1Mask
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c state_mask_or.ml

Removing flags keeps the type of the mask, so it still fits its field:

  $ cat > state_mask_diff.ml <<EOF
  > open X11
  > let f (ev : keyEvent) : stateMask = ev.state &~ (lockMask ||| button1Mask)
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c state_mask_diff.ml

An event's state may hold buttons, so a grab refuses it:

  $ cat > grab_key_state.ml <<EOF
  > open X11
  > let f dpy kc w (ev : keyEvent) =
  >   grab_key dpy kc ev.state w true GrabModeAsync GrabModeAsync
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c grab_key_state.ml
  File "grab_key_state.ml", line 3, characters 18-26:
  3 |   grab_key dpy kc ev.state w true GrabModeAsync GrabModeAsync
                        ^^^^^^^^
  Error: The field access ev.state has type
           X11.stateMask = ([ `Button | `Key ], X11.union) X11.mask
         but an expression was expected of type ([ `Key ], 'a) X11.mask
         The second variant type does not allow tag(s) `Button
  [2]

&. keeps only modifiers, so its result fits a grab:

  $ cat > grab_key_and_dot.ml <<EOF
  > open X11
  > let f dpy kc w (ev : keyEvent) =
  >   grab_key dpy kc (ev.state &. (mod4Mask ||| shiftMask)) w true GrabModeAsync
  >     GrabModeAsync
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c grab_key_and_dot.ml

It keeps modifiers, not events:

  $ cat > and_dot_event.ml <<EOF
  > open X11
  > let f (ev : keyEvent) = ev.state &. exposureMask
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c and_dot_event.ml
  File "and_dot_event.ml", line 2, characters 36-48:
  2 | let f (ev : keyEvent) = ev.state &. exposureMask
                                          ^^^^^^^^^^^^
  Error: The value exposureMask has type ([> `Event ], 'a) X11.mask
         but an expression was expected of type ([< `Key ], 'b) X11.mask
         The second variant type does not allow tag(s) `Event
  [2]

And a state's flags aren't an event mask's:

  $ cat > and_dot_event_left.ml <<EOF
  > open X11
  > let _ = keyPressMask &. shiftMask
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c and_dot_event_left.ml
  File "and_dot_event_left.ml", line 2, characters 8-20:
  2 | let _ = keyPressMask &. shiftMask
              ^^^^^^^^^^^^
  Error: The value keyPressMask has type ([> `DeviceEvent ], 'a) X11.mask
         but an expression was expected of type
           ([< `Button | `Key ], 'b) X11.mask
         The second variant type does not allow tag(s) `DeviceEvent
  [2]

Its result may be anyModifier if its second operand may, so it can't be or-ed:

  $ cat > and_dot_any_modifier.ml <<EOF
  > open X11
  > let _ = (anyModifier &. anyModifier) ||| shiftMask
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c and_dot_any_modifier.ml
  File "and_dot_any_modifier.ml", line 2, characters 8-36:
  2 | let _ = (anyModifier &. anyModifier) ||| shiftMask
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Error: This expression has type ([> `Key ], X11.alone) X11.mask
         but an expression was expected of type ([> `Key ], X11.union) X11.mask
         Type X11.alone is not compatible with type X11.union
  [2]

It takes a binding that may be anyModifier, as &&& and &~ do. Comparing with
anyModifier is allowed even though the state never holds it:

  $ cat > state_any_modifier.ml <<EOF
  > open X11
  > let f (ev : keyEvent) (m : _ keyMask) = (ev.state &. m, m &~ lockMask, m &&& lockMask)
  > let g (ev : keyEvent) = ev.state &&& anyModifier
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c state_any_modifier.ml
