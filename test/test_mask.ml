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

let test_removes_flags () =
  let state : stateMask = shiftMask ||| lockMask ||| button1Mask in
  let without = state &~ (lockMask ||| button1Mask) in
  Alcotest.(check bool) "shift kept" true (without &&& shiftMask);
  Alcotest.(check bool) "lock removed" false (without &&& lockMask);
  Alcotest.(check bool) "button 1 removed" false (without &&& button1Mask)

(* Removing a flag that isn't there changes nothing *)
let test_absent_flag () =
  let state : stateMask = shiftMask ||| button1Mask in
  Alcotest.(check bool) "unchanged" true (state &~ controlMask = state)

(* What sowm's mod_clean does: CapsLock and NumLock don't prevent a match *)
let test_clean () =
  let binding : stateMask = mod4Mask ||| shiftMask in
  let state : stateMask = mod4Mask ||| shiftMask ||| lockMask ||| mod2Mask in
  let clean m = m &~ (lockMask ||| mod2Mask) in
  Alcotest.(check bool) "equal" true (clean state = clean binding)

let () =
  Alcotest.run "X11 masks"
    [
      ( "&~",
        [
          Alcotest.test_case "removes the flags" `Quick test_removes_flags;
          Alcotest.test_case "absent flag" `Quick test_absent_flag;
          Alcotest.test_case "CapsLock and NumLock" `Quick test_clean;
        ] );
      ( "&&&",
        [
          Alcotest.test_case "has the flag" `Quick test_has_flag;
          Alcotest.test_case "lacks the flag" `Quick test_lacks_flag;
          Alcotest.test_case "any of the flags" `Quick test_any_flag;
        ] );
    ]
