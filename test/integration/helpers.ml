(* Runs [f] against its own Xvfb, with DISPLAY set to it. Xvfb picks a free
   display and, with -displayfd 1, writes its number to our pipe once it
   accepts connections: no fixed wait, no clash with a running server. [args]
   are passed to Xvfb, e.g. ["-screen"; "0"; "640x480x24"]. *)
let with_xvfb ?(args = []) f () =
  let ready_out, ready_in = Unix.pipe ~cloexec:true () in
  let pid =
    Unix.create_process "Xvfb"
      (Array.of_list ([ "Xvfb"; "-displayfd"; "1" ] @ args))
      Unix.stdin ready_in Unix.stderr
  in
  (* Only Xvfb holds the write end now, so the read fails if it exits *)
  Unix.close ready_in;
  let ready = Unix.in_channel_of_descr ready_out in
  let cleanup () =
    close_in_noerr ready;
    (try Unix.kill pid Sys.sigterm with _ -> ());
    ignore (try Unix.waitpid [] pid with _ -> (pid, Unix.WEXITED 0))
  in
  Fun.protect ~finally:cleanup (fun () ->
      let display =
        try input_line ready
        with End_of_file -> Alcotest.fail "Xvfb exited before it was ready"
      in
      Unix.putenv "DISPLAY" (":" ^ display);
      f ())

(* The names among [names] of the root's children, topmost first. xwininfo
   prints each child as [0x200001 "name": ...] *)
let stacking_order names =
  let ic = Unix.open_process_in "xwininfo -root -children" in
  let lines = In_channel.input_all ic |> String.split_on_char '\n' in
  ignore (Unix.close_process_in ic);
  List.filter_map
    (fun line ->
      match String.split_on_char '"' line with
      | _ :: name :: _ when List.mem name names -> Some name
      | _ -> None)
    lines

(* The keycode xdotool's key press reports for [key]. KeyPress must be selected
   on the root *)
let pressed_keycode dpy key =
  let open X11 in
  ignore (Sys.command ("xdotool key " ^ key));
  let rec next () =
    match next_event dpy with KeyPress k -> k.keycode | _ -> next ()
  in
  next ()
