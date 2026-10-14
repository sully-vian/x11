open X11_internal
open Xevent
open Helpers

external get_raw_map_notify_ev : unit -> nativeint = "get_raw_map_notify_ev"

external get_raw_map_notify_override_ev : unit -> nativeint
  = "get_raw_map_notify_override_ev"

let test_map_notify_ev () =
  match xevent_of_raw_address (get_raw_map_notify_ev ()) with
  | Map ev ->
      Alcotest.(check int) "serial" 170 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "event" 7001 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 7002 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check bool) "override_redirect" false ev.override_redirect
  | _ -> Alcotest.fail "Expected Map"

(* Override-redirect window (popup menu, tooltip): a WM must not manage it *)
let test_map_notify_override_ev () =
  match xevent_of_raw_address (get_raw_map_notify_override_ev ()) with
  | Map ev ->
      Alcotest.(check int) "serial" 171 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "event" 1 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 7003 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check bool) "override_redirect" true ev.override_redirect
  | _ -> Alcotest.fail "Expected Map"

let suite =
  let open Alcotest in
  ( "XMapEvent",
    [
      test_case "MapNotify" `Quick test_map_notify_ev;
      test_case "MapNotify (override redirect)" `Quick
        test_map_notify_override_ev;
    ] )
