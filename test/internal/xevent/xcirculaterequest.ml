open X11_internal
open Xevent
open Helpers

external get_raw_circulate_request_top_ev : unit -> nativeint
  = "get_raw_circulate_request_top_ev"

external get_raw_circulate_request_bottom_ev : unit -> nativeint
  = "get_raw_circulate_request_bottom_ev"

(* A client asks to raise its lowest child (XCirculateSubwindowsUp), redirected
   to the WM by SubstructureRedirectMask on the parent *)
let test_circulate_request_top_ev () =
  match xevent_of_raw_address (get_raw_circulate_request_top_ev ()) with
  | CirculateRequest ev ->
      Alcotest.(check int) "serial" 380 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "display" 0x333D (display_address ev.display);
      Alcotest.(check int) "parent" 3801 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check int) "window" 3802 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check bool) "place" true (ev.place = PlaceOnTop)
  | _ -> Alcotest.fail "Expected CirculateRequest event"

(* A client asks to lower its topmost child (XCirculateSubwindowsDown), sent
   as a synthetic event *)
let test_circulate_request_bottom_ev () =
  match xevent_of_raw_address (get_raw_circulate_request_bottom_ev ()) with
  | CirculateRequest ev ->
      Alcotest.(check int) "serial" 381 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "display" 0x333E (display_address ev.display);
      Alcotest.(check int) "parent" 3803 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check int) "window" 3804 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check bool) "place" true (ev.place = PlaceOnBottom)
  | _ -> Alcotest.fail "Expected CirculateRequest event"

let suite =
  let open Alcotest in
  ( "XCirculateRequestEvent",
    [
      test_case "CirculateRequest (top)" `Quick test_circulate_request_top_ev;
      test_case "CirculateRequest (bottom)" `Quick
        test_circulate_request_bottom_ev;
    ] )
