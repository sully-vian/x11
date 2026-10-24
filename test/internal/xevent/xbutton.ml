open X11_internal
open C.Types
open Xevent
open Helpers

external get_raw_button_press_ev : unit -> nativeint = "get_raw_button_press_ev"

let test_button_press_ev () =
  match xevent_of_raw_address (get_raw_button_press_ev ()) with
  | ButtonPress ev ->
      Alcotest.(check int) "serial" 100 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "display" 0x5678 (display_address ev.display);
      Alcotest.(check int) "window" 111 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "root" 222 (Unsigned.ULong.to_int ev.root);
      Alcotest.(check (option int))
        "subwindow" (Some 333)
        (Option.map Unsigned.ULong.to_int ev.subwindow);
      Alcotest.(check int) "time" 2000 (Unsigned.ULong.to_int ev.time);
      Alcotest.(check (pair int int)) "pos" (50, 75) ev.pos;
      Alcotest.(check (pair int int)) "pos_root" (150, 250) ev.pos_root;
      Alcotest.(check int) "state" 1 ev.state;
      Alcotest.(check int) "button" button1 ev.button;
      Alcotest.(check bool) "same_screen" true ev.same_screen
  | _ -> Alcotest.fail "Expected ButtonPress event"

let suite =
  let open Alcotest in
  ("XButtonEvent", [ test_case "ButtonPress" `Quick test_button_press_ev ])
