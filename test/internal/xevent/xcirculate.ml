open X11_internal
open Xevent
open Helpers

external get_raw_circulate_notify_bottom_ev : unit -> nativeint
  = "get_raw_circulate_notify_bottom_ev"

external get_raw_circulate_notify_top_ev : unit -> nativeint
  = "get_raw_circulate_notify_top_ev"

(* XCirculateSubwindowsDown lowered the topmost child, seen on the parent *)
let test_circulate_notify_bottom_ev () =
  match xevent_of_raw_address (get_raw_circulate_notify_bottom_ev ()) with
  | Circulate ev ->
      Alcotest.(check int) "serial" 370 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "display" 0x333B (display_address ev.display);
      Alcotest.(check int) "event" 3701 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 3702 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check bool) "place" true (ev.place = PlaceOnBottom)
  | _ -> Alcotest.fail "Expected Circulate event"

(* XCirculateSubwindowsUp raised the lowest child, seen on that child *)
let test_circulate_notify_top_ev () =
  match xevent_of_raw_address (get_raw_circulate_notify_top_ev ()) with
  | Circulate ev ->
      Alcotest.(check int) "serial" 371 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "display" 0x333C (display_address ev.display);
      Alcotest.(check int) "event" 3703 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 3703 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check bool) "place" true (ev.place = PlaceOnTop)
  | _ -> Alcotest.fail "Expected Circulate event"

let suite =
  let open Alcotest in
  ( "XCirculateEvent",
    [
      test_case "CirculateNotify (bottom)" `Quick
        test_circulate_notify_bottom_ev;
      test_case "CirculateNotify (top)" `Quick test_circulate_notify_top_ev;
    ] )
