open X11

let bg_normal = 0x000000
let bg_hover = 0x555555

let rec loop dpy win =
  let ev = next_event dpy in
  (match ev with
  | KeyPress _ -> Printf.printf "KeyPress\n%!"
  | ButtonPress _ -> Printf.printf "ButtonPress\n%!"
  | EnterNotify _ ->
      set_window_background dpy win bg_hover;
      clear_window dpy win;
      flush dpy
  | LeaveNotify _ ->
      set_window_background dpy win bg_normal;
      clear_window dpy win;
      flush dpy
  | _ -> print_endline "Unknown event");
  loop dpy win

let () =
  match open_display None with
  | Some dpy ->
      let root = default_root_window dpy in
      let win = create_simple_window dpy root (10, 10) (400, 300) 1 0 0 in
      let mask =
        keyPressMask ||| buttonPressMask ||| enterWindowMask ||| leaveWindowMask
      in
      select_input dpy win mask;
      map_window dpy win;
      flush dpy;
      print_endline "looping...";
      loop dpy win
  | None -> failwith "Could not open display"
