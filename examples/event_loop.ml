open X11

let rec loop dpy =
  let ev = next_event dpy in
  (match ev with
  | KeyPress _ -> print_endline "KeyPress"
  | _ -> print_endline "Unknown event");
  loop dpy

let () =
  match open_display None with
  | Some dpy ->
      let repr = Obj.repr dpy in
      Printf.printf "Wrapped in a block: Tag %d, Size %d\n%!" (Obj.tag repr)
        (Obj.size repr);
      dpy |> Obj.magic |> Ctypes.raw_address_of_ptr |> Nativeint.to_string
      |> Printf.printf "Address: %s\n%!";
      (*print_endline "closing display";
      close_display_2 dpy;
      print_endline "Display closed";*)
      let root = default_root_window dpy in
      select_input dpy root keyPressMask;
      flush dpy;
      loop dpy
  | None -> failwith "Could not open display"
