open X11

let test_eventMask_or () =
  let _ : eventMask =
    button3MotionMask ||| button4MotionMask ||| focusChangeMask ||| noEventMask
  in
  ()

let test_keyMask_or () =
  let _ : keyMask = shiftMask ||| lockMask ||| controlMask in
  ()

let () =
  let open Alcotest in
  run "X11 compilation"
    [
      ( "masks",
        [
          test_case "eventMask OR" `Quick test_eventMask_or;
          test_case "keyMask OR" `Quick test_keyMask_or;
        ] );
    ]
