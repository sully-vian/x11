open X11_internal
open C.Types
open Xevent

(* External C functions *)
external get_raw_key_press_ev : unit -> nativeint = "get_raw_key_press_ev"
external get_raw_key_release_ev : unit -> nativeint = "get_raw_key_release_ev"
external get_raw_button_press_ev : unit -> nativeint = "get_raw_button_press_ev"

external get_raw_motion_notify_ev : unit -> nativeint
  = "get_raw_motion_notify_ev"

external get_raw_expose_ev : unit -> nativeint = "get_raw_expose_ev"
external get_raw_expose_last_ev : unit -> nativeint = "get_raw_expose_last_ev"

external get_raw_destroy_window_ev : unit -> nativeint
  = "get_raw_destroy_window_ev"

external get_raw_unmap_notify_ev : unit -> nativeint = "get_raw_unmap_notify_ev"
external get_raw_map_notify_ev : unit -> nativeint = "get_raw_map_notify_ev"
external get_raw_map_request_ev : unit -> nativeint = "get_raw_map_request_ev"

external get_raw_configure_request_ev : unit -> nativeint
  = "get_raw_configure_request_ev"

external get_raw_reparent_notify_ev : unit -> nativeint
  = "get_raw_reparent_notify_ev"

external get_raw_configure_notify_ev : unit -> nativeint
  = "get_raw_configure_notify_ev"

external get_raw_property_notify_ev : unit -> nativeint
  = "get_raw_property_notify_ev"

external get_raw_client_message_ev_b : unit -> nativeint
  = "get_raw_client_message_ev_b"

external get_raw_client_message_ev_s : unit -> nativeint
  = "get_raw_client_message_ev_s"

external get_raw_client_message_ev_l : unit -> nativeint
  = "get_raw_client_message_ev_l"

external get_raw_focus_in_ev : unit -> nativeint = "get_raw_focus_in_ev"
external get_raw_enter_notify_ev : unit -> nativeint = "get_raw_enter_notify_ev"
external get_raw_leave_notify_ev : unit -> nativeint = "get_raw_leave_notify_ev"

external get_raw_motion_notify_hint_ev : unit -> nativeint
  = "get_raw_motion_notify_hint_ev"

(* Convert the raw C events through the ctypes view *)
(* The C stubs return the address of a static [XEvent]: read it through the
   same ctypes view as [next_event] *)
let xevent_of_raw_address address =
  Ctypes.(!@(from_voidp Xevent_ctypes.xevent_typ (ptr_of_raw_address address)))

let display_address display =
  Nativeint.to_int (Ctypes.raw_address_of_ptr display)

let get_key_press_ev () = xevent_of_raw_address (get_raw_key_press_ev ())
let get_key_release_ev () = xevent_of_raw_address (get_raw_key_release_ev ())
let get_button_press_ev () = xevent_of_raw_address (get_raw_button_press_ev ())

let get_motion_notify_ev () =
  xevent_of_raw_address (get_raw_motion_notify_ev ())

let get_expose_ev () = xevent_of_raw_address (get_raw_expose_ev ())
let get_expose_last_ev () = xevent_of_raw_address (get_raw_expose_last_ev ())

let get_destroy_window_ev () =
  xevent_of_raw_address (get_raw_destroy_window_ev ())

let get_unmap_notify_ev () = xevent_of_raw_address (get_raw_unmap_notify_ev ())
let get_map_notify_ev () = xevent_of_raw_address (get_raw_map_notify_ev ())
let get_map_request_ev () = xevent_of_raw_address (get_raw_map_request_ev ())

let get_configure_request_ev () =
  xevent_of_raw_address (get_raw_configure_request_ev ())

let get_reparent_notify_ev () =
  xevent_of_raw_address (get_raw_reparent_notify_ev ())

let get_configure_notify_ev () =
  xevent_of_raw_address (get_raw_configure_notify_ev ())

let get_property_notify_ev () =
  xevent_of_raw_address (get_raw_property_notify_ev ())

let get_client_message_ev_b () =
  xevent_of_raw_address (get_raw_client_message_ev_b ())

let get_client_message_ev_s () =
  xevent_of_raw_address (get_raw_client_message_ev_s ())

let get_client_message_ev_l () =
  xevent_of_raw_address (get_raw_client_message_ev_l ())

let get_focus_in_ev () = xevent_of_raw_address (get_raw_focus_in_ev ())
let get_enter_notify_ev () = xevent_of_raw_address (get_raw_enter_notify_ev ())
let get_leave_notify_ev () = xevent_of_raw_address (get_raw_leave_notify_ev ())

