open X11

let test_example () = Alcotest.(check int) "example" 1 1

let suite =
  let open Alcotest in
  [ test_case "example" `Quick test_example ]
