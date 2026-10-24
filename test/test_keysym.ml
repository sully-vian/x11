open X11

let test_letters () =
  Alcotest.(check bool) "a" true (string_to_keysym "a" = Some xk_a);
  Alcotest.(check bool) "A" true (string_to_keysym "A" = Some xk_A)

(* Symbols are looked up by their keysym name, not by the character *)
let test_symbol_names () =
  Alcotest.(check bool) "space" true (string_to_keysym "space" = Some xk_space);
  Alcotest.(check bool)
    "braceleft" true
    (string_to_keysym "braceleft" = Some xk_braceleft)

let test_unknown_name () =
  Alcotest.(check bool) "unknown" true (string_to_keysym "NotAKeysym" = None);
  Alcotest.(check bool) "character" true (string_to_keysym " " = None)

let () =
  let open Alcotest in
  run "X11 Keysym"
    [
      ( "string_to_keysym",
        [
          test_case "letters" `Quick test_letters;
          test_case "symbol names" `Quick test_symbol_names;
          test_case "unknown name" `Quick test_unknown_name;
        ] );
    ]
