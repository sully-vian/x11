open X11_internal
open Xevent
open Helpers

external get_raw_create_notify_ev : unit -> nativeint
  = "get_raw_create_notify_ev"

external get_raw_create_notify_override_ev : unit -> nativeint
  = "get_raw_create_notify_override_ev"

(* A client creates a top-level window, seen by the WM on the root *)
let test_create_notify_ev () =
  match xevent_of_raw_address (get_raw_create_notify_ev ()) with
  | CreateWindow ev ->
      Alcotest.(check int) "serial" 350 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "display" 0x3337 (display_address ev.display);
      Alcotest.(check int) "parent" 3501 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check int) "window" 3502 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check (pair int int)) "pos" (50, 60) ev.pos;
      Alcotest.(check (pair int int)) "size" (800, 600) ev.size;
      Alcotest.(check int) "border_width" 1 ev.border_width;
      Alcotest.(check bool) "override_redirect" false ev.override_redirect
  | _ -> Alcotest.fail "Expected CreateWindow event"

(* An override-redirect popup (menu, tooltip) on a monitor left of the
   primary one, hence the negative position *)
let test_create_notify_override_ev () =
  match xevent_of_raw_address (get_raw_create_notify_override_ev ()) with
  | CreateWindow ev ->
      Alcotest.(check int) "serial" 351 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "display" 0x3338 (display_address ev.display);
      Alcotest.(check int) "parent" 3503 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check int) "window" 3504 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check (pair int int)) "pos" (-1720, -15) ev.pos;
      Alcotest.(check (pair int int)) "size" (240, 32) ev.size;
      Alcotest.(check int) "border_width" 0 ev.border_width;
      Alcotest.(check bool) "override_redirect" true ev.override_redirect
  | _ -> Alcotest.fail "Expected CreateWindow event"

let suite =
  let open Alcotest in
  ( "XCreateWindowEvent",
    [
      test_case "CreateNotify" `Quick test_create_notify_ev;
      test_case "CreateNotify (override redirect)" `Quick
        test_create_notify_override_ev;
    ] )
