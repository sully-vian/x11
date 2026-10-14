open X11_internal
open Xevent
open Helpers

external get_raw_map_request_ev : unit -> nativeint = "get_raw_map_request_ev"

external get_raw_map_request_root_ev : unit -> nativeint
  = "get_raw_map_request_root_ev"

let test_map_request_ev () =
  match xevent_of_raw_address (get_raw_map_request_ev ()) with
  | MapRequest ev ->
      Alcotest.(check int) "serial" 180 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "parent" 8001 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check int) "window" 8002 (Unsigned.ULong.to_int ev.window)
  | _ -> Alcotest.fail "Expected MapRequest"

(* Top-level window mapped by a client: the parent is the root window. The
   window id has the high bits a real XID carries (resource-id-base). *)
let test_map_request_root_ev () =
  match xevent_of_raw_address (get_raw_map_request_root_ev ()) with
  | MapRequest ev ->
      Alcotest.(check int) "serial" 181 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "parent" 1 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check int) "window" 0x1e00007 (Unsigned.ULong.to_int ev.window)
  | _ -> Alcotest.fail "Expected MapRequest"

let suite =
  let open Alcotest in
  ( "XMapRequestEvent",
    [
      test_case "MapRequest" `Quick test_map_request_ev;
      test_case "MapRequest (root parent)" `Quick test_map_request_root_ev;
    ] )
