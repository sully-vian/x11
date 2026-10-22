Modifiers and button masks can be or-ed into a stateMask:

  $ cat > state_mask_or.ml <<EOF
  > open X11
  > let _ : stateMask = shiftMask ||| controlMask ||| button1Mask
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c state_mask_or.ml

anyModifier only exists in grabs, never in an event state:

  $ cat > state_any_modifier.ml <<EOF
  > open X11
  > let f (ev : keyEvent) = ev.state &&& anyModifier
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c state_any_modifier.ml
  File "state_any_modifier.ml", line 2, characters 37-48:
  2 | let f (ev : keyEvent) = ev.state &&& anyModifier
                                           ^^^^^^^^^^^
  Error: The value anyModifier has type [> `Any ] X11.mask
         but an expression was expected of type [ `Button | `Key ] X11.mask
         The second variant type does not allow tag(s) `Any
  [2]
