open X11
open Helpers

(* The WM_PROTOCOLS line xprop prints for the window named [name] *)
let wm_protocols name =
  let ic =
    Unix.open_process_in
      (Printf.sprintf "xprop -name %s WM_PROTOCOLS" (Filename.quote name))
  in
  let line = In_channel.input_all ic |> String.trim in
  ignore (Unix.close_process_in ic);
  line

let with_protocols names () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let win = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      store_name dpy win "x11 set_wm_protocols test";
      let atoms =
        List.map (fun name -> Option.get (intern_atom dpy name false)) names
      in
      set_wm_protocols dpy win atoms;
      flush dpy;
      let line = wm_protocols "x11 set_wm_protocols test" in
      close_display dpy;
      line

let test_delete_window () =
  Alcotest.(check string)
    "WM_PROTOCOLS" "WM_PROTOCOLS(ATOM): protocols  WM_DELETE_WINDOW"
    (with_protocols [ "WM_DELETE_WINDOW" ] ())

let test_two_protocols () =
  Alcotest.(check string)
    "WM_PROTOCOLS"
    "WM_PROTOCOLS(ATOM): protocols  WM_TAKE_FOCUS, WM_DELETE_WINDOW"
    (with_protocols [ "WM_TAKE_FOCUS"; "WM_DELETE_WINDOW" ] ())

let suite =
  ( "set_wm_protocols",
    [
      Alcotest.test_case "WM_DELETE_WINDOW" `Quick
        (with_xvfb test_delete_window);
      Alcotest.test_case "two protocols" `Quick (with_xvfb test_two_protocols);
    ] )
