Modifiers and anyModifier can be or-ed into a keyMask:

  $ cat > key_mask_or.ml <<EOF
  > open X11
  > let _ : keyMask = shiftMask ||| lockMask ||| controlMask ||| anyModifier
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c key_mask_or.ml

Grab modifiers are a SETofKEYMASK, so grab_key refuses a button mask:

  $ cat > grab_key_button.ml <<EOF
  > open X11
  > let f dpy kc w = grab_key dpy kc button1Mask w true GrabModeAsync GrabModeAsync
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c grab_key_button.ml
  File "grab_key_button.ml", line 2, characters 33-44:
  2 | let f dpy kc w = grab_key dpy kc button1Mask w true GrabModeAsync GrabModeAsync
                                       ^^^^^^^^^^^
  Error: The value button1Mask has type [> `Button ] X11.mask
         but an expression was expected of type
           X11.keyMask = [ `Any | `Key ] X11.mask
         The second variant type does not allow tag(s) `Button
  [2]