let get_motion_notify_hint_ev () =
  xevent_of_raw_address (get_raw_motion_notify_hint_ev ())

external get_raw_destroy_window_self_ev : unit -> nativeint
  = "get_raw_destroy_window_self_ev"

let get_destroy_window_self_ev () =
  xevent_of_raw_address (get_raw_destroy_window_self_ev ())

external get_raw_unmap_notify_synthetic_ev : unit -> nativeint
  = "get_raw_unmap_notify_synthetic_ev"

let get_unmap_notify_synthetic_ev () =
  xevent_of_raw_address (get_raw_unmap_notify_synthetic_ev ())

external get_raw_map_notify_override_ev : unit -> nativeint
  = "get_raw_map_notify_override_ev"

let get_map_notify_override_ev () =
  xevent_of_raw_address (get_raw_map_notify_override_ev ())

external get_raw_map_request_root_ev : unit -> nativeint
  = "get_raw_map_request_root_ev"

let get_map_request_root_ev () =
  xevent_of_raw_address (get_raw_map_request_root_ev ())

external get_raw_configure_request_restack_ev : unit -> nativeint
  = "get_raw_configure_request_restack_ev"

let get_configure_request_restack_ev () =
  xevent_of_raw_address (get_raw_configure_request_restack_ev ())

external get_raw_reparent_notify_root_ev : unit -> nativeint
  = "get_raw_reparent_notify_root_ev"

let get_reparent_notify_root_ev () =
  xevent_of_raw_address (get_raw_reparent_notify_root_ev ())

external get_raw_configure_notify_synthetic_ev : unit -> nativeint
  = "get_raw_configure_notify_synthetic_ev"

let get_configure_notify_synthetic_ev () =
  xevent_of_raw_address (get_raw_configure_notify_synthetic_ev ())

external get_raw_property_notify_delete_ev : unit -> nativeint
  = "get_raw_property_notify_delete_ev"

let get_property_notify_delete_ev () =
  xevent_of_raw_address (get_raw_property_notify_delete_ev ())

external get_raw_mapping_notify_keyboard_ev : unit -> nativeint
  = "get_raw_mapping_notify_keyboard_ev"

let get_mapping_notify_keyboard_ev () =
  xevent_of_raw_address (get_raw_mapping_notify_keyboard_ev ())

external get_raw_mapping_notify_pointer_ev : unit -> nativeint
  = "get_raw_mapping_notify_pointer_ev"

let get_mapping_notify_pointer_ev () =
  xevent_of_raw_address (get_raw_mapping_notify_pointer_ev ())

let test_key_press_ev () =
  match get_key_press_ev () with
  | KeyPress ev ->
      Alcotest.(check int) "serial" 42 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "display" 0x1234 (display_address ev.display);
      Alcotest.(check int) "window" 123 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "root" 456 (Unsigned.ULong.to_int ev.root);
      Alcotest.(check int) "subwindow" 789 (Unsigned.ULong.to_int ev.subwindow);
      Alcotest.(check int) "time" 1000 (Unsigned.ULong.to_int ev.time);
      Alcotest.(check (pair int int)) "pos" (10, 20) ev.pos;
      Alcotest.(check (pair int int)) "pos_root" (100, 200) ev.pos_root;
      Alcotest.(check int) "state" 0 ev.state;
      Alcotest.(check int) "keycode" 65 ev.keycode;
      Alcotest.(check bool) "same_screen" true ev.same_screen
  | _ -> Alcotest.fail "Expected KeyPress event"

let test_key_release_ev () =
  match get_key_release_ev () with
  | KeyRelease ev ->
      Alcotest.(check int) "serial" 42 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "display" 0x1234 (display_address ev.display);
      Alcotest.(check int) "window" 123 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "root" 456 (Unsigned.ULong.to_int ev.root);
      Alcotest.(check int) "subwindow" 789 (Unsigned.ULong.to_int ev.subwindow);
      Alcotest.(check int) "time" 1000 (Unsigned.ULong.to_int ev.time);
      Alcotest.(check (pair int int)) "pos" (10, 20) ev.pos;
      Alcotest.(check (pair int int)) "pos_root" (100, 200) ev.pos_root;
      Alcotest.(check int) "state" 0 ev.state;
      Alcotest.(check int) "keycode" 65 ev.keycode;
      Alcotest.(check bool) "same_screen" true ev.same_screen
  | _ -> Alcotest.fail "Expected KeyRelease event"

