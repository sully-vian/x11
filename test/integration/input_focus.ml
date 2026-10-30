open X11
open Helpers

let focus =
  Alcotest.testable
    (fun ppf -> function
      | FocusNone -> Format.fprintf ppf "FocusNone"
      | FocusPointerRoot -> Format.fprintf ppf "FocusPointerRoot"
      | FocusWindow _ -> Format.fprintf ppf "FocusWindow _")
    ( = )

let revert_to =
  Alcotest.testable
    (fun ppf -> function
      | RevertToNone -> Format.fprintf ppf "RevertToNone"
      | RevertToPointerRoot -> Format.fprintf ppf "RevertToPointerRoot"
      | RevertToParent -> Format.fprintf ppf "RevertToParent")
    ( = )

let with_display f () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      f dpy;
      close_display dpy

(* Focusing an unviewable window is a BadMatch, so the window is mapped first:
   requests of one connection are handled in order, no wait is needed *)
let mapped_window dpy parent =
  let win = create_simple_window dpy parent (0, 0) (100, 100) 0 0 0 in
  map_window dpy win;
  win

(* Each value goes through set_input_focus and comes back unchanged *)
let round_trip focus_of revert dpy =
  let root = default_root_window dpy in
  let expected = focus_of (mapped_window dpy root) in
  set_input_focus dpy expected revert currentTime;
  let actual, actual_revert = get_input_focus dpy in
  Alcotest.check focus "focus" expected actual;
  Alcotest.check revert_to "revert_to" revert actual_revert

(* When the focused window becomes unviewable, the focus goes where revert_to
   says *)
let revert revert expected dpy =
  let root = default_root_window dpy in
  let parent = mapped_window dpy root in
  let child = mapped_window dpy parent in
  set_input_focus dpy (FocusWindow child) revert currentTime;
  unmap_window dpy child;
  let actual, _ = get_input_focus dpy in
  Alcotest.check focus "focus" (expected parent) actual

let suite =
  ( "input_focus",
    [
      Alcotest.test_case "window" `Quick
        (with_xvfb
           (with_display
              (round_trip (fun win -> FocusWindow win) RevertToParent)));
      Alcotest.test_case "PointerRoot" `Quick
        (with_xvfb
           (with_display
              (round_trip (fun _ -> FocusPointerRoot) RevertToPointerRoot)));
      Alcotest.test_case "None" `Quick
        (with_xvfb
           (with_display (round_trip (fun _ -> FocusNone) RevertToNone)));
      Alcotest.test_case "revert to parent" `Quick
        (with_xvfb
           (with_display
              (revert RevertToParent (fun parent -> FocusWindow parent))));
      Alcotest.test_case "revert to PointerRoot" `Quick
        (with_xvfb
           (with_display
              (revert RevertToPointerRoot (fun _ -> FocusPointerRoot))));
      Alcotest.test_case "revert to None" `Quick
        (with_xvfb (with_display (revert RevertToNone (fun _ -> FocusNone))));
    ] )
