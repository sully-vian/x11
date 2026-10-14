open X11_internal
open Xevent
open Helpers

external get_raw_expose_ev : unit -> nativeint = "get_raw_expose_ev"
external get_raw_expose_last_ev : unit -> nativeint = "get_raw_expose_last_ev"

let test_expose_ev () =
  match xevent_of_raw_address (get_raw_expose_ev ()) with
  | Expose ev ->
      Alcotest.(check int) "serial" 300 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "display" 0xdef0 (display_address ev.display);
      Alcotest.(check int) "window" 311 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check (pair int int)) "pos" (5, 15) ev.pos;
      Alcotest.(check (pair int int)) "size" (800, 600) ev.size;
      Alcotest.(check int) "count" 3 ev.count
  | _ -> Alcotest.fail "Expected Expose event"

(* Last event of an Expose series: count = 0, large multi-monitor geometry *)
let test_expose_last_ev () =
  match xevent_of_raw_address (get_raw_expose_last_ev ()) with
  | Expose ev ->
      Alcotest.(check int) "serial" 301 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check (pair int int)) "pos" (1920, 1080) ev.pos;
      Alcotest.(check (pair int int)) "size" (3840, 2160) ev.size;
      Alcotest.(check int) "count" 0 ev.count
  | _ -> Alcotest.fail "Expected Expose event"

let suite =
  let open Alcotest in
  ( "XExposeEvent",
    [
      test_case "Expose" `Quick test_expose_ev;
      test_case "Expose (last in series)" `Quick test_expose_last_ev;
    ] )
