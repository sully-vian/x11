open X11

let test_eventMask_or () =
  let _ : eventMask =
    button3MotionMask ||| button4MotionMask ||| focusChangeMask ||| noEventMask
  in
  ()

let test_keyMask_or () =
  let _ : keyMask = shiftMask ||| lockMask ||| controlMask in
  ()

let suite =
  let open Alcotest in
  [
    test_case "eventMask OR" `Quick test_eventMask_or;
    test_case "keyMask OR" `Quick test_keyMask_or;
  ]
