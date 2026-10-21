open X11

let test_has_flag () =
  let state : stateMask = controlMask ||| button1Mask in
  Alcotest.(check bool) "control" true (state &&& controlMask);
  Alcotest.(check bool) "button 1" true (state &&& button1Mask)

let test_lacks_flag () =
  let state : stateMask = controlMask ||| button1Mask in
  Alcotest.(check bool) "shift" false (state &&& shiftMask);
  Alcotest.(check bool) "button 2" false (state &&& button2Mask)

(* Like C's [&], one shared flag is enough *)
let test_any_flag () =
  let state : stateMask = shiftMask in
  Alcotest.(check bool)
    "shift or control" true
    (state &&& (shiftMask ||| controlMask))

let () =
  Alcotest.run "X11 masks"
    [
      ( "&&&",
        [
          Alcotest.test_case "has the flag" `Quick test_has_flag;
          Alcotest.test_case "lacks the flag" `Quick test_lacks_flag;
          Alcotest.test_case "any of the flags" `Quick test_any_flag;
        ] );
    ]
