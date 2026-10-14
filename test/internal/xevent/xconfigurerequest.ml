open X11_internal
open Xevent
open Helpers

external get_raw_configure_request_ev : unit -> nativeint
  = "get_raw_configure_request_ev"

external get_raw_configure_request_restack_ev : unit -> nativeint
  = "get_raw_configure_request_restack_ev"

let test_configure_request_ev () =
  match xevent_of_raw_address (get_raw_configure_request_ev ()) with
  | ConfigureRequest ev ->
      Alcotest.(check int) "serial" 190 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "parent" 9001 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check int) "window" 9002 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check (pair int int)) "pos" (100, 100) ev.pos;
      Alcotest.(check (pair int int)) "size" (800, 600) ev.size;
      Alcotest.(check int) "border_width" 1 ev.border_width;
      Alcotest.(check int) "above" 9003 (Unsigned.ULong.to_int ev.above);
      Alcotest.(check bool) "detail" true (ev.detail = Above);
      Alcotest.(check int) "value_mask" 15 ev.value_mask
  | _ -> Alcotest.fail "Expected ConfigureRequest"

(* Client moving itself partly off-screen and restacking below a sibling *)
let test_configure_request_restack_ev () =
  match xevent_of_raw_address (get_raw_configure_request_restack_ev ()) with
  | ConfigureRequest ev ->
      Alcotest.(check int) "serial" 191 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "parent" 1 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check int) "window" 9004 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check (pair int int)) "pos" (-50, -20) ev.pos;
      Alcotest.(check (pair int int)) "size" (640, 480) ev.size;
      Alcotest.(check int) "border_width" 0 ev.border_width;
      Alcotest.(check int) "above" 9005 (Unsigned.ULong.to_int ev.above);
      Alcotest.(check bool) "detail" true (ev.detail = Below);
      (* CWX | CWY | CWSibling | CWStackMode *)
      Alcotest.(check int) "value_mask" (1 + 2 + 32 + 64) ev.value_mask
  | _ -> Alcotest.fail "Expected ConfigureRequest"

let suite =
  let open Alcotest in
  ( "XConfigureRequestEvent",
    [
      test_case "ConfigureRequest" `Quick test_configure_request_ev;
      test_case "ConfigureRequest (restack)" `Quick
        test_configure_request_restack_ev;
    ] )
