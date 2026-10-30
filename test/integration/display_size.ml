open X11
open Helpers

(* Two sizes, so that a constant or swapped result can't pass *)
let test_size (width, height) () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let screen = default_screen dpy in
      Alcotest.(check int) "width" width (display_width dpy screen);
      Alcotest.(check int) "height" height (display_height dpy screen);
      close_display dpy

let case (width, height) =
  let size = Printf.sprintf "%dx%d" width height in
  Alcotest.test_case size `Quick
    (with_xvfb
       ~args:[ "-screen"; "0"; size ^ "x24" ]
       (test_size (width, height)))

let suite = ("display size", [ case (1024, 768); case (640, 480) ])
