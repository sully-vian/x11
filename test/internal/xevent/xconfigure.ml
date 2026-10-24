open X11_internal
open Xevent
open Helpers

external get_raw_configure_notify_ev : unit -> nativeint
  = "get_raw_configure_notify_ev"

external get_raw_configure_notify_synthetic_ev : unit -> nativeint
  = "get_raw_configure_notify_synthetic_ev"

let test_configure_notify_ev () =
  match xevent_of_raw_address (get_raw_configure_notify_ev ()) with
  | ConfigureNotify ev ->
      Alcotest.(check int) "serial" 220 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "event" 2201 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 2202 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check (pair int int)) "pos" (100, 200) ev.pos;
      Alcotest.(check (pair int int)) "size" (1024, 768) ev.size;
      Alcotest.(check int) "border_width" 2 ev.border_width;
      Alcotest.(check (option int))
        "above" (Some 2203)
        (Option.map Unsigned.ULong.to_int ev.above);
      Alcotest.(check bool) "override_redirect" true ev.override_redirect
  | _ -> Alcotest.fail "Expected ConfigureNotify event"

(* Synthetic ConfigureNotify a WM sends to a reparented client (ICCCM 4.1.5):
   root coordinates, no sibling *)
let test_configure_notify_synthetic_ev () =
  match xevent_of_raw_address (get_raw_configure_notify_synthetic_ev ()) with
  | ConfigureNotify ev ->
      Alcotest.(check int) "serial" 221 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "event" 2204 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 2204 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check (pair int int)) "pos" (1925, 30) ev.pos;
      Alcotest.(check (pair int int)) "size" (1280, 720) ev.size;
      Alcotest.(check int) "border_width" 0 ev.border_width;
      Alcotest.(check (option int))
        "above" None
        (Option.map Unsigned.ULong.to_int ev.above);
      Alcotest.(check bool) "override_redirect" false ev.override_redirect
  | _ -> Alcotest.fail "Expected ConfigureNotify event"

let suite =
  let open Alcotest in
  ( "XConfigureEvent",
    [
      test_case "ConfigureNotify" `Quick test_configure_notify_ev;
      test_case "ConfigureNotify (synthetic)" `Quick
        test_configure_notify_synthetic_ev;
    ] )