let test_button_press_ev () =
  match get_button_press_ev () with
  | ButtonPress ev ->
      Alcotest.(check int) "serial" 100 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "display" 0x5678 (display_address ev.display);
      Alcotest.(check int) "window" 111 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "root" 222 (Unsigned.ULong.to_int ev.root);
      Alcotest.(check int) "subwindow" 333 (Unsigned.ULong.to_int ev.subwindow);
      Alcotest.(check int) "time" 2000 (Unsigned.ULong.to_int ev.time);
      Alcotest.(check (pair int int)) "pos" (50, 75) ev.pos;
      Alcotest.(check (pair int int)) "pos_root" (150, 250) ev.pos_root;
      Alcotest.(check int) "state" 1 ev.state;
      Alcotest.(check int) "button" button1 ev.button;
      Alcotest.(check bool) "same_screen" true ev.same_screen
  | _ -> Alcotest.fail "Expected ButtonPress event"

let test_motion_notify_ev () =
  match get_motion_notify_ev () with
  | MotionNotify ev ->
      Alcotest.(check int) "serial" 200 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "display" 0x9abc (display_address ev.display);
      Alcotest.(check int) "window" 211 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "root" 212 (Unsigned.ULong.to_int ev.root);
      Alcotest.(check int) "subwindow" 213 (Unsigned.ULong.to_int ev.subwindow);
      Alcotest.(check int) "time" 3000 (Unsigned.ULong.to_int ev.time);
      Alcotest.(check (pair int int)) "pos" (30, 40) ev.pos;
      Alcotest.(check (pair int int)) "pos_root" (130, 240) ev.pos_root;
      Alcotest.(check int) "state" 2 ev.state;
      Alcotest.(check bool) "is_hint" false ev.is_hint;
      Alcotest.(check bool) "same_screen" true ev.same_screen
  | _ -> Alcotest.fail "Expected MotionNotify event"

let test_motion_notify_hint_ev () =
  match get_motion_notify_hint_ev () with
  | MotionNotify ev ->
      Alcotest.(check int) "serial" 201 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check (pair int int)) "pos" (31, 41) ev.pos;
      Alcotest.(check int) "state" 256 ev.state;
      Alcotest.(check bool) "is_hint" true ev.is_hint;
      Alcotest.(check bool) "same_screen" true ev.same_screen
  | _ -> Alcotest.fail "Expected MotionNotify event"

let test_expose_ev () =
  match get_expose_ev () with
  | Expose ev ->
      Alcotest.(check int) "serial" 300 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "display" 0xdef0 (display_address ev.display);
      Alcotest.(check int) "window" 311 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check (pair int int)) "pos" (5, 15) ev.pos;
      Alcotest.(check (pair int int)) "size" (800, 600) ev.size;
      Alcotest.(check int) "count" 3 ev.count
  | _ -> Alcotest.fail "Expected Expose event"

(* Last event of an Expose series: count = 0, large multi-monitor geometry *)
let test_expose_last_ev () =
  match get_expose_last_ev () with
  | Expose ev ->
      Alcotest.(check int) "serial" 301 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check (pair int int)) "pos" (1920, 1080) ev.pos;
      Alcotest.(check (pair int int)) "size" (3840, 2160) ev.size;
      Alcotest.(check int) "count" 0 ev.count
  | _ -> Alcotest.fail "Expected Expose event"

let test_destroy_window_ev () =
  match get_destroy_window_ev () with
  | DestroyWindow ev ->
      Alcotest.(check int) "serial" 150 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "event" 5001 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 5002 (Unsigned.ULong.to_int ev.window)
  | _ -> Alcotest.fail "Expected DestroyWindow"

let test_unmap_notify_ev () =
  match get_unmap_notify_ev () with
  | Unmap ev ->
      Alcotest.(check int) "serial" 160 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "event" 6001 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 6002 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check bool) "from_configure" false ev.from_configure
  | _ -> Alcotest.fail "Expected Unmap"

let test_map_notify_ev () =
  match get_map_notify_ev () with
  | Map ev ->
      Alcotest.(check int) "serial" 170 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "event" 7001 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 7002 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check bool) "override_redirect" false ev.override_redirect
  | _ -> Alcotest.fail "Expected Map"

let test_map_request_ev () =
  match get_map_request_ev () with
  | MapRequest ev ->
      Alcotest.(check int) "serial" 180 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "parent" 8001 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check int) "window" 8002 (Unsigned.ULong.to_int ev.window)
  | _ -> Alcotest.fail "Expected MapRequest"

