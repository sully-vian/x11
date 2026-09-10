open X11.Xevent

external gen_key_event : unit -> xEvent = "test_gen_key_event"
external gen_button_event : unit -> xEvent = "test_gen_button_event"
external gen_motion_event : unit -> xEvent = "test_gen_motion_event"
external gen_expose_event : unit -> xEvent = "test_gen_expose_event"
external gen_configure_event : unit -> xEvent = "test_gen_configure_event"

let to_native (i : int) : 'a = Obj.magic (Nativeint.of_int i)

let test_key_event () =
  let is_match =
    match gen_key_event () with
    | XKeyEvent ev ->
        ev.serial = 100 && ev.send_event = true
        && ev.display = to_native 0x1234
        && ev.window = to_native 10
        && ev.root = to_native 20
        && ev.subwindow = to_native 30
        && ev.time = to_native 1000
        && ev.x = 50 && ev.y = 60 && ev.x_root = 70 && ev.y_root = 80
        && ev.state = 5 && ev.keycode = 13 && ev.same_screen = true
    | _ -> false
  in
  Alcotest.(check bool) "matches expected fields" true is_match

let test_button_event () =
  let is_match =
    match gen_button_event () with
    | XButtonEvent ev ->
        ev.serial = 101 && ev.send_event = false
        && ev.display = to_native 0x5678
        && ev.window = to_native 11
        && ev.button = 1
    | _ -> false
  in
  Alcotest.(check bool) "matches expected fields" true is_match

let test_motion_event () =
  let is_match =
    match gen_motion_event () with
    | XMotionEvent ev ->
        ev.serial = 102 && ev.send_event = true
        && ev.display = to_native 0x9ABC
        && ev.window = to_native 12
        && ev.x = 52 && ev.y = 62 && ev.same_screen = false
    | _ -> false
  in
  Alcotest.(check bool) "matches expected fields" true is_match

let test_expose_event () =
  let is_match =
    match gen_expose_event () with
    | XExposeEvent ev ->
        ev.serial = 103 && ev.send_event = false
        && ev.display = to_native 0xDEF0
        && ev.window = to_native 13
        && ev.x = 100 && ev.y = 200 && ev.width = 800 && ev.height = 600
        && ev.count = 2
    | _ -> false
  in
  Alcotest.(check bool) "matches expected fields" true is_match

let test_configure_event () =
  let is_match =
    match gen_configure_event () with
    | XConfigureEvent ev ->
        ev.serial = 104 && ev.send_event = true
        && ev.display = to_native 0x1111
        && ev.event = to_native 40
        && ev.window = to_native 14
        && ev.x = 300 && ev.y = 400 && ev.width = 1024 && ev.height = 768
        && ev.border_width = 2
        && ev.above = to_native 50
        && ev.override_redirect = false
    | _ -> false
  in
  Alcotest.(check bool) "matches expected fields" true is_match

let suite =
  let open Alcotest in
  [
    test_case "XKeyEvent" `Quick test_key_event;
    test_case "XButtonEvent" `Quick test_button_event;
    test_case "XMotionEvent" `Quick test_motion_event;
    test_case "XExposeEvent" `Quick test_expose_event;
    test_case "XConfigureEvent" `Quick test_configure_event;
  ]
