open Xevent
open Ctypes
open C.Types
module Ev = Type_description.Event_type

let key_of_c ev : keyEvent =
  {
    serial = getf ev xkey_serial;
    send_event = 0 <> getf ev xkey_send_event;
    display = getf ev xkey_display;
    window = getf ev xkey_window;
    root = getf ev xkey_root;
    subwindow = getf ev xkey_subwindow;
    time = getf ev xkey_time;
    pos = (getf ev xkey_x, getf ev xkey_y);
    pos_root = (getf ev xkey_x_root, getf ev xkey_y_root);
    state = Unsigned.UInt.to_int (getf ev xkey_state);
    keycode = Unsigned.UInt.to_int (getf ev xkey_keycode);
    same_screen = 0 <> getf ev xkey_same_screen;
  }

let button_of_c ev : buttonEvent =
  {
    serial = getf ev xbutton_serial;
    send_event = 0 <> getf ev xbutton_send_event;
    display = getf ev xbutton_display;
    window = getf ev xbutton_window;
    root = getf ev xbutton_root;
    subwindow = getf ev xbutton_subwindow;
    time = getf ev xbutton_time;
    pos = (getf ev xbutton_x, getf ev xbutton_y);
    pos_root = (getf ev xbutton_x_root, getf ev xbutton_y_root);
    state = Unsigned.UInt.to_int (getf ev xbutton_state);
    button = Unsigned.UInt.to_int (getf ev xbutton_button);
    same_screen = 0 <> getf ev xbutton_same_screen;
  }

let client_message_of_c ev : clientMessageEvent =
  let format = getf ev xc_format in
  let data =
    match format with
    | 8 ->
        let arr = getf ev xc_data_b in
        Bytes (Array.init 20 (fun i -> CArray.get arr i))
    | 16 ->
        let arr = getf ev xc_data_s in
        Shorts (Array.init 10 (fun i -> CArray.get arr i))
    | 32 ->
        let arr = getf ev xc_data_l in
        Longs (Array.init 5 (fun i -> CArray.get arr i))
    | _ -> failwith (Printf.sprintf "Invalid ClientMessage format: %d" format)
  in
  {
    serial = getf ev xc_serial;
    send_event = 0 <> getf ev xc_send_event;
    display = getf ev xc_display;
    window = getf ev xc_window;
    message_type = getf ev xc_message_type;
    data;
  }

let motion_of_c ev : motionEvent =
  {
    serial = getf ev xmotion_serial;
    send_event = 0 <> getf ev xmotion_send_event;
    display = getf ev xmotion_display;
    window = getf ev xmotion_window;
    root = getf ev xmotion_root;
    subwindow = getf ev xmotion_subwindow;
    time = getf ev xmotion_time;
    pos = (getf ev xmotion_x, getf ev xmotion_y);
    pos_root = (getf ev xmotion_x_root, getf ev xmotion_y_root);
    state = Unsigned.UInt.to_int (getf ev xmotion_state);
    is_hint = getf ev xmotion_is_hint <> '\000';
    same_screen = 0 <> getf ev xmotion_same_screen;
  }

let focus_of_c ev : focusChangeEvent =
  {
    serial = getf ev xfocus_serial;
    send_event = 0 <> getf ev xfocus_send_event;
    display = getf ev xfocus_display;
    window = getf ev xfocus_window;
    mode = getf ev xfocus_mode;
    detail = getf ev xfocus_detail;
  }

let crossing_of_c ev : crossingEvent =
  {
    serial = getf ev xcrossing_serial;
    send_event = 0 <> getf ev xcrossing_send_event;
    display = getf ev xcrossing_display;
    window = getf ev xcrossing_window;
    root = getf ev xcrossing_root;
    subwindow = getf ev xcrossing_subwindow;
    time = getf ev xcrossing_time;
    pos = (getf ev xcrossing_x, getf ev xcrossing_y);
    pos_root = (getf ev xcrossing_x_root, getf ev xcrossing_y_root);
    mode = getf ev xcrossing_mode;
    detail = getf ev xcrossing_detail;
    same_screen = 0 <> getf ev xcrossing_same_screen;
    focus = 0 <> getf ev xcrossing_focus;
    state = Unsigned.UInt.to_int (getf ev xcrossing_state);
  }

let expose_of_c ev : exposeEvent =
  {
    serial = getf ev xexpose_serial;
    send_event = 0 <> getf ev xexpose_send_event;
    display = getf ev xexpose_display;
    window = getf ev xexpose_window;
    pos = (getf ev xexpose_x, getf ev xexpose_y);
    size = (getf ev xexpose_width, getf ev xexpose_height);
    count = getf ev xexpose_count;
  }