let test_configure_request_ev () =
  match get_configure_request_ev () with
  | ConfigureRequest ev ->
      Alcotest.(check int) "serial" 190 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "parent" 9001 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check int) "window" 9002 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check (pair int int)) "pos" (100, 100) ev.pos;
      Alcotest.(check (pair int int)) "size" (800, 600) ev.size;
      Alcotest.(check int) "border_width" 1 ev.border_width;
      Alcotest.(check int) "above" 9003 (Unsigned.ULong.to_int ev.above);
      Alcotest.(check bool) "detail" true (ev.detail = Above);
      Alcotest.(check int) "value_mask" 15 ev.value_mask
  | _ -> Alcotest.fail "Expected ConfigureRequest"

let test_reparent_notify_ev () =
  match get_reparent_notify_ev () with
  | Reparent ev ->
      Alcotest.(check int) "serial" 210 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "event" 2101 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 2102 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "parent" 2103 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check (pair int int)) "pos" (10, 20) ev.pos;
      Alcotest.(check bool) "override_redirect" false ev.override_redirect
  | _ -> Alcotest.fail "Expected Reparent event"

let test_configure_notify_ev () =
  match get_configure_notify_ev () with
  | ConfigureNotify ev ->
      Alcotest.(check int) "serial" 220 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "event" 2201 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 2202 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check (pair int int)) "pos" (100, 200) ev.pos;
      Alcotest.(check (pair int int)) "size" (1024, 768) ev.size;
      Alcotest.(check int) "border_width" 2 ev.border_width;
      Alcotest.(check int) "above" 2203 (Unsigned.ULong.to_int ev.above);
      Alcotest.(check bool) "override_redirect" true ev.override_redirect
  | _ -> Alcotest.fail "Expected ConfigureNotify event"

let test_property_notify_ev () =
  match get_property_notify_ev () with
  | Property ev ->
      Alcotest.(check int) "serial" 280 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check int) "window" 2801 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "atom" 2802 (Unsigned.ULong.to_int ev.atom);
      Alcotest.(check int) "time" 5000 (Unsigned.ULong.to_int ev.time);
      Alcotest.(check bool) "state" true (ev.state = PropertyNewValue)
  | _ -> Alcotest.fail "Expected Property event"

let test_client_message_ev_b () =
  match get_client_message_ev_b () with
  | ClientMessage ev -> (
      Alcotest.(check int) "serial" 330 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      match ev.data with
      | Bytes b ->
          Alcotest.(check (seq char))
            "data"
            ("ABCDEFGHIJKLMNOPQRST" |> String.to_seq)
            (Array.to_seq b)
      | _ -> Alcotest.fail "Expected bytes")
  | _ -> Alcotest.fail "Expected ClientMessage event"

let test_client_meessage_ev_s () =
  match get_client_message_ev_s () with
  | ClientMessage ev -> (
      match ev.data with
      | Shorts s ->
          Alcotest.(check (array int))
            "data"
            [| 0; 1; 2; 3; 4; 5; 6; 7; 8; 9 |]
            s
      | _ -> Alcotest.fail "Expected short")
  | _ -> Alcotest.fail "Expected ClientMessage event"

let test_client_meessage_ev_l () =
  match get_client_message_ev_l () with
  | ClientMessage ev -> (
      match ev.data with
      | Longs s ->
          Alcotest.(check (array int))
            "data" [| 0; 1; 2; 3; 4 |]
            (Array.map Signed.Long.to_int s)
      | _ -> Alcotest.fail "Expected long")
  | _ -> Alcotest.fail "Expected ClientMessage event"

let test_focus_in_ev () =
  match get_focus_in_ev () with
  | FocusIn ev ->
      Alcotest.(check int) "serial" 90 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" false ev.send_event;
      Alcotest.(check bool) "mode" true (ev.mode = NotifyNormal);
      Alcotest.(check bool) "detail" true (ev.detail = NotifyNonlinear)
  | _ -> Alcotest.fail "Expected FocusIn event"

let test_enter_notify_ev () =
  match get_enter_notify_ev () with
  | EnterNotify ev ->
      Alcotest.(check int) "serial" 400 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check (pair int int)) "pos" (12, 34) ev.pos;
      Alcotest.(check (pair int int)) "pos_root" (112, 134) ev.pos_root;
      Alcotest.(check bool) "mode" true (ev.mode = NotifyGrab);
      Alcotest.(check bool) "detail" true (ev.detail = NotifyInferior);
      Alcotest.(check bool) "same_screen" true ev.same_screen;
      Alcotest.(check bool) "focus" true ev.focus;
      Alcotest.(check int) "state" 4 ev.state
  | _ -> Alcotest.fail "Expected EnterNotify event"

