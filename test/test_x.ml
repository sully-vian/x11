open X11.X
open X11.Xevent

let test_open_display_ok () =
  match open_display None with
  | None -> Alcotest.fail "Expected Some"
  | Some display -> close_display display

let test_open_display_fail () =
  match open_display (Some ":999") with
  | None -> ()
  | Some display -> Alcotest.fail "Expected None"

let suite =
  let open Alcotest in
  [
    test_case "open_display (ok)" `Quick test_open_display_ok;
    test_case "open_display (fail)" `Quick test_open_display_fail;
  ]
