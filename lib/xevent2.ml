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

let xevent_of_c (raw_ev : xevent_union union) =
  match getf (getf raw_ev xev_any) xany_type with
  | Ev.KeyPress -> KeyPress (key_of_c (getf raw_ev xev_key))
  | Ev.KeyRelease -> KeyRelease (key_of_c (getf raw_ev xev_key))
  | Ev.ButtonPress -> ButtonPress (button_of_c (getf raw_ev xev_button))
  | Ev.ButtonRelease -> ButtonRelease (button_of_c (getf raw_ev xev_button))
  | Ev.ClientMessage ->
      ClientMessage (client_message_of_c (getf raw_ev xev_client))
  | Ev.Unknown n -> failwith (Printf.sprintf "Unknown event type '%Ld'" n)
  (* TODO: remove once every event type is handled, to get exhaustiveness
     checking back *)
  | _ -> failwith "Unsupported event type"

let c_of_xevent (_ : xEvent) : xevent_union union = failwith "Not implemented"

let xevent_typ : xEvent typ =
  view ~read:xevent_of_c ~write:c_of_xevent xevent_union