let create_window_of_c ev : createWindowEvent =
  {
    serial = getf ev xcreatewindow_serial;
    send_event = 0 <> getf ev xcreatewindow_send_event;
    display = getf ev xcreatewindow_display;
    parent = getf ev xcreatewindow_parent;
    window = getf ev xcreatewindow_window;
    pos = (getf ev xcreatewindow_x, getf ev xcreatewindow_y);
    size = (getf ev xcreatewindow_width, getf ev xcreatewindow_height);
    border_width = getf ev xcreatewindow_border_width;
    override_redirect = 0 <> getf ev xcreatewindow_override_redirect;
  }

let destroy_window_of_c ev : destroyWindowEvent =
  {
    serial = getf ev xdestroywindow_serial;
    send_event = 0 <> getf ev xdestroywindow_send_event;
    display = getf ev xdestroywindow_display;
    event = getf ev xdestroywindow_event_window;
    window = getf ev xdestroywindow_window;
  }

let unmap_of_c ev : unmapEvent =
  {
    serial = getf ev xunmap_serial;
    send_event = 0 <> getf ev xunmap_send_event;
    display = getf ev xunmap_display;
    event = getf ev xunmap_event_window;
    window = getf ev xunmap_window;
    from_configure = 0 <> getf ev xunmap_from_configure;
  }

let map_of_c ev : mapEvent =
  {
    serial = getf ev xmap_serial;
    send_event = 0 <> getf ev xmap_send_event;
    display = getf ev xmap_display;
    event = getf ev xmap_event_window;
    window = getf ev xmap_window;
    override_redirect = 0 <> getf ev xmap_override_redirect;
  }

let map_request_of_c ev : mapRequestEvent =
  {
    serial = getf ev xmaprequest_serial;
    send_event = 0 <> getf ev xmaprequest_send_event;
    display = getf ev xmaprequest_display;
    parent = getf ev xmaprequest_parent;
    window = getf ev xmaprequest_window;
  }

let configure_request_of_c ev : configureRequestEvent =
  {
    serial = getf ev xconfigurerequest_serial;
    send_event = 0 <> getf ev xconfigurerequest_send_event;
    display = getf ev xconfigurerequest_display;
    parent = getf ev xconfigurerequest_parent;
    window = getf ev xconfigurerequest_window;
    pos = (getf ev xconfigurerequest_x, getf ev xconfigurerequest_y);
    size = (getf ev xconfigurerequest_width, getf ev xconfigurerequest_height);
    border_width = getf ev xconfigurerequest_border_width;
    above = getf ev xconfigurerequest_above;
    detail = getf ev xconfigurerequest_detail;
    value_mask = Unsigned.ULong.to_int (getf ev xconfigurerequest_value_mask);
  }

let reparent_of_c ev : reparentEvent =
  {
    serial = getf ev xreparent_serial;
    send_event = 0 <> getf ev xreparent_send_event;
    display = getf ev xreparent_display;
    event = getf ev xreparent_event_window;
    window = getf ev xreparent_window;
    parent = getf ev xreparent_parent;
    pos = (getf ev xreparent_x, getf ev xreparent_y);
    override_redirect = 0 <> getf ev xreparent_override_redirect;
  }

let configure_of_c ev : configureEvent =
  {
    serial = getf ev xconfigure_serial;
    send_event = 0 <> getf ev xconfigure_send_event;
    display = getf ev xconfigure_display;
    event = getf ev xconfigure_event_window;
    window = getf ev xconfigure_window;
    pos = (getf ev xconfigure_x, getf ev xconfigure_y);
    size = (getf ev xconfigure_width, getf ev xconfigure_height);
    border_width = getf ev xconfigure_border_width;
    above = getf ev xconfigure_above;
    override_redirect = 0 <> getf ev xconfigure_override_redirect;
  }

let gravity_of_c ev : gravityEvent =
  {
    serial = getf ev xgravity_serial;
    send_event = 0 <> getf ev xgravity_send_event;
    display = getf ev xgravity_display;
    event = getf ev xgravity_event_window;
    window = getf ev xgravity_window;
    pos = (getf ev xgravity_x, getf ev xgravity_y);
  }

let circulate_of_c ev : circulateEvent =
  {
    serial = getf ev xcirculate_serial;
    send_event = 0 <> getf ev xcirculate_send_event;
    display = getf ev xcirculate_display;
    event = getf ev xcirculate_event_window;
    window = getf ev xcirculate_window;
    place = getf ev xcirculate_place;
  }

