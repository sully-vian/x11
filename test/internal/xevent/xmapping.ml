open X11_internal
open Xevent
open Helpers

external get_raw_mapping_notify_keyboard_ev : unit -> nativeint
  = "get_raw_mapping_notify_keyboard_ev"

external get_raw_mapping_notify_pointer_ev : unit -> nativeint
  = "get_raw_mapping_notify_pointer_ev"

(* Keyboard remapped, e.g. by setxkbmap: every keycode from 8 to 255 *)
let test_mapping_notify_keyboard_ev () =
  match xevent_of_raw_address (get_raw_mapping_notify_keyboard_ev ()) with
  | Mapping ev ->
      Alcotest.(check int) "serial" 340 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "display" 0x3335 (display_address ev.display);
      Alcotest.(check int) "window" 3401 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check bool) "request" true (ev.request = MappingKeyboard);
      Alcotest.(check int) "first_keycode" 8 ev.first_keycode;
      Alcotest.(check int) "count" 248 ev.count
  | _ -> Alcotest.fail "Expected Mapping event"

(* Pointer buttons remapped, e.g. by xmodmap: the keycode range is unused *)
let test_mapping_notify_pointer_ev () =
  match xevent_of_raw_address (get_raw_mapping_notify_pointer_ev ()) with
  | Mapping ev ->
      Alcotest.(check int) "serial" 341 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "display" 0x3336 (display_address ev.display);
      Alcotest.(check int) "window" 3402 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check bool) "request" true (ev.request = MappingPointer);
      Alcotest.(check int) "first_keycode" 0 ev.first_keycode;
      Alcotest.(check int) "count" 0 ev.count
  | _ -> Alcotest.fail "Expected Mapping event"

let suite =
  let open Alcotest in
  ( "XMappingEvent",
    [
      test_case "MappingNotify (keyboard)" `Quick
        test_mapping_notify_keyboard_ev;
      test_case "MappingNotify (pointer)" `Quick test_mapping_notify_pointer_ev;
    ] )
