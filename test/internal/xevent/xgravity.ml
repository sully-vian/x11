open X11_internal
open Xevent
open Helpers

external get_raw_gravity_notify_ev : unit -> nativeint
  = "get_raw_gravity_notify_ev"

external get_raw_gravity_notify_self_ev : unit -> nativeint
  = "get_raw_gravity_notify_self_ev"

(* A child moved by its win_gravity when its parent was resized, seen on the
   parent with SubstructureNotifyMask *)
let test_gravity_notify_ev () =
  match xevent_of_raw_address (get_raw_gravity_notify_ev ()) with
  | GravityNotify ev ->
      Alcotest.(check int) "serial" 360 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "display" 0x3339 (display_address ev.display);
      Alcotest.(check int) "event" 3601 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 3602 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check (pair int int)) "pos" (120, 80) ev.pos
  | _ -> Alcotest.fail "Expected GravityNotify event"

(* Seen on the moved window itself (StructureNotifyMask), pushed partly off
   the left edge *)
let test_gravity_notify_self_ev () =
  match xevent_of_raw_address (get_raw_gravity_notify_self_ev ()) with
  | GravityNotify ev ->
      Alcotest.(check int) "serial" 361 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "display" 0x333A (display_address ev.display);
      Alcotest.(check int) "event" 3603 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 3603 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check (pair int int)) "pos" (-40, 1050) ev.pos
  | _ -> Alcotest.fail "Expected GravityNotify event"

let suite =
  let open Alcotest in
  ( "XGravityEvent",
    [
      test_case "GravityNotify" `Quick test_gravity_notify_ev;
      test_case "GravityNotify (self)" `Quick test_gravity_notify_self_ev;
    ] )
