open X11

let display_name = ":99"

let with_xvfb f =
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

let suite =
  let open Alcotest in
  [ test_case "xdotool" `Quick (fun () -> with_xvfb test_xdotool) ]
