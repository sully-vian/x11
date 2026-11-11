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

let test_keeps_modifiers () =
  let state : stateMask = mod4Mask ||| shiftMask ||| lockMask ||| button1Mask in
  let kept = state &. (mod4Mask ||| shiftMask) in
  Alcotest.(check bool) "mod4 kept" true (kept &&& mod4Mask);
  Alcotest.(check bool) "lock dropped" false (kept &&& lockMask);
  Alcotest.(check bool) "equal" true (kept = (mod4Mask ||| shiftMask))

(* sowm's mod_clean, on a binding and on a state holding a button *)
let test_mod_clean () =
  let usable =
    shiftMask ||| controlMask ||| mod1Mask ||| mod2Mask ||| mod3Mask
    ||| mod4Mask ||| mod5Mask
  in
  let mod_clean m = m &. usable &~ (mod2Mask ||| lockMask) in
  let binding : bindingMask = mod4Mask ||| shiftMask in
  let state : stateMask =
    mod4Mask ||| shiftMask ||| lockMask ||| mod2Mask ||| button1Mask
  in
  Alcotest.(check bool) "equal" true (mod_clean state = mod_clean binding)

let test_no_modifier () =
  Alcotest.(check bool) "or" true (noModifier ||| lockMask = lockMask);
  Alcotest.(check bool) "holds nothing" false (noModifier &&& lockMask)

(* AnyModifier's bit isn't a modifier, so a state never keeps it *)
let test_any_modifier_filter () =
  let state : stateMask = mod4Mask ||| shiftMask in
  Alcotest.(check bool) "empty" true (state &. anyModifier = noModifier)

let () =
  Alcotest.run "X11 masks"
    [
      ( "&~",
        [
          Alcotest.test_case "removes the flags" `Quick test_removes_flags;
          Alcotest.test_case "absent flag" `Quick test_absent_flag;
          Alcotest.test_case "CapsLock and NumLock" `Quick test_clean;
        ] );
      ( "&.",
        [
          Alcotest.test_case "keeps the modifiers" `Quick test_keeps_modifiers;
          Alcotest.test_case "mod_clean" `Quick test_mod_clean;
          Alcotest.test_case "anyModifier" `Quick test_any_modifier_filter;
        ] );
      ("noModifier", [ Alcotest.test_case "empty" `Quick test_no_modifier ]);
      ( "&&&",
        [
          Alcotest.test_case "has the flag" `Quick test_has_flag;
          Alcotest.test_case "lacks the flag" `Quick test_lacks_flag;
          Alcotest.test_case "any of the flags" `Quick test_any_flag;
        ] );
    ]