let test_leave_notify_ev () =
  match get_leave_notify_ev () with
  | LeaveNotify ev ->
      Alcotest.(check int) "serial" 410 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check (pair int int)) "pos" (56, 78) ev.pos;
      Alcotest.(check (pair int int)) "pos_root" (156, 178) ev.pos_root;
      Alcotest.(check bool) "mode" true (ev.mode = NotifyUngrab);
      Alcotest.(check bool) "detail" true (ev.detail = NotifyNonlinearVirtual);
      Alcotest.(check bool) "same_screen" false ev.same_screen;
      Alcotest.(check bool) "focus" false ev.focus;
      Alcotest.(check int) "state" 0 ev.state
  | _ -> Alcotest.fail "Expected LeaveNotify event"

(* StructureNotify selected on the destroyed window itself: event = window *)
let test_destroy_window_self_ev () =
  match get_destroy_window_self_ev () with
  | DestroyWindow ev ->
      Alcotest.(check int) "serial" 151 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "event" 5003 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 5003 (Unsigned.ULong.to_int ev.window)
  | _ -> Alcotest.fail "Expected DestroyWindow"

(* ICCCM withdrawal: the client sends a synthetic UnmapNotify to the root *)
let test_unmap_notify_synthetic_ev () =
  match get_unmap_notify_synthetic_ev () with
  | Unmap ev ->
      Alcotest.(check int) "serial" 161 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "event" 1 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 6003 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check bool) "from_configure" true ev.from_configure
  | _ -> Alcotest.fail "Expected Unmap"

(* Override-redirect window (popup menu, tooltip): a WM must not manage it *)
let test_map_notify_override_ev () =
  match get_map_notify_override_ev () with
  | Map ev ->
      Alcotest.(check int) "serial" 171 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "event" 1 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 7003 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check bool) "override_redirect" true ev.override_redirect
  | _ -> Alcotest.fail "Expected Map"

(* Top-level window mapped by a client: the parent is the root window. The
   window id has the high bits a real XID carries (resource-id-base). *)
let test_map_request_root_ev () =
  match get_map_request_root_ev () with
  | MapRequest ev ->
      Alcotest.(check int) "serial" 181 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "parent" 1 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check int) "window" 0x1e00007 (Unsigned.ULong.to_int ev.window)
  | _ -> Alcotest.fail "Expected MapRequest"

(* Client moving itself partly off-screen and restacking below a sibling *)
let test_configure_request_restack_ev () =
  match get_configure_request_restack_ev () with
  | ConfigureRequest ev ->
      Alcotest.(check int) "serial" 191 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "parent" 1 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check int) "window" 9004 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check (pair int int)) "pos" (-50, -20) ev.pos;
      Alcotest.(check (pair int int)) "size" (640, 480) ev.size;
      Alcotest.(check int) "border_width" 0 ev.border_width;
      Alcotest.(check int) "above" 9005 (Unsigned.ULong.to_int ev.above);
      Alcotest.(check bool) "detail" true (ev.detail = Below);
      (* CWX | CWY | CWSibling | CWStackMode *)
      Alcotest.(check int) "value_mask" (1 + 2 + 32 + 64) ev.value_mask
  | _ -> Alcotest.fail "Expected ConfigureRequest"

(* Window handed back to the root (e.g. the WM releasing it), reported to the
   window itself. Also covers the [true] values of the boolean fields. *)
let test_reparent_notify_root_ev () =
  match get_reparent_notify_root_ev () with
  | Reparent ev ->
      Alcotest.(check int) "serial" 211 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "event" 2104 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 2104 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "parent" 1 (Unsigned.ULong.to_int ev.parent);
      Alcotest.(check (pair int int)) "pos" (640, 480) ev.pos;
      Alcotest.(check bool) "override_redirect" true ev.override_redirect
  | _ -> Alcotest.fail "Expected Reparent event"

(* Synthetic ConfigureNotify a WM sends to a reparented client (ICCCM 4.1.5):
   root coordinates, no sibling *)
