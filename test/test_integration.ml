open X11

let display_name = ":99"

let with_xvfb f () =
  Unix.putenv "DISPLAY" display_name;
  let pid =
    Unix.create_process "Xvfb" [| "Xvfb"; display_name |] Unix.stdin Unix.stdout
      Unix.stderr
  in
  Unix.sleep 1;
  let cleanup () =
    (try Unix.kill pid Sys.sigterm with _ -> ());
    ignore (try Unix.waitpid [] pid with _ -> (pid, Unix.WEXITED 0))
  in

  let result =
    try f ()
    with exn ->
      cleanup ();
      raise exn
  in
  cleanup ();
  result

let check_key dpy key_str expected_keysym =
  let cmd = Printf.sprintf "xdotool key %s" key_str in
  let _ = Sys.command cmd in
  let expected_code = keysym_to_keycode dpy expected_keysym in

  let ev_press = next_event dpy in
  (match ev_press with
  | KeyPress k ->
      Alcotest.(check bool)
        (Printf.sprintf "KeyPress keycode match for '%s'" key_str)
        true
        (expected_code = k.keycode)
  | _ ->
      Alcotest.fail (Printf.sprintf "Expected KeyPress event for '%s'" key_str));

  let ev_release = next_event dpy in
  match ev_release with
  | KeyRelease k ->
      Alcotest.(check bool)
        (Printf.sprintf "Keyrelease keycode match for '%s'" key_str)
        true
        (expected_code = k.keycode)
  | _ ->
      Alcotest.fail
        (Printf.sprintf "Expected KeyRelease event for '%s'" key_str)

let test_xdotool () =
  match open_display (Some display_name) with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      select_input dpy root (keyPressMask ||| keyReleaseMask);
      flush dpy;

      check_key dpy "a" xk_a;
      check_key dpy "z" xk_z;
      check_key dpy "1" xk_1;
      check_key dpy "0" xk_0;
      check_key dpy "space" xk_space;
      check_key dpy "Return" xk_Return;
      check_key dpy "Escape" xk_Escape;
      check_key dpy "Delete" xk_Delete;
      check_key dpy "BackSpace" xk_BackSpace;
      check_key dpy "Tab" xk_Tab;
      check_key dpy "Linefeed" xk_Linefeed;
      check_key dpy "Pause" xk_Pause;
      check_key dpy "Scroll_Lock" xk_Scroll_Lock;
      close_display dpy

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

(* Number of windows whose name is exactly [name] *)
let windows_named name =
  let ic =
    Unix.open_process_in
      (Printf.sprintf "xdotool search --name %s"
         (Filename.quote ("^" ^ name ^ "$")))
  in
  let ids = In_channel.input_all ic in
  ignore (Unix.close_process_in ic);
  String.split_on_char '\n' ids |> List.filter (( <> ) "") |> List.length

let test_store_name () =
  match open_display (Some display_name) with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let win = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      store_name dpy win "x11 store_name test";
      flush dpy;
      Alcotest.(check int)
        "windows with that name" 1
        (windows_named "x11 store_name test");
      close_display dpy

(* The name is stored as given: searching for a longer one finds nothing *)
let test_store_name_other () =
  match open_display (Some display_name) with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let win = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      store_name dpy win "x11 store_name test";
      flush dpy;
      Alcotest.(check int)
        "windows with another name" 0
        (windows_named "x11 store_name test 2");
      close_display dpy

let () =
  let open Alcotest in
  run "X11 Integration"
    [
      ("xdotool", [ test_case "xdotool" `Quick (with_xvfb test_xdotool) ]);
      ( "window attributes",
        [ test_case "root" `Quick (with_xvfb test_root_window_attributes) ] );
      ( "window name",
        [
          test_case "store_name" `Quick (with_xvfb test_store_name);
          test_case "store_name (other name)" `Quick
            (with_xvfb test_store_name_other);
        ] );
    ]
