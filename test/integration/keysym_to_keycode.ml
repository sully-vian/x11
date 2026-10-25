open X11
open Helpers

(* The keycode xdotool's key press reports for [key] *)
let pressed_keycode dpy key =
  ignore (Sys.command ("xdotool key " ^ key));
  let rec next () =
    match next_event dpy with KeyPress k -> k.keycode | _ -> next ()
  in
  next ()

let test_mapped () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      select_input dpy root keyPressMask;
      flush dpy;
      Alcotest.(check bool)
        "a" true
        (keysym_to_keycode dpy xk_a = Some (pressed_keycode dpy "a"));
      close_display dpy

(* A Unicode keysym (U+263A, a smiling face) that no key of the default
   keyboard mapping produces *)
let test_unmapped () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let keysym = Option.get (string_to_keysym "U263A") in
      Alcotest.(check bool)
        "U263A" true
        (Option.is_none (keysym_to_keycode dpy keysym));
      close_display dpy

let suite =
  ( "keysym_to_keycode",
    [
      Alcotest.test_case "mapped keysym" `Quick (with_xvfb test_mapped);
      Alcotest.test_case "unmapped keysym" `Quick (with_xvfb test_unmapped);
    ] )
