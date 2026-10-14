open X11_internal
open Xevent
open Helpers

external get_raw_focus_in_ev : unit -> nativeint = "get_raw_focus_in_ev"

let test_focus_in_ev () =
  match xevent_of_raw_address (get_raw_focus_in_ev ()) with
  | FocusIn ev ->
      Alcotest.(check int) "serial" 90 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check bool) "mode" true (ev.mode = NotifyNormal);
      Alcotest.(check bool) "detail" true (ev.detail = NotifyNonlinear)
  | _ -> Alcotest.fail "Expected FocusIn event"

let suite =
  let open Alcotest in
  ("XFocusChangeEvent", [ test_case "FocusIn" `Quick test_focus_in_ev ])
