open X11

let test_eventMask_or () =
  let _ : eventMask =
    button3MotionMask ||| button4MotionMask ||| focusChangeMask ||| noEventMask
  in
  ()

(* Every kind of event flag fits a SETofEVENT *)
let test_eventMask_all_tags () =
  let _ : eventMask =
    keyPressMask ||| buttonPressMask ||| enterWindowMask ||| exposureMask
  in
  ()

let test_pointerEventMask_or () =
  let _ : pointerEventMask =
    buttonPressMask ||| enterWindowMask ||| pointerMotionHintMask
    ||| noEventMask
  in
  ()

let test_deviceEventMask_or () =
  let _ : deviceEventMask =
    keyPressMask ||| buttonReleaseMask ||| pointerMotionMask ||| noEventMask
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
          test_case "eventMask all tags" `Quick test_eventMask_all_tags;
          test_case "pointerEventMask OR" `Quick test_pointerEventMask_or;
          test_case "deviceEventMask OR" `Quick test_deviceEventMask_or;
          test_case "keyMask OR" `Quick test_keyMask_or;
          test_case "stateMask OR" `Quick test_stateMask_or;
        ] );
    ]
