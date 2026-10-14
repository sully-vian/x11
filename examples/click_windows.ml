open X11

(* Each click in one of our windows opens a new one where the click happened.
   The window manager may place it elsewhere. *)

let new_window dpy root pos n =
  let win = create_simple_window dpy root pos (200, 150) 1 0 (Random.bits ()) in
  store_name dpy win (Printf.sprintf "click window %d" n);
  select_input dpy win buttonPressMask;
  map_window dpy win;
  flush dpy

let rec loop dpy root count =
  match next_event dpy with
  | ButtonPress ev ->
      new_window dpy root ev.pos_root (count + 1);
      Printf.printf "%d windows\n%!" (count + 1);
      loop dpy root (count + 1)
  | _ -> loop dpy root count

let () =
  Random.self_init ();
  match open_display None with
  | Some dpy ->
      let root = default_root_window dpy in
      new_window dpy root (10, 10) 1;
      print_endline "Click in a window to open another one";
      loop dpy root 1
  | None -> failwith "Could not open display"
