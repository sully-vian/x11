open X11.Xevent

external gen_key_event : unit -> xEvent = "test_gen_key_event"
external gen_button_event : unit -> xEvent = "test_gen_button_event"
external gen_motion_event : unit -> xEvent = "test_gen_motion_event"
external gen_expose_event : unit -> xEvent = "test_gen_expose_event"
external gen_configure_event : unit -> xEvent = "test_gen_configure_event"

(* Helper to cast integers to abstract nativeint types like window, display, etc. *)
let to_native (i : int) : 'a = Obj.magic (Nativeint.of_int i)

let test_key_event () =
  match gen_key_event () with
  | XKeyEvent ev ->
      assert (ev.serial = 100);
      assert (ev.send_event = true);
      assert (ev.display = to_native 0x1234);
      assert (ev.window = to_native 10);
      assert (ev.root = to_native 20);
      assert (ev.subwindow = to_native 30);
      assert (ev.time = to_native 1000);
      assert (ev.x = 50);
      assert (ev.y = 60);
      assert (ev.x_root = 70);
      assert (ev.y_root = 80);
      assert (ev.state = 5);
      assert (ev.keycode = 13);
      assert (ev.same_screen = true);
      print_endline "XKeyEvent: PASS"
  | _ -> assert false

let test_button_event () =
  match gen_button_event () with
  | XButtonEvent ev ->
      assert (ev.serial = 101);
      assert (ev.send_event = false);
      assert (ev.display = to_native 0x5678);
      assert (ev.window = to_native 11);
      assert (ev.button = 1);
      print_endline "XButtonEvent: PASS"
  | _ -> assert false

let test_motion_event () =
  match gen_motion_event () with
  | XMotionEvent ev ->
      assert (ev.serial = 102);
      assert (ev.send_event = true);
      assert (ev.display = to_native 0x9ABC);
      assert (ev.window = to_native 12);
      assert (ev.x = 52);
      assert (ev.y = 62);
      assert (ev.same_screen = false);
      print_endline "XMotionEvent: PASS"
  | _ -> assert false

let test_expose_event () =
  match gen_expose_event () with
  | XExposeEvent ev ->
      assert (ev.serial = 103);
      assert (ev.send_event = false);
      assert (ev.display = to_native 0xDEF0);
      assert (ev.window = to_native 13);
      assert (ev.x = 100);
      assert (ev.y = 200);
      assert (ev.width = 800);
      assert (ev.height = 600);
      assert (ev.count = 2);
      print_endline "XExposeEvent: PASS"
  | _ -> assert false

let test_configure_event () =
  match gen_configure_event () with
  | XConfigureEvent ev ->
      assert (ev.serial = 104);
      assert (ev.send_event = true);
      assert (ev.display = to_native 0x1111);
      assert (ev.event = to_native 40);
      assert (ev.window = to_native 14);
      assert (ev.x = 300);
      assert (ev.y = 400);
      assert (ev.width = 1024);
      assert (ev.height = 768);
      assert (ev.border_width = 2);
      assert (ev.above = to_native 50);
      assert (ev.override_redirect = false);
      print_endline "XConfigureEvent: PASS"
  | _ -> assert false

let () =
  test_key_event ();
  test_button_event ();
  test_motion_event ();
  test_expose_event ();
  test_configure_event ();
  print_endline "All tests passed successfully!"