let property_of_c ev : propertyEvent =
  {
    serial = getf ev xproperty_serial;
    send_event = 0 <> getf ev xproperty_send_event;
    display = getf ev xproperty_display;
    window = getf ev xproperty_window;
    atom = getf ev xproperty_atom;
    time = getf ev xproperty_time;
    state = getf ev xproperty_state;
  }

let mapping_of_c ev : mappingEvent =
  {
    serial = getf ev xmapping_serial;
    send_event = 0 <> getf ev xmapping_send_event;
    display = getf ev xmapping_display;
    window = getf ev xmapping_window;
    request = getf ev xmapping_request;
    first_keycode = getf ev xmapping_first_keycode;
    count = getf ev xmapping_count;
  }

let xevent_of_c (raw_ev : xevent_union union) =
  match getf (getf raw_ev xev_any) xany_type with
  | Ev.KeyPress -> KeyPress (key_of_c (getf raw_ev xev_key))
  | Ev.KeyRelease -> KeyRelease (key_of_c (getf raw_ev xev_key))
  | Ev.ButtonPress -> ButtonPress (button_of_c (getf raw_ev xev_button))
  | Ev.ButtonRelease -> ButtonRelease (button_of_c (getf raw_ev xev_button))
  | Ev.ClientMessage ->
      ClientMessage (client_message_of_c (getf raw_ev xev_client))
  | Ev.MotionNotify -> MotionNotify (motion_of_c (getf raw_ev xev_motion))
  | Ev.EnterNotify -> EnterNotify (crossing_of_c (getf raw_ev xev_crossing))
  | Ev.LeaveNotify -> LeaveNotify (crossing_of_c (getf raw_ev xev_crossing))
  | Ev.FocusIn -> FocusIn (focus_of_c (getf raw_ev xev_focus))
  | Ev.FocusOut -> FocusOut (focus_of_c (getf raw_ev xev_focus))
  | Ev.KeymapNotify -> failwith "Unsupported type KeymapNotify"
  | Ev.Expose -> Expose (expose_of_c (getf raw_ev xev_expose))
  | Ev.GraphicsExpose -> failwith "Unsupported type GraphicsExpose"
  | Ev.NoExpose -> failwith "Unsupported type NoExpose"
  | Ev.VisibilityNotify -> failwith "Unsupported type VisibilityNotify"
  | Ev.CreateNotify ->
      CreateWindow (create_window_of_c (getf raw_ev xev_createwindow))
  | Ev.DestroyNotify ->
      DestroyWindow (destroy_window_of_c (getf raw_ev xev_destroywindow))
  | Ev.UnmapNotify -> Unmap (unmap_of_c (getf raw_ev xev_unmap))
  | Ev.MapNotify -> Map (map_of_c (getf raw_ev xev_map))
  | Ev.MapRequest -> MapRequest (map_request_of_c (getf raw_ev xev_maprequest))
  | Ev.ReparentNotify -> Reparent (reparent_of_c (getf raw_ev xev_reparent))
  | Ev.ConfigureNotify ->
      ConfigureNotify (configure_of_c (getf raw_ev xev_configure))
  | Ev.ConfigureRequest ->
      ConfigureRequest
        (configure_request_of_c (getf raw_ev xev_configurerequest))
  | Ev.GravityNotify -> GravityNotify (gravity_of_c (getf raw_ev xev_gravity))
  | Ev.ResizeRequest -> failwith "Unsupported type ResizeRequest"
  | Ev.CirculateNotify -> Circulate (circulate_of_c (getf raw_ev xev_circulate))
  | Ev.CirculateRequest -> failwith "Unsupported type CirculateRequest"
  | Ev.PropertyNotify -> Property (property_of_c (getf raw_ev xev_property))
  | Ev.SelectionClear -> failwith "Unsupported type SelectionClear"
  | Ev.SelectionRequest -> failwith "Unsupported type SelectionRequest"
  | Ev.SelectionNotify -> failwith "Unsupported type SelectionNotify"
  | Ev.ColormapNotify -> failwith "Unsupported type ColormapNotify"
  | Ev.MappingNotify -> Mapping (mapping_of_c (getf raw_ev xev_mapping))
  | Ev.GenericEvent -> failwith "Unsupported type GenericEvent"
  | Ev.Unknown n -> failwith (Printf.sprintf "Unknown event type '%Ld'" n)

let c_of_xevent (_ : xEvent) : xevent_union union = failwith "Not implemented"

let xevent_typ : xEvent typ =
  view ~read:xevent_of_c ~write:c_of_xevent xevent_union
