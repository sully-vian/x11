open X11
open Helpers

(* The state of the next KeyPress of [keycode], skipping other events *)
let rec key_press_state dpy keycode =
  match next_event dpy with
  | KeyPress k when k.keycode = keycode -> k.state
  | _ -> key_press_state dpy keycode

(* The state of the next MotionNotify to [pos], skipping other events *)
let rec motion_state dpy pos =
  match next_event dpy with
  | MotionNotify m when m.pos_root = pos -> m.state
  | _ -> motion_state dpy pos

let test_control_held () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      select_input dpy root keyPressMask;
      flush dpy;
      ignore (Sys.command "xdotool key ctrl+a");
      let state = key_press_state dpy (keysym_to_keycode dpy xk_a) in
      Alcotest.(check bool) "control" true (state &&& controlMask);
      Alcotest.(check bool) "shift" false (state &&& shiftMask);
      Alcotest.(check bool) "button 1" false (state &&& button1Mask);
      close_display dpy

(* Dragging: the motion reports the button held down *)
let test_button_held () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      select_input dpy root pointerMotionMask;
      flush dpy;
      ignore
        (Sys.command
           "xdotool mousemove 10 10 mousedown 1 mousemove 50 50 mouseup 1");
      let state = motion_state dpy (50, 50) in
      Alcotest.(check bool) "button 1" true (state &&& button1Mask);
      Alcotest.(check bool) "button 2" false (state &&& button2Mask);
      Alcotest.(check bool) "control" false (state &&& controlMask);
      close_display dpy

let suite =
  ( "event state",
    [
      Alcotest.test_case "control held" `Quick (with_xvfb test_control_held);
      Alcotest.test_case "button held" `Quick (with_xvfb test_button_held);
    ] )