let test_configure_notify_synthetic_ev () =
  match get_configure_notify_synthetic_ev () with
  | ConfigureNotify ev ->
      Alcotest.(check int) "serial" 221 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "event" 2204 (Unsigned.ULong.to_int ev.event);
      Alcotest.(check int) "window" 2204 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check (pair int int)) "pos" (1925, 30) ev.pos;
      Alcotest.(check (pair int int)) "size" (1280, 720) ev.size;
      Alcotest.(check int) "border_width" 0 ev.border_width;
      Alcotest.(check int) "above" 0 (Unsigned.ULong.to_int ev.above);
      Alcotest.(check bool) "override_redirect" false ev.override_redirect
  | _ -> Alcotest.fail "Expected ConfigureNotify event"

(* Property deleted, with a server timestamp above 2^31: X times are unsigned
   32-bit and wrap after ~49 days *)
let test_property_notify_delete_ev () =
  match get_property_notify_delete_ev () with
  | Property ev ->
      Alcotest.(check int) "serial" 281 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "window" 2803 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check int) "atom" 2804 (Unsigned.ULong.to_int ev.atom);
      Alcotest.(check int) "time" 0xFFFFFFF0 (Unsigned.ULong.to_int ev.time);
      Alcotest.(check bool) "state" true (ev.state = PropertyDelete)
  | _ -> Alcotest.fail "Expected Property event"

(* Keyboard remapped, e.g. by setxkbmap: every keycode from 8 to 255 *)
let test_mapping_notify_keyboard_ev () =
  match get_mapping_notify_keyboard_ev () with
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
  match get_mapping_notify_pointer_ev () with
  | Mapping ev ->
      Alcotest.(check int) "serial" 341 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      Alcotest.(check int) "display" 0x3336 (display_address ev.display);
      Alcotest.(check int) "window" 3402 (Unsigned.ULong.to_int ev.window);
      Alcotest.(check bool) "request" true (ev.request = MappingPointer);
      Alcotest.(check int) "first_keycode" 0 ev.first_keycode;
      Alcotest.(check int) "count" 0 ev.count
  | _ -> Alcotest.fail "Expected Mapping event"

let () =
  let open Alcotest in
  run "X11 XEvent"
    [
      ( "XEvent",
        [
          test_case "KeyPress" `Quick test_key_press_ev;
          test_case "KeyRelease" `Quick test_key_release_ev;
          test_case "ButtonPress" `Quick test_button_press_ev;
          test_case "MotionNotify" `Quick test_motion_notify_ev;
          test_case "MotionNotify (hint)" `Quick test_motion_notify_hint_ev;
          test_case "Expose" `Quick test_expose_ev;
          test_case "Expose (last in series)" `Quick test_expose_last_ev;
          test_case "DestroyWindow" `Quick test_destroy_window_ev;
          test_case "DestroyWindow (self)" `Quick test_destroy_window_self_ev;
          test_case "UnmapNotify" `Quick test_unmap_notify_ev;
          test_case "UnmapNotify (synthetic)" `Quick
            test_unmap_notify_synthetic_ev;
          test_case "MapNotify" `Quick test_map_notify_ev;
          test_case "MapNotify (override redirect)" `Quick
            test_map_notify_override_ev;
          test_case "MapRequest" `Quick test_map_request_ev;
          test_case "MapRequest (root parent)" `Quick test_map_request_root_ev;
          test_case "ConfigureRequest" `Quick test_configure_request_ev;
          test_case "ConfigureRequest (restack)" `Quick
            test_configure_request_restack_ev;
          test_case "ReparentNotify" `Quick test_reparent_notify_ev;
          test_case "ReparentNotify (to root)" `Quick
            test_reparent_notify_root_ev;
          test_case "ConfigureNotify" `Quick test_configure_notify_ev;
          test_case "ConfigureNotify (synthetic)" `Quick
            test_configure_notify_synthetic_ev;
          test_case "PropertyNotify" `Quick test_property_notify_ev;
          test_case "PropertyNotify (delete)" `Quick
            test_property_notify_delete_ev;
          test_case "MappingNotify (keyboard)" `Quick
            test_mapping_notify_keyboard_ev;
          test_case "MappingNotify (pointer)" `Quick
            test_mapping_notify_pointer_ev;
          test_case "ClientMessage (bytes)" `Quick test_client_message_ev_b;
          test_case "ClientMessage (shorts)" `Quick test_client_meessage_ev_s;
          test_case "ClientMessage (longs)" `Quick test_client_meessage_ev_l;
          test_case "FocusIn" `Quick test_focus_in_ev;
          test_case "EnterNotify" `Quick test_enter_notify_ev;
          test_case "LeaveNotify" `Quick test_leave_notify_ev;
        ] );
    ]
