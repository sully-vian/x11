open X11

let test_eventMask_or () =
  let _ : eventMask =
    button3MotionMask ||| button4MotionMask ||| focusChangeMask ||| noEventMask
  in
  ()

let test_keyMask_or () =
  let _ : keyMask = shiftMask ||| lockMask ||| controlMask ||| anyModifier in
  ()

let test_stateMask_or () =
  let _ : stateMask = shiftMask ||| controlMask ||| button1Mask in
  ()

let () =
  let open Alcotest in
  run "X11 compilation"
    [
      ( "masks",
        [
          test_case "eventMask OR" `Quick test_eventMask_or;
          test_case "keyMask OR" `Quick test_keyMask_or;
          test_case "stateMask OR" `Quick test_stateMask_or;
        ] );
    ]
