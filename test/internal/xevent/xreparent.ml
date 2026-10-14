open X11_internal
open Xevent
open Helpers

external get_raw_reparent_notify_ev : unit -> nativeint
  = "get_raw_reparent_notify_ev"

external get_raw_reparent_notify_root_ev : unit -> nativeint
  = "get_raw_reparent_notify_root_ev"

let test_reparent_notify_ev () =
  match xevent_of_raw_address (get_raw_reparent_notify_ev ()) with
  | Reparent ev ->
      Alcotest.(check int) "serial" 210 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "event" 2101 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 2102 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "parent" 2103 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check (pair int int)) "pos" (10, 20) ev.pos;
      Alcotest.(check bool) "override_redirect" false ev.override_redirect
  | _ -> Alcotest.fail "Expected Reparent event"

(* Window handed back to the root (e.g. the WM releasing it), reported to the
   window itself. Also covers the [true] values of the boolean fields. *)
let test_reparent_notify_root_ev () =
  match xevent_of_raw_address (get_raw_reparent_notify_root_ev ()) with
  | Reparent ev ->
      Alcotest.(check int) "serial" 211 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "event" 2104 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 2104 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "parent" 1 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check (pair int int)) "pos" (640, 480) ev.pos;
      Alcotest.(check bool) "override_redirect" true ev.override_redirect
  | _ -> Alcotest.fail "Expected Reparent event"

let suite =
  let open Alcotest in
  ( "XReparentEvent",
    [
      test_case "ReparentNotify" `Quick test_reparent_notify_ev;
      test_case "ReparentNotify (to root)" `Quick test_reparent_notify_root_ev;
    ] )
