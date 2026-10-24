open X11_internal
open Xevent
open Helpers

external get_raw_key_press_ev : unit -> nativeint = "get_raw_key_press_ev"
external get_raw_key_release_ev : unit -> nativeint = "get_raw_key_release_ev"

let test_key_press_ev () =
  match xevent_of_raw_address (get_raw_key_press_ev ()) with
  | KeyPress ev ->
      Alcotest.(check int) "serial" 42 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "display" 0x1234 (display_address ev.display);
      Alcotest.(check int) "window" 123 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "root" 456 (Unsigned.ULong.to_int ev.root);
      Alcotest.(check (option int))
        "subwindow" (Some 789)
        (Option.map Unsigned.ULong.to_int ev.subwindow);
      Alcotest.(check int) "time" 1000 (Unsigned.ULong.to_int ev.time);
      Alcotest.(check (pair int int)) "pos" (10, 20) ev.pos;
      Alcotest.(check (pair int int)) "pos_root" (100, 200) ev.pos_root;
      Alcotest.(check int) "state" 0 ev.state;
      Alcotest.(check int) "keycode" 65 ev.keycode;
      Alcotest.(check bool) "same_screen" true ev.same_screen
  | _ -> Alcotest.fail "Expected KeyPress event"

let test_key_release_ev () =
  match xevent_of_raw_address (get_raw_key_release_ev ()) with
  | KeyRelease ev ->
      Alcotest.(check int) "serial" 42 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "display" 0x1234 (display_address ev.display);
      Alcotest.(check int) "window" 123 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "root" 456 (Unsigned.ULong.to_int ev.root);
      Alcotest.(check (option int))
        "subwindow" (Some 789)
        (Option.map Unsigned.ULong.to_int ev.subwindow);
      Alcotest.(check int) "time" 1000 (Unsigned.ULong.to_int ev.time);
      Alcotest.(check (pair int int)) "pos" (10, 20) ev.pos;
      Alcotest.(check (pair int int)) "pos_root" (100, 200) ev.pos_root;
      Alcotest.(check int) "state" 0 ev.state;
      Alcotest.(check int) "keycode" 65 ev.keycode;
      Alcotest.(check bool) "same_screen" true ev.same_screen
  | _ -> Alcotest.fail "Expected KeyRelease event"

let suite =
  let open Alcotest in
  ( "XKeyEvent",
    [
      test_case "KeyPress" `Quick test_key_press_ev;
      test_case "KeyRelease" `Quick test_key_release_ev;
    ] )
