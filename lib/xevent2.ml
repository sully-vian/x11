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

let xevent_of_c (raw_ev : xevent_union union) =
  match getf (getf raw_ev xev_any) xany_type with
  | Ev.KeyPress -> KeyPress (key_of_c (getf raw_ev xev_key))
  | Ev.KeyRelease -> KeyRelease (key_of_c (getf raw_ev xev_key))
  | Ev.ButtonPress -> ButtonPress (button_of_c (getf raw_ev xev_button))
  | Ev.ButtonRelease -> ButtonRelease (button_of_c (getf raw_ev xev_button))
  | Ev.ClientMessage ->
      ClientMessage (client_message_of_c (getf raw_ev xev_client))
  | Ev.MotionNotify -> failwith "Unsupported type MotionNotify"
  | Ev.EnterNotify -> EnterNotify (crossing_of_c (getf raw_ev xev_crossing))
  | Ev.LeaveNotify -> LeaveNotify (crossing_of_c (getf raw_ev xev_crossing))
  | Ev.FocusIn -> FocusIn (focus_of_c (getf raw_ev xev_focus))
  | Ev.FocusOut -> FocusOut (focus_of_c (getf raw_ev xev_focus))
  | Ev.KeymapNotify -> failwith "Unsupported type KeymapNotify"
  | Ev.Expose -> failwith "Unsupported type Expose"
  | Ev.GraphicsExpose -> failwith "Unsupported type GraphicsExpose"
  | Ev.NoExpose -> failwith "Unsupported type NoExpose"
  | Ev.VisibilityNotify -> failwith "Unsupported type VisibilityNotify"
  | Ev.CreateNotify -> failwith "Unsupported type CreateNotify"
  | Ev.DestroyNotify -> failwith "Unsupported type DestroyNotify"
  | Ev.UnmapNotify -> failwith "Unsupported type UnmapNotify"
  | Ev.MapNotify -> failwith "Unsupported type MapNotify"
  | Ev.MapRequest -> failwith "Unsupported type MapRequest"
  | Ev.ReparentNotify -> failwith "Unsupported type ReparentNotify"
  | Ev.ConfigureNotify -> failwith "Unsupported type ConfigureNotify"
  | Ev.ConfigureRequest -> failwith "Unsupported type ConfigureRequest"
  | Ev.GravityNotify -> failwith "Unsupported type GravityNotify"
  | Ev.ResizeRequest -> failwith "Unsupported type ResizeRequest"
  | Ev.CirculateNotify -> failwith "Unsupported type CirculateNotify"
  | Ev.CirculateRequest -> failwith "Unsupported type CirculateRequest"
  | Ev.PropertyNotify -> failwith "Unsupported type PropertyNotify"
  | Ev.SelectionClear -> failwith "Unsupported type SelectionClear"
  | Ev.SelectionRequest -> failwith "Unsupported type SelectionRequest"
  | Ev.SelectionNotify -> failwith "Unsupported type SelectionNotify"
  | Ev.ColormapNotify -> failwith "Unsupported type ColormapNotify"
  | Ev.MappingNotify -> failwith "Unsupported type MappingNotify"
  | Ev.GenericEvent -> failwith "Unsupported type GenericEvent"
  | Ev.Unknown n -> failwith (Printf.sprintf "Unknown event type '%Ld'" n)

let c_of_xevent (_ : xEvent) : xevent_union union = failwith "Not implemented"

let xevent_typ : xEvent typ =
  view ~read:xevent_of_c ~write:c_of_xevent xevent_union
