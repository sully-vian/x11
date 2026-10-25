(* https://github.com/mackstann/tinywm *)

(* To try it on a server with no other window manager, run this from the
   project root on a free tty. Exiting the terminal (st) ends the session:

   xinit /bin/sh -c 'dune exec ./examples/tinywm.exe & exec st' -- :1 vt$XDG_VTNR -keeptty
*)

open X11

let () =
  let dpy = open_display None in
  match dpy with
  | None -> exit 1
  | Some dpy ->
      grab_key dpy
        (keysym_to_keycode dpy (Option.get (string_to_keysym "F1")))
        mod1Mask (default_root_window dpy) true GrabModeAsync GrabModeAsync;
      grab_button dpy button1 mod1Mask (default_root_window dpy) true
        (buttonPressMask ||| buttonReleaseMask ||| pointerMotionMask)
        GrabModeAsync GrabModeAsync None None;
      grab_button dpy button3 mod1Mask (default_root_window dpy) true
        (buttonPressMask ||| buttonReleaseMask ||| pointerMotionMask)
        GrabModeAsync GrabModeAsync None None;
      let rec loop dpy (drag : (buttonEvent * windowAttributes) option) =
        match (next_event dpy, drag) with
        | KeyPress { subwindow = Some subwindow; _ }, _ ->
            raise_window dpy subwindow;
            loop dpy drag
        | ButtonPress ({ subwindow = Some subwindow; _ } as ev), _ -> (
            match get_window_attributes dpy subwindow with
            | Some attr -> loop dpy (Some (ev, attr))
            | None -> loop dpy drag)
        | ( MotionNotify ev,
            Some (({ subwindow = Some subwindow; _ } as start), attr) ) ->
            let xdiff = fst ev.pos_root - fst start.pos_root in
            let ydiff = snd ev.pos_root - snd start.pos_root in
            move_resize_window dpy subwindow
              ( (fst attr.pos + if start.button = button1 then xdiff else 0),
                snd attr.pos + if start.button = button1 then ydiff else 0 )
              ( max 1
                  (fst attr.size + if start.button = button3 then xdiff else 0),
                max 1
                  (snd attr.size + if start.button = button3 then ydiff else 0)
              );
            loop dpy drag
        | ButtonRelease _, _ -> loop dpy None
        | _ -> loop dpy drag
      in
      loop dpy None
