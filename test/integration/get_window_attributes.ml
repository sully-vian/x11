open X11
open Helpers

let test_root_window_attributes () =
  match open_display (Some display_name) with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy -> (
      let root = default_root_window dpy in
      match get_window_attributes dpy root with
      | None -> Alcotest.fail "Expected attributes for the root window"
      | Some attributes ->
          (* Xvfb's default screen *)
          Alcotest.(check (pair int int)) "size" (1280, 1024) attributes.size;
          Alcotest.(check (pair int int)) "pos" (0, 0) attributes.pos;
          Alcotest.(check bool) "root" true (attributes.root = root);
          Alcotest.(check bool) "c_class" true (attributes.c_class = InputOutput);
          Alcotest.(check bool)
            "map_state" true
            (attributes.map_state = IsViewable);
          close_display dpy)

let suite =
  ( "get_window_attributes",
    [ Alcotest.test_case "root" `Quick (with_xvfb test_root_window_attributes) ]
  )
