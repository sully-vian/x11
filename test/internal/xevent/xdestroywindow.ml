open X11_internal
open Xevent
open Helpers

external get_raw_destroy_window_ev : unit -> nativeint
  = "get_raw_destroy_window_ev"

external get_raw_destroy_window_self_ev : unit -> nativeint
  = "get_raw_destroy_window_self_ev"

let test_destroy_window_ev () =
  match xevent_of_raw_address (get_raw_destroy_window_ev ()) with
  | DestroyWindow ev ->
      Alcotest.(check int) "serial" 150 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "event" 5001 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 5002 (Unsigned.ULong.to_int ev.window)
  | _ -> Alcotest.fail "Expected DestroyWindow"

(* StructureNotify selected on the destroyed window itself: event = window *)
let test_destroy_window_self_ev () =
  match xevent_of_raw_address (get_raw_destroy_window_self_ev ()) with
  | DestroyWindow ev ->
      Alcotest.(check int) "serial" 151 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "event" 5003 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 5003 (Unsigned.ULong.to_int ev.window)
  | _ -> Alcotest.fail "Expected DestroyWindow"

let suite =
  let open Alcotest in
  ( "XDestroyWindowEvent",
    [
      test_case "DestroyWindow" `Quick test_destroy_window_ev;
      test_case "DestroyWindow (self)" `Quick test_destroy_window_self_ev;
    ] )
