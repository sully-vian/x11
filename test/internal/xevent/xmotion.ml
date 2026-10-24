open X11_internal
open Xevent
open Helpers

external get_raw_motion_notify_ev : unit -> nativeint
  = "get_raw_motion_notify_ev"

external get_raw_motion_notify_hint_ev : unit -> nativeint
  = "get_raw_motion_notify_hint_ev"

let test_motion_notify_ev () =
  match xevent_of_raw_address (get_raw_motion_notify_ev ()) with
  | MotionNotify ev ->
      Alcotest.(check int) "serial" 200 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "display" 0x9abc (display_address ev.display);
      Alcotest.(check int) "window" 211 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "root" 212 (Unsigned.ULong.to_int ev.root);
      Alcotest.(check (option int))
        "subwindow" (Some 213)
        (Option.map Unsigned.ULong.to_int ev.subwindow);
      Alcotest.(check int) "time" 3000 (Unsigned.ULong.to_int ev.time);
      Alcotest.(check (pair int int)) "pos" (30, 40) ev.pos;
      Alcotest.(check (pair int int)) "pos_root" (130, 240) ev.pos_root;
      Alcotest.(check int) "state" 2 ev.state;
      Alcotest.(check bool) "is_hint" false ev.is_hint;
      Alcotest.(check bool) "same_screen" true ev.same_screen
  | _ -> Alcotest.fail "Expected MotionNotify event"

let test_motion_notify_hint_ev () =
  match xevent_of_raw_address (get_raw_motion_notify_hint_ev ()) with
  | MotionNotify ev ->
      Alcotest.(check int) "serial" 201 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check (option int))
        "subwindow" None
        (Option.map Unsigned.ULong.to_int ev.subwindow);
      Alcotest.(check (pair int int)) "pos" (31, 41) ev.pos;
      Alcotest.(check int) "state" 256 ev.state;
      Alcotest.(check bool) "is_hint" true ev.is_hint;
      Alcotest.(check bool) "same_screen" true ev.same_screen
  | _ -> Alcotest.fail "Expected MotionNotify event"

let suite =
  let open Alcotest in
  ( "XMotionEvent",
    [
      test_case "MotionNotify" `Quick test_motion_notify_ev;
      test_case "MotionNotify (hint)" `Quick test_motion_notify_hint_ev;
    ] )
