open X11
open Helpers

(* Xlib's default error handler exits on a BadValue. A round trip makes the
   server answer the requests before it, so getting here means it accepted them *)
let round_trip dpy =
  ignore (get_window_attributes dpy (default_root_window dpy))

let keycode dpy = Option.get (keysym_to_keycode dpy xk_a)

let grab dpy m =
  grab_key dpy (keycode dpy) m (default_root_window dpy) true GrabModeAsync
    GrabModeAsync

let with_display f =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      f dpy;
      close_display dpy

let test_binding_variants () =
  with_display (fun dpy ->
      let binding : bindingMask = mod4Mask ||| shiftMask in
      List.iter
        (fun locks -> grab dpy (binding ||| locks))
        [ noModifier; lockMask; mod2Mask; lockMask ||| mod2Mask ];
      round_trip dpy)

let test_any_modifier () =
  with_display (fun dpy ->
      grab dpy anyModifier;
      flush dpy;
      ignore (Sys.command "xdotool key shift+a");
      let rec pressed () =
        match next_event dpy with KeyPress k -> k.keycode | _ -> pressed ()
      in
      Alcotest.(check bool) "grabbed" true (pressed () = keycode dpy))

let test_table_with_any_modifier () =
  with_display (fun dpy ->
      let table : _ keyMask list = [ anyModifier; mod4Mask ||| lockMask ] in
      List.iter (grab dpy) table;
      round_trip dpy)

let test_pointer_mask_extended () =
  with_display (fun dpy ->
      let root = default_root_window dpy in
      let click : _ pointerEventMask = buttonPressMask ||| buttonReleaseMask in
      grab_button dpy button1 anyModifier root true click GrabModeAsync
        GrabModeAsync None None;
      select_input dpy root (enterWindowMask ||| exposureMask);
      round_trip dpy;
      let attr = Option.get (get_window_attributes dpy root) in
      select_input dpy root (attr.your_event_mask ||| propertyChangeMask);
      round_trip dpy;
      let attr = Option.get (get_window_attributes dpy root) in
      Alcotest.(check bool)
        "extended" true
        (attr.your_event_mask &&& propertyChangeMask
        && attr.your_event_mask &&& exposureMask))

let suite =
  ( "mask grabs",
    [
      Alcotest.test_case "binding with its lock variants" `Quick
        (with_xvfb test_binding_variants);
      Alcotest.test_case "anyModifier" `Quick (with_xvfb test_any_modifier);
      Alcotest.test_case "table holding anyModifier" `Quick
        (with_xvfb test_table_with_any_modifier);
      Alcotest.test_case "extended pointer mask" `Quick
        (with_xvfb test_pointer_mask_extended);
    ] )
