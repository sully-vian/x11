open X11
open Helpers

(* Number of windows whose name is exactly [name] *)
let windows_named name =
  let ic =
    Unix.open_process_in
      (Printf.sprintf "xdotool search --name %s"
         (Filename.quote ("^" ^ name ^ "$")))
  in
  let ids = In_channel.input_all ic in
  ignore (Unix.close_process_in ic);
  String.split_on_char '\n' ids |> List.filter (( <> ) "") |> List.length

let test_store_name () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let win = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      store_name dpy win "x11 store_name test";
      flush dpy;
      Alcotest.(check int)
        "windows with that name" 1
        (windows_named "x11 store_name test");
      close_display dpy

(* The name is stored as given: searching for a longer one finds nothing *)
let test_store_name_other () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let root = default_root_window dpy in
      let win = create_simple_window dpy root (0, 0) (100, 100) 0 0 0 in
      store_name dpy win "x11 store_name test";
      flush dpy;
      Alcotest.(check int)
        "windows with another name" 0
        (windows_named "x11 store_name test 2");
      close_display dpy

let suite =
  ( "store_name",
    [
      Alcotest.test_case "store_name" `Quick (with_xvfb test_store_name);
      Alcotest.test_case "store_name (other name)" `Quick
        (with_xvfb test_store_name_other);
    ] )
