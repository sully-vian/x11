open X11_internal
open Xevent
open Helpers

external get_raw_unmap_notify_ev : unit -> nativeint = "get_raw_unmap_notify_ev"

external get_raw_unmap_notify_synthetic_ev : unit -> nativeint
  = "get_raw_unmap_notify_synthetic_ev"

let test_unmap_notify_ev () =
  match xevent_of_raw_address (get_raw_unmap_notify_ev ()) with
  | Unmap ev ->
      Alcotest.(check int) "serial" 160 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "event" 6001 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 6002 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check bool) "from_configure" false ev.from_configure
  | _ -> Alcotest.fail "Expected Unmap"

(* ICCCM withdrawal: the client sends a synthetic UnmapNotify to the root *)
let test_unmap_notify_synthetic_ev () =
  match xevent_of_raw_address (get_raw_unmap_notify_synthetic_ev ()) with
  | Unmap ev ->
      Alcotest.(check int) "serial" 161 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "event" 1 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 6003 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check bool) "from_configure" true ev.from_configure
  | _ -> Alcotest.fail "Expected Unmap"

let suite =
  let open Alcotest in
  ( "XUnmapEvent",
    [
      test_case "UnmapNotify" `Quick test_unmap_notify_ev;
      test_case "UnmapNotify (synthetic)" `Quick test_unmap_notify_synthetic_ev;
    ] )
