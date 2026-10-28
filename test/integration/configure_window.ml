open X11
open Helpers

let test_geometry () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let win = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      configure_window dpy win
        (window_changes ~x:30 ~y:40 ~width:200 ~height:150 ~border_width:3 ());
      let attr = Option.get (get_window_attributes dpy win) in
      Alcotest.(check (pair int int)) "pos" (30, 40) attr.pos;
      Alcotest.(check (pair int int)) "size" (200, 150) attr.size;
      Alcotest.(check int) "border_width" 3 attr.border_width;
      close_display dpy

(* Fields left at None keep their value *)
let test_one_field () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let win = create_simple_window dpy root (10, 20) (100, 100) 1 0 0 in
      configure_window dpy win (window_changes ~width:300 ());
      let attr = Option.get (get_window_attributes dpy win) in
      Alcotest.(check (pair int int)) "pos" (10, 20) attr.pos;
      Alcotest.(check (pair int int)) "size" (300, 100) attr.size;
      Alcotest.(check int) "border_width" 1 attr.border_width;
      close_display dpy

(* [a] is created first, so it starts below [b] *)
let test_stacking () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let a = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      let b = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      store_name dpy a "x11 configure_window a";
      store_name dpy b "x11 configure_window b";
      let names = [ "x11 configure_window a"; "x11 configure_window b" ] in
      flush dpy;
      Alcotest.(check (list string))
        "initially" (List.rev names) (stacking_order names);
      configure_window dpy a (window_changes ~stacking:(Above, None) ());
      flush dpy;
      Alcotest.(check (list string)) "a raised" names (stacking_order names);
      configure_window dpy a (window_changes ~stacking:(Below, Some b) ());
      flush dpy;
      Alcotest.(check (list string))
        "a just below b" (List.rev names) (stacking_order names);
      close_display dpy

let suite =
  ( "configure_window",
    [
      Alcotest.test_case "geometry" `Quick (with_xvfb test_geometry);
      Alcotest.test_case "one field" `Quick (with_xvfb test_one_field);
      Alcotest.test_case "stacking" `Quick (with_xvfb test_stacking);
    ] )
