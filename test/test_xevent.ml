open X11

(* External C functions *)
external get_key_press_ev : unit -> xEvent = "get_key_press_ev"
external get_key_release_ev : unit -> xEvent = "get_key_release_ev"
external get_button_press_ev : unit -> xEvent = "get_button_press_ev"
external get_motion_notify_ev : unit -> xEvent = "get_motion_notify_ev"
external get_expose_ev : unit -> xEvent = "get_expose_ev"
external get_destroy_window_ev : unit -> xEvent = "get_destroy_window_ev"
external get_unmap_notify_ev : unit -> xEvent = "get_unmap_notify_ev"
external get_map_notify_ev : unit -> xEvent = "get_map_notify_ev"
external get_map_request_ev : unit -> xEvent = "get_map_request_ev"
external get_configure_request_ev : unit -> xEvent = "get_configure_request_ev"
external get_reparent_notify_ev : unit -> xEvent = "get_reparent_notify_ev"
external get_configure_notify_ev : unit -> xEvent = "get_configure_notify_ev"
external get_property_notify_ev : unit -> xEvent = "get_property_notify_ev"
external get_client_message_ev_b : unit -> xEvent = "get_client_message_ev_b"
external get_client_message_ev_s : unit -> xEvent = "get_client_message_ev_s"
external get_client_message_ev_l : unit -> xEvent = "get_client_message_ev_l"
external get_focus_in_ev : unit -> xEvent = "get_focus_in_ev"

(* Helper to convert between abstract types and nativeint for comparison.
   NOTE: The display and window types are abstract in xevent.ml, so we can't
   directly compare them. These bindings should be updated to expose the
   underlying values, or we should use a custom equality function. For now,
   this helper allows manual verification if needed. *)
let to_native : 'a -> nativeint = fun x -> Obj.magic x

let test_key_press_ev () =
  match get_key_press_ev () with
  | XKeyPress ev ->
      Alcotest.(check int) "serial" 42 ev.serial;
      Alcotest.(check bool) "send_event" false ev.send_event;
      (* NOTE: display and window are abstract types, cannot directly compare.
         User should add concrete accessors to xevent.ml or use a custom testable. *)
      Alcotest.(check int) "x" 10 ev.x;
      Alcotest.(check int) "y" 20 ev.y;
      Alcotest.(check int) "x_root" 100 ev.x_root;
      Alcotest.(check int) "y_root" 200 ev.y_root;
      Alcotest.(check int) "state" 0 ev.state;
      Alcotest.(check int) "keycode" 65 ev.keycode;
      Alcotest.(check bool) "same_screen" true ev.same_screen
  | _ -> Alcotest.fail "Expected XKeyPress event"

let test_key_release_ev () =
  match get_key_release_ev () with
  | XKeyRelease ev ->
      Alcotest.(check int) "serial" 42 ev.serial;
      Alcotest.(check bool) "send_event" false ev.send_event;
      (* NOTE: display and window are abstract types, cannot directly compare.
         User should add concrete accessors to xevent.ml or use a custom testable. *)
      Alcotest.(check int) "x" 10 ev.x;
      Alcotest.(check int) "y" 20 ev.y;
      Alcotest.(check int) "x_root" 100 ev.x_root;
      Alcotest.(check int) "y_root" 200 ev.y_root;
      Alcotest.(check int) "state" 0 ev.state;
      Alcotest.(check int) "keycode" 65 ev.keycode;
      Alcotest.(check bool) "same_screen" true ev.same_screen
  | _ -> Alcotest.fail "Expected XKeyRelease event"

let test_button_press_ev () =
  match get_button_press_ev () with
  | XButtonPress ev ->
      Alcotest.(check int) "serial" 100 ev.serial;
      Alcotest.(check bool) "send_event" true ev.send_event;
      (* NOTE: display, window, root, subwindow are abstract types *)
      Alcotest.(check int) "x" 50 ev.x;
      Alcotest.(check int) "y" 75 ev.y;
      Alcotest.(check int) "x_root" 150 ev.x_root;
      Alcotest.(check int) "y_root" 250 ev.y_root;
      Alcotest.(check int) "state" 1 ev.state;
      Alcotest.(check int) "button" 1 ev.button;
      Alcotest.(check bool) "same_screen" true ev.same_screen
  | _ -> Alcotest.fail "Expected XButtonPress event"

let test_motion_notify_ev () =
  match get_motion_notify_ev () with
  | XMotionNotify ev ->
      Alcotest.(check int) "serial" 200 ev.serial;
      Alcotest.(check bool) "send_event" false ev.send_event;
      (* NOTE: display, window, root, subwindow are abstract types *)
      Alcotest.(check int) "x" 30 ev.x;
      Alcotest.(check int) "y" 40 ev.y;
      Alcotest.(check int) "x_root" 130 ev.x_root;
      Alcotest.(check int) "y_root" 240 ev.y_root;
      Alcotest.(check int) "state" 2 ev.state;
      Alcotest.(check bool) "same_screen" true ev.same_screen
  | _ -> Alcotest.fail "Expected XMotionNotify event"

let test_expose_ev () =
  match get_expose_ev () with
  | XExpose ev ->
      Alcotest.(check int) "serial" 300 ev.serial;
      Alcotest.(check bool) "send_event" true ev.send_event;
      (* NOTE: display and window are abstract types *)
      Alcotest.(check int) "x" 5 ev.x;
      Alcotest.(check int) "y" 15 ev.y;
      Alcotest.(check int) "width" 800 ev.width;
      Alcotest.(check int) "height" 600 ev.height;
      Alcotest.(check int) "count" 0 ev.count
  | _ -> Alcotest.fail "Expected XExpose event"

