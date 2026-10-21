open X11

(******************************************************************************)
(*                                                                            *)
(* Each click in one of our windows opens a new one where the click happened. *)
(* The window manager may place it elsewhere. Closing a window only destroys  *)
(* that one, and the program ends with the last one.                          *)
(*                                                                            *)
(******************************************************************************)

type atoms = { wm_protocols : atom; wm_delete_window : atom }
(** The atoms of the close protocol, interned once at startup *)

(** The atom named [name], created if no client has interned it yet *)
let intern dpy name = Option.get (intern_atom dpy name false)

(** Opens window number [n] at [pos], named and with a random background, and
    listens for clicks in it *)
let new_window dpy atoms root pos n =
  let win = create_simple_window dpy root pos (200, 150) 1 0 (Random.bits ()) in
  store_name dpy win (Printf.sprintf "click window %d" n);
  (* The window manager then asks us to close the window instead of killing
     the whole connection *)
  set_wm_protocols dpy win [ atoms.wm_delete_window ];
  select_input dpy win buttonPressMask;
  map_window dpy win;
  flush dpy

(** Handles events until the last window is closed: a click opens a window, a
    close request destroys the window it's for. [created] counts every window so
    far, [opened] the ones still there *)
let rec loop dpy atoms root created opened =
  match next_event dpy with
  | ButtonPress ev ->
      new_window dpy atoms root ev.pos_root (created + 1);
      Printf.printf "%d window(s)\n%!" (opened + 1);
      loop dpy atoms root (created + 1) (opened + 1)
  | ClientMessage { message_type; window; data = Longs l; _ } ->
      if
        message_type = atoms.wm_protocols
        && atom_of_long l.(0) = atoms.wm_delete_window
      then (
        destroy_window dpy window;
        flush dpy;
        Printf.printf "%d window(s)\n%!" (opened - 1);
        if opened > 1 then loop dpy atoms root created (opened - 1))
      else loop dpy atoms root created opened
  | _ -> loop dpy atoms root created opened

let () =
  Random.self_init ();
  match open_display None with
  | Some dpy ->
      let atoms =
        {
          wm_protocols = intern dpy "WM_PROTOCOLS";
          wm_delete_window = intern dpy "WM_DELETE_WINDOW";
        }
      in
      let root = default_root_window dpy in
      new_window dpy atoms root (10, 10) 1;
      print_endline "Click in a window to open another one";
      loop dpy atoms root 1 1;
      close_display dpy
  | None -> failwith "Could not open display"
