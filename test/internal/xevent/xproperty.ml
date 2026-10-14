open X11_internal
open Xevent
open Helpers

external get_raw_property_notify_ev : unit -> nativeint
  = "get_raw_property_notify_ev"

external get_raw_property_notify_delete_ev : unit -> nativeint
  = "get_raw_property_notify_delete_ev"

let test_property_notify_ev () =
  match xevent_of_raw_address (get_raw_property_notify_ev ()) with
  | Property ev ->
      Alcotest.(check int) "serial" 280 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "window" 2801 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "atom" 2802 (Unsigned.ULong.to_int ev.atom);
      Alcotest.(check int) "time" 5000 (Unsigned.ULong.to_int ev.time);
      Alcotest.(check bool) "state" true (ev.state = PropertyNewValue)
  | _ -> Alcotest.fail "Expected Property event"

(* Property deleted, with a server timestamp above 2^31: X times are unsigned
   32-bit and wrap after ~49 days *)
let test_property_notify_delete_ev () =
  match xevent_of_raw_address (get_raw_property_notify_delete_ev ()) with
  | Property ev ->
      Alcotest.(check int) "serial" 281 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "window" 2803 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "atom" 2804 (Unsigned.ULong.to_int ev.atom);
      Alcotest.(check int) "time" 0xFFFFFFF0 (Unsigned.ULong.to_int ev.time);
      Alcotest.(check bool) "state" true (ev.state = PropertyDelete)
  | _ -> Alcotest.fail "Expected Property event"

let suite =
  let open Alcotest in
  ( "XPropertyEvent",
    [
      test_case "PropertyNotify" `Quick test_property_notify_ev;
      test_case "PropertyNotify (delete)" `Quick test_property_notify_delete_ev;
    ] )
