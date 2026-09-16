open X11.Xevent

(* External C functions *)
external get_key_press_event : unit -> xEvent = "get_key_press_event"
external get_key_release_event : unit -> xEvent = "get_key_release_event"
external get_button_press_event : unit -> xEvent = "get_button_press_event"
external get_motion_notify_event : unit -> xEvent = "get_motion_notify_event"
external get_expose_event : unit -> xEvent = "get_expose_event"

(* Helper to convert between abstract types and nativeint for comparison.
   NOTE: The display and window types are abstract in xevent.ml, so we can't
   directly compare them. These bindings should be updated to expose the
   underlying values, or we should use a custom equality function. For now,
   this helper allows manual verification if needed. *)
let to_native : 'a -> nativeint = fun x -> Obj.magic x

let test_key_press_event () =
  match get_key_press_event () with
  | XKeyPress ev ->
      Alcotest.(check int) "serial" ev.serial 42;
      Alcotest.(check bool) "send_event" ev.send_event false;
      (* NOTE: display and window are abstract types, cannot directly compare.
         User should add concrete accessors to xevent.ml or use a custom testable. *)
      Alcotest.(check int) "x" ev.x 10;
      Alcotest.(check int) "y" ev.y 20;
      Alcotest.(check int) "x_root" ev.x_root 100;
      Alcotest.(check int) "y_root" ev.y_root 200;
      Alcotest.(check int) "state" ev.state 0;
      Alcotest.(check int) "keycode" ev.keycode 65;
      Alcotest.(check bool) "same_screen" ev.same_screen true
  | _ -> Alcotest.fail "Expected XKeyPress event"

let test_key_release_event () =
  match get_key_release_event () with
  | XKeyRelease ev ->
      Alcotest.(check int) "serial" ev.serial 42;
      Alcotest.(check bool) "send_event" ev.send_event false;
      (* NOTE: display and window are abstract types, cannot directly compare.
         User should add concrete accessors to xevent.ml or use a custom testable. *)
      Alcotest.(check int) "x" ev.x 10;
      Alcotest.(check int) "y" ev.y 20;
      Alcotest.(check int) "x_root" ev.x_root 100;
      Alcotest.(check int) "y_root" ev.y_root 200;
      Alcotest.(check int) "state" ev.state 0;
      Alcotest.(check int) "keycode" ev.keycode 65;
      Alcotest.(check bool) "same_screen" ev.same_screen true
  | _ -> Alcotest.fail "Expected XKeyRelease event"

let test_button_press_event () =
  match get_button_press_event () with
  | XButtonPress ev ->
      Alcotest.(check int) "serial" ev.serial 100;
      Alcotest.(check bool) "send_event" ev.send_event true;
      (* NOTE: display, window, root, subwindow are abstract types *)
      Alcotest.(check int) "x" ev.x 50;
      Alcotest.(check int) "y" ev.y 75;
      Alcotest.(check int) "x_root" ev.x_root 150;
      Alcotest.(check int) "y_root" ev.y_root 250;
      Alcotest.(check int) "state" ev.state 1;
      Alcotest.(check int) "button" ev.button 1;
      Alcotest.(check bool) "same_screen" ev.same_screen true
  | _ -> Alcotest.fail "Expected XButtonPress event"

let test_motion_notify_event () =
  match get_motion_notify_event () with
  | XMotionNotify ev ->
      Alcotest.(check int) "serial" ev.serial 200;
      Alcotest.(check bool) "send_event" ev.send_event false;
      (* NOTE: display, window, root, subwindow are abstract types *)
      Alcotest.(check int) "x" ev.x 30;
      Alcotest.(check int) "y" ev.y 40;
      Alcotest.(check int) "x_root" ev.x_root 130;
      Alcotest.(check int) "y_root" ev.y_root 240;
      Alcotest.(check int) "state" ev.state 2;
      Alcotest.(check bool) "same_screen" ev.same_screen true
  | _ -> Alcotest.fail "Expected XMotionNotify event"

let test_expose_event () =
  match get_expose_event () with
  | XExpose ev ->
      Alcotest.(check int) "serial" ev.serial 300;
      Alcotest.(check bool) "send_event" ev.send_event true;
      (* NOTE: display and window are abstract types *)
      Alcotest.(check int) "x" ev.x 5;
      Alcotest.(check int) "y" ev.y 15;
      Alcotest.(check int) "width" ev.width 800;
      Alcotest.(check int) "height" ev.height 600;
      Alcotest.(check int) "count" ev.count 0
  | _ -> Alcotest.fail "Expected XExpose event"

let suite =
  let open Alcotest in
  [
    test_case "KeyPress" `Quick test_key_press_event;
    test_case "KeyRelease" `Quick test_key_release_event;
    test_case "ButtonPress" `Quick test_button_press_event;
    test_case "MotionNotify" `Quick test_motion_notify_event;
    test_case "Expose" `Quick test_expose_event;
  ]
