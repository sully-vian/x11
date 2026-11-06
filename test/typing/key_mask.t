Modifiers can be or-ed into a keyMask, which stays or-able:

  $ cat > key_mask_or.ml <<EOF
  > open X11
  > let m : _ keyMask = shiftMask ||| lockMask ||| controlMask
  > let f dpy kc w = grab_key dpy kc (m ||| mod2Mask) w true GrabModeAsync GrabModeAsync
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c key_mask_or.ml

X only accepts anyModifier alone:

  $ cat > any_modifier_union.ml <<EOF
  > open X11
  > let _ = shiftMask ||| anyModifier
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c any_modifier_union.ml
  File "any_modifier_union.ml", line 2, characters 22-33:
  2 | let _ = shiftMask ||| anyModifier
                            ^^^^^^^^^^^
  Error: The value anyModifier has type ([> `Key ], X11.alone) X11.mask
         but an expression was expected of type ([> `Key ], X11.union) X11.mask
         Type X11.alone is not compatible with type X11.union
  [2]

A list can hold it next to sets of modifiers, and each one can be grabbed:

  $ cat > key_mask_list.ml <<EOF
  > open X11
  > let bindings : _ keyMask list = [ anyModifier; shiftMask ||| lockMask ]
  > let f dpy kc w =
  >   List.iter
  >     (fun m -> grab_key dpy kc m w true GrabModeAsync GrabModeAsync)
  >     bindings
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c key_mask_list.ml

But a mask that may be anyModifier can't be or-ed:

  $ cat > key_mask_list_union.ml <<EOF
  > open X11
  > let f (bindings : _ keyMask list) =
  >   List.map (fun m -> m ||| lockMask) (anyModifier :: bindings)
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c key_mask_list_union.ml
  File "key_mask_list_union.ml", line 3, characters 38-49:
  3 |   List.map (fun m -> m ||| lockMask) (anyModifier :: bindings)
                                            ^^^^^^^^^^^
  Error: The value anyModifier has type ([> `Key ], X11.alone) X11.mask
         but an expression was expected of type ([> `Key ], X11.union) X11.mask
         Type X11.alone is not compatible with type X11.union
  [2]

A field of a table of shortcuts is a bindingMask, which can be or-ed and grabbed:

  $ cat > binding_mask_field.ml <<EOF
  > open X11
  > type key = { m : bindingMask }
  > let f dpy kc w k =
  >   grab_key dpy kc (k.m ||| lockMask) w true GrabModeAsync GrabModeAsync
  > let _ = f, { m = mod4Mask ||| shiftMask }
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c binding_mask_field.ml

A type declaration refuses the wildcard:

  $ cat > key_mask_field_wildcard.ml <<EOF
  > open X11
  > type key = { m : _ keyMask }
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c key_mask_field_wildcard.ml
  File "key_mask_field_wildcard.ml", line 2, characters 17-18:
  2 | type key = { m : _ keyMask }
                       ^
  Error: A type wildcard _ is not allowed in this type declaration.
  [2]

Grab modifiers are a SETofKEYMASK, so grab_key refuses a button mask:

  $ cat > grab_key_button.ml <<EOF
  > open X11
  > let f dpy kc w = grab_key dpy kc button1Mask w true GrabModeAsync GrabModeAsync
  > EOF
  $ ocamlc -I ../../lib/.x11.objs/byte -stop-after typing -c grab_key_button.ml
  File "grab_key_button.ml", line 2, characters 33-44:
  2 | let f dpy kc w = grab_key dpy kc button1Mask w true GrabModeAsync GrabModeAsync
                                       ^^^^^^^^^^^
  Error: The value button1Mask has type ([> `Button ], 'a) X11.mask
         but an expression was expected of type ([ `Key ], 'b) X11.mask
         The second variant type does not allow tag(s) `Button
  [2]
