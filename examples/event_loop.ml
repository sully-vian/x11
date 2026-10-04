open X11

let change_color dpy win =
  set_window_background dpy win (Random.bits ());
  clear_window dpy win;
  flush dpy

let rec loop dpy win =
  let ev = next_event dpy in
  (match ev with
  | EnterNotify _ | LeaveNotify _ | KeyPress _ | ButtonPress _ ->
      change_color dpy win
  | _ -> print_endline "Unknown event");
  loop dpy win

let () =
  match open_display None with
  | Some dpy ->
      let root = default_root_window dpy in
      let win =
        create_simple_window dpy root (10, 10) (400, 300) 1 0 (Random.bits ())
      in
      let mask =
        keyPressMask ||| buttonPressMask ||| enterWindowMask ||| leaveWindowMask
      in
      select_input dpy win mask;
      map_window dpy win;
      flush dpy;
      print_endline "looping...";
      loop dpy win
  | None -> failwith "Could not open display"
