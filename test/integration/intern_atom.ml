open X11
open Helpers

(* A name unlikely to be interned by anything else on a fresh Xvfb *)
let name = "X11_OCAML_INTERN_ATOM_TEST"

let test_same_atom () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      let first = intern_atom dpy name false in
      Alcotest.(check bool) "created" true (Option.is_some first);
      Alcotest.(check bool) "same atom" true (first = intern_atom dpy name false);
      close_display dpy

let test_only_if_exists () =
  match open_display None with
  | None -> Alcotest.fail "Could not open display. Is Xvfb running?"
  | Some dpy ->
      Alcotest.(check bool)
        "missing" true
        (Option.is_none (intern_atom dpy name true));
      let created = intern_atom dpy name false in
      Alcotest.(check bool)
        "found once created" true
        (created = intern_atom dpy name true);
      close_display dpy

let suite =
  ( "intern_atom",
    [
      Alcotest.test_case "same name, same atom" `Quick
        (with_xvfb test_same_atom);
      Alcotest.test_case "only_if_exists" `Quick (with_xvfb test_only_if_exists);
    ] )
