open X11
open Helpers

(* Each test sets its own handler: with Xlib's default one, these errors would
   exit the test program. The codes are BadWindow (3) and the request's
   opcode: X_GetWindowAttributes (3), X_DestroyWindow (4) *)

(* A handler that records the codes of each error, and the errors so far *)
let recorder () =
  let errors = ref [] in
  ((fun _ (ev : errorEvent) -> errors := ev.codes :: !errors), errors)

(* A window that doesn't exist anymore *)
let destroyed_window dpy =
  let win =
    create_simple_window dpy (default_root_window dpy) (0, 0) (100, 100) 0 0 0
  in
  destroy_window dpy win;
  win

(* The error comes with the reply XGetWindowAttributes waits for: the handler
   gets it during the call, which then returns *)
let test_reported () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let handler, errors = recorder () in
      set_error_handler handler;
      let win = destroyed_window dpy in
      Alcotest.(check bool)
        "no attributes" true
        (Option.is_none (get_window_attributes dpy win));
      Alcotest.(check (list (triple int int int))) "codes" [ (3, 3, 0) ] !errors;
      close_display dpy

(* XDestroyWindow has no reply: its error arrives during the next call that
   waits for one, even if that call succeeds *)
let test_later_call () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let handler, errors = recorder () in
      set_error_handler handler;
      let win = destroyed_window dpy in
      destroy_window dpy win;
      Alcotest.(check (list (triple int int int))) "not yet" [] !errors;
      Alcotest.(check bool)
        "root attributes" true
        (Option.is_some (get_window_attributes dpy (default_root_window dpy)));
      Alcotest.(check (list (triple int int int))) "codes" [ (3, 4, 0) ] !errors;
      close_display dpy

(* Only the last handler set gets the error *)
let test_replaced () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let first, first_errors = recorder () in
      let second, second_errors = recorder () in
      set_error_handler first;
      set_error_handler second;
      ignore (get_window_attributes dpy (destroyed_window dpy));
      Alcotest.(check int) "first" 0 (List.length !first_errors);
      Alcotest.(check int) "second" 1 (List.length !second_errors);
      close_display dpy

let suite =
  ( "set_error_handler",
    [
      Alcotest.test_case "reported" `Quick (with_xvfb test_reported);
      Alcotest.test_case "during a later call" `Quick
        (with_xvfb test_later_call);
      Alcotest.test_case "replaced" `Quick (with_xvfb test_replaced);
    ] )