let test_destroy_window_ev () =
  match get_destroy_window_ev () with
  | XDestroyWindow ev -> Alcotest.(check int) "serial" 150 ev.serial
  | _ -> Alcotest.fail "Expected XDestroyWindow"

let test_unmap_notify_ev () =
  match get_unmap_notify_ev () with
  | XUnmap ev ->
      Alcotest.(check int) "serial" 160 ev.serial;
      Alcotest.(check bool) "from_configure" false ev.from_configure
  | _ -> Alcotest.fail "Expected XUnmap"

let test_map_notify_ev () =
  match get_map_notify_ev () with
  | XMap ev ->
      Alcotest.(check int) "serial" 170 ev.serial;
      Alcotest.(check bool) "override_redirect" false ev.override_redirect
  | _ -> Alcotest.fail "Expected XMap"

let test_map_request_ev () =
  match get_map_request_ev () with
  | XMapRequest ev -> Alcotest.(check int) "serial" 180 ev.serial
  | _ -> Alcotest.fail "Expected XMapRequest"

let test_configure_request_ev () =
  match get_configure_request_ev () with
  | XConfigureRequest ev ->
      Alcotest.(check int) "serial" 190 ev.serial;
      Alcotest.(check int) "width" 800 ev.width;
      Alcotest.(check int) "height" 600 ev.height
  | _ -> Alcotest.fail "Expected XConfigureRequest"

let test_reparent_notify_ev () =
  match get_reparent_notify_ev () with
  | XReparent ev ->
      Alcotest.(check int) "serial" 210 ev.serial;
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "x" 10 ev.x;
      Alcotest.(check int) "y" 20 ev.y;
      Alcotest.(check bool) "override_redirect" false ev.override_redirect
  | _ -> Alcotest.fail "Expected XReparent event"

let test_configure_notify_ev () =
  match get_configure_notify_ev () with
  | XConfigureNotify ev ->
      Alcotest.(check int) "serial" 220 ev.serial;
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "x" 100 ev.x;
      Alcotest.(check int) "y" 200 ev.y;
      Alcotest.(check int) "width" 1024 ev.width;
      Alcotest.(check int) "height" 768 ev.height;
      Alcotest.(check int) "border_width" 2 ev.border_width;
      Alcotest.(check bool) "override_redirect" true ev.override_redirect
  | _ -> Alcotest.fail "Expected XConfigureNotify event"

let test_property_notify_ev () =
  match get_property_notify_ev () with
  | XProperty ev ->
      Alcotest.(check int) "serial" 280 ev.serial;
      Alcotest.(check bool) "send_event" false ev.send_event
  | _ -> Alcotest.fail "Expected XProperty event"

let test_client_message_ev_b () =
  match get_client_message_ev_b () with
  | XClientMessage ev -> (
      Alcotest.(check int) "serial" 330 ev.serial;
      Alcotest.(check bool) "send_event" true ev.send_event;
      match ev.data with
      | Bytes b ->
          Alcotest.(check (seq char))
            "data"
            ("ABCDEFGHIJKLMNOPQRST" |> String.to_seq)
            (Array.to_seq b)
      | _ -> Alcotest.fail "Expected bytes")
  | _ -> Alcotest.fail "Expected XClientMessage event"

let test_client_meessage_ev_s () =
  match get_client_message_ev_s () with
  | XClientMessage ev -> (
      match ev.data with
      | Shorts s ->
          Alcotest.(check (array int))
            "data"
            [| 0; 1; 2; 3; 4; 5; 6; 7; 8; 9 |]
            s
      | _ -> Alcotest.fail "Expected short")
  | _ -> Alcotest.fail "Expected XClientMessage event"

let test_client_meessage_ev_l () =
  match get_client_message_ev_l () with
  | XClientMessage ev -> (
      match ev.data with
      | Longs s -> Alcotest.(check (array int)) "data" [| 0; 1; 2; 3; 4 |] s
      | _ -> Alcotest.fail "Expected long")
  | _ -> Alcotest.fail "Expected XClientMessage event"

let test_focus_in_ev () =
  match get_focus_in_ev () with
  | XFocusIn ev ->
      Alcotest.(check int) "serial" 90 ev.serial;
      Alcotest.(check bool) "send_event" false ev.send_event
  | _ -> Alcotest.fail "Expected XFocusIn event"

let suite =
  let open Alcotest in
  [
    test_case "KeyPress" `Quick test_key_press_ev;
    test_case "KeyRelease" `Quick test_key_release_ev;
    test_case "ButtonPress" `Quick test_button_press_ev;
    test_case "MotionNotify" `Quick test_motion_notify_ev;
    test_case "Expose" `Quick test_expose_ev;
    test_case "DestroyWindow" `Quick test_destroy_window_ev;
    test_case "UnmapNotify" `Quick test_unmap_notify_ev;
    test_case "MapNotify" `Quick test_map_notify_ev;
    test_case "MapRequest" `Quick test_map_request_ev;
    test_case "ConfigureRequest" `Quick test_configure_request_ev;
    test_case "ReparentNotify" `Quick test_reparent_notify_ev;
    test_case "ConfigureNotify" `Quick test_configure_notify_ev;
    test_case "PropertyNotify" `Quick test_property_notify_ev;
    test_case "ClientMessage (bytes)" `Quick test_client_message_ev_b;
    test_case "ClientMessage (shorts)" `Quick test_client_meessage_ev_s;
    test_case "ClientMessage (longs)" `Quick test_client_meessage_ev_l;
    test_case "FocusIn" `Quick test_focus_in_ev;
  ]
