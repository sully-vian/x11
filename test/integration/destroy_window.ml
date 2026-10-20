open X11
open Helpers

(* The window of the next DestroyNotify, skipping other events *)
let rec next_destroyed dpy =
  match next_event dpy with
  | DestroyWindow ev -> ev.window
  | _ -> next_destroyed dpy

let test_destroy_window () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let win = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      select_input dpy root substructureNotifyMask;
      destroy_window dpy win;
      Alcotest.(check bool) "destroyed" true (next_destroyed dpy = win);
      close_display dpy

(* Subwindows are destroyed first, while the parent still reports them *)
let test_destroy_subwindow () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let parent = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      let child = create_simple_window dpy parent (0, 0) (50, 50) 0 0 0 in
      select_input dpy parent substructureNotifyMask;
      destroy_window dpy parent;
      Alcotest.(check bool) "child destroyed" true (next_destroyed dpy = child);
      close_display dpy

let suite =
  ( "destroy_window",
    [
      Alcotest.test_case "DestroyNotify" `Quick (with_xvfb test_destroy_window);
      Alcotest.test_case "subwindow" `Quick (with_xvfb test_destroy_subwindow);
    ] )
