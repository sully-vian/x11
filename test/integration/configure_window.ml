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

(* A window manager grants a client's resize as C does, with every field and
   the request's mask: the window keeps its position and its place in the
   stack. Without the mask, the stack mode, Above when the request gives none,
   would raise it. *)
let test_grant_request () =
  match (open_display None, open_display None) with
  | Some wm, Some client ->
      let root = default_root_window wm in
      select_input wm root substructureRedirectMask;
      flush wm;
      let client_root = default_root_window client in
      let a =
        create_simple_window client client_root (10, 20) (100, 100) 0 0 0
      in
      let b = create_simple_window client client_root (0, 0) (100, 100) 0 0 0 in
      store_name client a "x11 granted a";
      store_name client b "x11 granted b";
      let names = [ "x11 granted b"; "x11 granted a" ] in
      configure_window client a (window_changes ~width:300 ());
      flush client;
      let rec request () =
        match next_event wm with ConfigureRequest ev -> ev | _ -> request ()
      in
      let ev = request () in
      Alcotest.(check bool) "requested" true (ev.value_mask = cwWidth);
      configure_window ~value_mask:ev.value_mask wm ev.window
        (window_changes ~x:(fst ev.pos) ~y:(snd ev.pos) ~width:(fst ev.size)
           ~height:(snd ev.size) ~border_width:ev.border_width
           ~stacking:(ev.detail, ev.above) ());
      let attr = Option.get (get_window_attributes wm a) in
      Alcotest.(check (pair int int)) "size" (300, 100) attr.size;
      Alcotest.(check (pair int int)) "pos" (10, 20) attr.pos;
      Alcotest.(check (list string)) "stacking" names (stacking_order names);
      close_display client;
      close_display wm
  | _ -> Alcotest.fail "Could not open display. Is Xvfb running?"

let suite =
  ( "configure_window",
    [
      Alcotest.test_case "geometry" `Quick (with_xvfb test_geometry);
      Alcotest.test_case "one field" `Quick (with_xvfb test_one_field);
      Alcotest.test_case "stacking" `Quick (with_xvfb test_stacking);
      Alcotest.test_case "granted request" `Quick (with_xvfb test_grant_request);
    ] )
