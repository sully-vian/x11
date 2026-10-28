open X11
open Helpers

let map_state dpy win = (Option.get (get_window_attributes dpy win)).map_state

let check_state name expected dpy win =
  Alcotest.(check bool) name true (map_state dpy win = expected)

let test_map_window () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let win = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      check_state "before" IsUnmapped dpy win;
      map_window dpy win;
      check_state "after" IsViewable dpy win;
      close_display dpy

(* Only the window itself is mapped: a child of an unmapped parent is mapped but
   can't be seen until its parent is *)
let test_map_window_child () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let parent = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      let child = create_simple_window dpy parent (0, 0) (10, 10) 0 0 0 in
      map_window dpy child;
      check_state "child, parent unmapped" IsUnviewable dpy child;
      check_state "parent" IsUnmapped dpy parent;
      map_window dpy parent;
      check_state "child, parent mapped" IsViewable dpy child;
      close_display dpy

let test_unmap_window () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let win = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      map_window dpy win;
      unmap_window dpy win;
      check_state "unmapped" IsUnmapped dpy win;
      close_display dpy

(* All the children are mapped, but not the parent itself *)
let test_map_subwindows () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let parent = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      let a = create_simple_window dpy parent (0, 0) (10, 10) 0 0 0 in
      let b = create_simple_window dpy parent (20, 20) (10, 10) 0 0 0 in
      map_subwindows dpy parent;
      check_state "parent" IsUnmapped dpy parent;
      check_state "first child" IsUnviewable dpy a;
      check_state "second child" IsUnviewable dpy b;
      map_window dpy parent;
      check_state "first child, parent mapped" IsViewable dpy a;
      check_state "second child, parent mapped" IsViewable dpy b;
      close_display dpy

(* All the children are unmapped, but not the parent itself *)
let test_unmap_subwindows () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let parent = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      let a = create_simple_window dpy parent (0, 0) (10, 10) 0 0 0 in
      let b = create_simple_window dpy parent (20, 20) (10, 10) 0 0 0 in
      map_window dpy parent;
      map_subwindows dpy parent;
      unmap_subwindows dpy parent;
      check_state "parent" IsViewable dpy parent;
      check_state "first child" IsUnmapped dpy a;
      check_state "second child" IsUnmapped dpy b;
      close_display dpy

(* [a] is created first, so it starts below [b]: map_raised puts it on top,
   where map_window leaves it in place *)
let with_two_windows map () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let a = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      let b = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      store_name dpy a "x11 window_mapping a";
      store_name dpy b "x11 window_mapping b";
      map_window dpy b;
      map dpy a;
      flush dpy;
      check_state "mapped" IsViewable dpy a;
      let order =
        stacking_order [ "x11 window_mapping a"; "x11 window_mapping b" ]
      in
      close_display dpy;
      order

let test_map_raised () =
  Alcotest.(check (list string))
    "a on top"
    [ "x11 window_mapping a"; "x11 window_mapping b" ]
    (with_two_windows map_raised ())

let test_map_window_stays () =
  Alcotest.(check (list string))
    "a still below"
    [ "x11 window_mapping b"; "x11 window_mapping a" ]
    (with_two_windows map_window ())

let suite =
  ( "window mapping",
    [
      Alcotest.test_case "map_window" `Quick (with_xvfb test_map_window);
      Alcotest.test_case "map_window (child)" `Quick
        (with_xvfb test_map_window_child);
      Alcotest.test_case "unmap_window" `Quick (with_xvfb test_unmap_window);
      Alcotest.test_case "map_subwindows" `Quick (with_xvfb test_map_subwindows);
      Alcotest.test_case "unmap_subwindows" `Quick
        (with_xvfb test_unmap_subwindows);
      Alcotest.test_case "map_raised" `Quick (with_xvfb test_map_raised);
      Alcotest.test_case "map_window keeps the stacking" `Quick
        (with_xvfb test_map_window_stays);
    ] )
