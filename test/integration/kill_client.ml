open X11
open Helpers

(* Each test opens two connections: the victim owns the windows, the killer
   kills it. The victim's display is never used again, nor closed: on a dead
   connection Xlib's default I/O error handler exits the test program *)

let open_display_exn () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy -> dpy

(* XGetWindowAttributes waits for a reply, so the window exists on the server
   before the killer names it: killing an unknown resource is a BadValue *)
let victim_window dpy parent name =
  let win = create_simple_window dpy parent (0, 0) (100, 100) 0 0 0 in
  store_name dpy win name;
  ignore (get_window_attributes dpy win);
  win

(* Waits for a DestroyNotify for each of [wins], in any order *)
let rec wait_destroyed dpy wins =
  if wins <> [] then
    match next_event dpy with
    | DestroyWindow ev ->
        wait_destroyed dpy (List.filter (fun w -> w <> ev.window) wins)
    | _ -> wait_destroyed dpy wins

let test_kill_client () =
  let victim = open_display_exn () in
  let dpy = open_display_exn () in
  let root = default_root_window dpy in
  let win =
    victim_window victim (default_root_window victim) "x11 kill_client"
  in
  select_input dpy root substructureNotifyMask;
  kill_client dpy win;
  wait_destroyed dpy [ win ];
  Alcotest.(check (list string))
    "gone" []
    (stacking_order [ "x11 kill_client" ]);
  close_display dpy

(* Any resource names the client, and all its resources go: a subwindow takes
   down its parent and the client's other top-level windows *)
let test_kill_by_subwindow () =
  let victim = open_display_exn () in
  let dpy = open_display_exn () in
  let root = default_root_window dpy in
  let victim_root = default_root_window victim in
  let a = victim_window victim victim_root "x11 kill_client a" in
  let b = victim_window victim victim_root "x11 kill_client b" in
  let child = victim_window victim a "x11 kill_client child" in
  select_input dpy root substructureNotifyMask;
  kill_client dpy child;
  wait_destroyed dpy [ a; b ];
  Alcotest.(check (list string))
    "gone" []
    (stacking_order [ "x11 kill_client a"; "x11 kill_client b" ]);
  close_display dpy

(* Only the client owning the resource is killed: the killer's own window
   stays, and its connection still works *)
let test_only_that_client () =
  let victim = open_display_exn () in
  let dpy = open_display_exn () in
  let root = default_root_window dpy in
  let win =
    victim_window victim (default_root_window victim) "x11 kill_client victim"
  in
  let own = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
  store_name dpy own "x11 kill_client killer";
  select_input dpy root substructureNotifyMask;
  kill_client dpy win;
  wait_destroyed dpy [ win ];
  Alcotest.(check (list string))
    "killer's window kept"
    [ "x11 kill_client killer" ]
    (stacking_order [ "x11 kill_client victim"; "x11 kill_client killer" ]);
  map_window dpy own;
  let attr = Option.get (get_window_attributes dpy own) in
  Alcotest.(check bool) "connection alive" true (attr.map_state = IsViewable);
  close_display dpy

let suite =
  ( "kill_client",
    [
      Alcotest.test_case "DestroyNotify" `Quick (with_xvfb test_kill_client);
      Alcotest.test_case "by subwindow" `Quick
        (with_xvfb test_kill_by_subwindow);
      Alcotest.test_case "only that client" `Quick
        (with_xvfb test_only_that_client);
    ] )
