open X11_internal
open Xevent
open Helpers

external get_raw_enter_notify_ev : unit -> nativeint = "get_raw_enter_notify_ev"
external get_raw_leave_notify_ev : unit -> nativeint = "get_raw_leave_notify_ev"

let test_enter_notify_ev () =
  match xevent_of_raw_address (get_raw_enter_notify_ev ()) with
  | EnterNotify ev ->
      Alcotest.(check int) "serial" 400 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check (option int))
        "subwindow" (Some 4003)
        (Option.map Unsigned.ULong.to_int ev.subwindow);
      Alcotest.(check (pair int int)) "pos" (12, 34) ev.pos;
      Alcotest.(check (pair int int)) "pos_root" (112, 134) ev.pos_root;
      Alcotest.(check bool) "mode" true (ev.mode = NotifyGrab);
      Alcotest.(check bool) "detail" true (ev.detail = NotifyInferior);
      Alcotest.(check bool) "same_screen" true ev.same_screen;
      Alcotest.(check bool) "focus" true ev.focus;
      Alcotest.(check int) "state" 4 ev.state
  | _ -> Alcotest.fail "Expected EnterNotify event"

let test_leave_notify_ev () =
  match xevent_of_raw_address (get_raw_leave_notify_ev ()) with
  | LeaveNotify ev ->
      Alcotest.(check int) "serial" 410 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check (option int))
        "subwindow" None
        (Option.map Unsigned.ULong.to_int ev.subwindow);
      Alcotest.(check (pair int int)) "pos" (56, 78) ev.pos;
      Alcotest.(check (pair int int)) "pos_root" (156, 178) ev.pos_root;
      Alcotest.(check bool) "mode" true (ev.mode = NotifyUngrab);
      Alcotest.(check bool) "detail" true (ev.detail = NotifyNonlinearVirtual);
      Alcotest.(check bool) "same_screen" false ev.same_screen;
      Alcotest.(check bool) "focus" false ev.focus;
      Alcotest.(check int) "state" 0 ev.state
  | _ -> Alcotest.fail "Expected LeaveNotify event"

let suite =
  let open Alcotest in
  ( "XCrossingEvent",
    [
      test_case "EnterNotify" `Quick test_enter_notify_ev;
      test_case "LeaveNotify" `Quick test_leave_notify_ev;
    ] )
