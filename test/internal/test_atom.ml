open X11_internal

let check_atom expected l =
  Alcotest.(check bool)
    (Printf.sprintf "atom %d" expected)
    true
    (X.atom_of_long (Signed.Long.of_int l) = Unsigned.ULong.of_int expected)

(* WM_NAME, one of the atoms predefined in Xatom.h *)
let test_predefined () = check_atom 39 39

(* The largest XID: its top three bits are zero *)
let test_largest_xid () = check_atom 0x1FFFFFFF 0x1FFFFFFF

let () =
  Alcotest.run "X11 atom_of_long"
    [
      ( "atom_of_long",
        [
          Alcotest.test_case "predefined atom" `Quick test_predefined;
          Alcotest.test_case "largest XID" `Quick test_largest_xid;
        ] );
    ]
