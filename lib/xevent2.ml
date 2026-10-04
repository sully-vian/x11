open Xevent
open Ctypes
open C.Types

let xevent_of_c (raw_ev : xevent_union union) =
  let any = getf raw_ev xev_any in
  let ev_type = getf any xany_type in
  match ev_type with
  | 2 ->
      (* KeyPress *)
      let ev = getf raw_ev xev_key in
      KeyPress
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
  | 4 ->
      (* ButtonPress *)
      let ev = getf raw_ev xev_button in
      ButtonPress
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
  | 33 (* ClientMessage *) ->
      let ev = getf raw_ev xev_client in
      let format = getf ev xc_format in
      let data =
        match format with
        | 8 ->
            let arr = getf ev xc_data_b in
            let bytes = Array.init 20 (fun i -> CArray.get arr i) in
            Bytes bytes
        | 16 ->
            let arr = getf ev xc_data_s in
            let shorts = Array.init 10 (fun i -> CArray.get arr i) in
            Shorts shorts
        | 32 ->
            let arr = getf ev xc_data_l in
            let longs = Array.init 5 (fun i -> CArray.get arr i) in
            Longs longs
        | _ ->
            failwith (Printf.sprintf "Invalid ClientMessage format: %d" format)
      in
      ClientMessage
        {
          serial = getf ev xc_serial;
          send_event = 0 <> getf ev xc_send_event;
          display = getf ev xc_display;
          window = getf ev xc_window;
          message_type = getf ev xc_message_type;
          data;
        }
  | _ -> failwith (Printf.sprintf "Unsupported event type '%d'" ev_type)

let c_of_xevent (_ : xEvent) : xevent_union union = failwith "Not implemented"

let xevent_typ : xEvent typ =
  view ~read:xevent_of_c ~write:c_of_xevent xevent_union
