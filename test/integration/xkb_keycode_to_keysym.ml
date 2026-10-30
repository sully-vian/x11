open X11
open Helpers

let check name expected actual =
  Alcotest.(check bool) name true (actual = expected)

(* The default keymap is us: the a key has a at level 0 and A at level 1 *)
let test_levels () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let a = Option.get (keysym_to_keycode dpy xk_a) in
      check "level 0" (Some xk_a) (xkb_keycode_to_keysym dpy a 0 0);
      check "level 1" (Some xk_A) (xkb_keycode_to_keysym dpy a 0 1);
      close_display dpy

(* What sowm does: the keycode of a KeyPress, at group 0 and level 0 *)
let test_key_press () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      select_input dpy root keyPressMask;
      flush dpy;
      let keycode = pressed_keycode dpy "Return" in
      check "Return" (Some xk_Return) (xkb_keycode_to_keysym dpy keycode 0 0);
      close_display dpy

(* The default keymap has one group, and two levels for the a key *)
let test_out_of_range () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let a = Option.get (keysym_to_keycode dpy xk_a) in
      check "group" None (xkb_keycode_to_keysym dpy a 3 0);
      check "level" None (xkb_keycode_to_keysym dpy a 0 7);
      close_display dpy

let suite =
  ( "xkb_keycode_to_keysym",
    [
      Alcotest.test_case "shift levels" `Quick (with_xvfb test_levels);
      Alcotest.test_case "KeyPress" `Quick (with_xvfb test_key_press);
      Alcotest.test_case "out of range" `Quick (with_xvfb test_out_of_range);
    ] )
