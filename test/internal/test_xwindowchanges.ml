open X11_internal
open Ctypes
open C.Types
open Type_description.Enums
open Xwindowchanges

(* The CW flags as the protocol defines them, to catch a constant bound to the
   wrong name *)
let test_flags () =
  Alcotest.(check (list int))
    "CW flags"
    [ 0x0001; 0x0002; 0x0004; 0x0008; 0x0010; 0x0020; 0x0040 ]
    [ cwX; cwY; cwWidth; cwHeight; cwBorderWidth; cwSibling; cwStackMode ]

let test_no_changes () =
  let mask, _ = Xwindowchanges_ctypes.window_changes_to_c (window_changes ()) in
  Alcotest.(check int) "value_mask" 0 mask

let test_geometry () =
  let mask, c =
    Xwindowchanges_ctypes.window_changes_to_c
      (window_changes ~x:10 ~y:(-20) ~width:800 ~height:600 ~border_width:2 ())
  in
  Alcotest.(check int)
    "value_mask"
    (cwX lor cwY lor cwWidth lor cwHeight lor cwBorderWidth)
    mask;
  Alcotest.(check int) "x" 10 (getf c xwc_x);
  Alcotest.(check int) "y" (-20) (getf c xwc_y);
  Alcotest.(check int) "width" 800 (getf c xwc_width);
  Alcotest.(check int) "height" 600 (getf c xwc_height);
  Alcotest.(check int) "border_width" 2 (getf c xwc_border_width)

(* Only the fields that are set make it into the mask *)
let test_partial () =
  let mask, c =
    Xwindowchanges_ctypes.window_changes_to_c (window_changes ~width:1 ())
  in
  Alcotest.(check int) "value_mask" cwWidth mask;
  Alcotest.(check int) "width" 1 (getf c xwc_width)

(* A raise: a stack mode alone, relative to all siblings *)
let test_stacking () =
  let mask, c =
    Xwindowchanges_ctypes.window_changes_to_c
      (window_changes ~stacking:(Above, None) ())
  in
  Alcotest.(check int) "value_mask" cwStackMode mask;
  Alcotest.(check bool) "stack_mode" true (getf c xwc_stack_mode = Above)

(* Just below a given sibling: the sibling comes with its stack mode *)
let test_stacking_sibling () =
  let mask, c =
    Xwindowchanges_ctypes.window_changes_to_c
      (window_changes ~stacking:(Below, Some (Unsigned.ULong.of_int 42)) ())
  in
  Alcotest.(check int) "value_mask" (cwSibling lor cwStackMode) mask;
  Alcotest.(check bool) "stack_mode" true (getf c xwc_stack_mode = Below);
  Alcotest.(check int) "sibling" 42 (Unsigned.ULong.to_int (getf c xwc_sibling))

(* Every field set, as when granting a ConfigureRequest *)
let every_field =
  window_changes ~x:10 ~y:20 ~width:300 ~height:200 ~border_width:2
    ~stacking:(Below, Some (Unsigned.ULong.of_int 42))
    ()

(* The mask only keeps the fields it names *)
let test_mask_filters () =
  let mask, c =
    Xwindowchanges_ctypes.window_changes_to_c ~value_mask:(cwWidth lor cwY)
      every_field
  in
  Alcotest.(check int) "value_mask" (cwWidth lor cwY) mask;
  Alcotest.(check int) "width" 300 (getf c xwc_width);
  Alcotest.(check int) "y" 20 (getf c xwc_y);
  Alcotest.(check int) "x left at zero" 0 (getf c xwc_x)

(* A flag whose field is None adds nothing, nor do bits no CW flag uses *)
let test_mask_no_field () =
  let mask, _ =
    Xwindowchanges_ctypes.window_changes_to_c
      ~value_mask:(cwX lor cwWidth lor 0x80)
      (window_changes ~width:1 ())
  in
  Alcotest.(check int) "value_mask" cwWidth mask

(* Without the stack mode, the sibling isn't sent either *)
let test_mask_sibling_alone () =
  let mask, _ =
    Xwindowchanges_ctypes.window_changes_to_c
      ~value_mask:(cwWidth lor cwSibling) every_field
  in
  Alcotest.(check int) "value_mask" cwWidth mask

(* The stack mode alone: restacked against all siblings *)
let test_mask_stack_mode_alone () =
  let mask, c =
    Xwindowchanges_ctypes.window_changes_to_c ~value_mask:cwStackMode
      every_field
  in
  Alcotest.(check int) "value_mask" cwStackMode mask;
  Alcotest.(check bool) "stack_mode" true (getf c xwc_stack_mode = Below);
  Alcotest.(check int)
    "sibling left at zero" 0
    (Unsigned.ULong.to_int (getf c xwc_sibling))

let () =
  Alcotest.run "X11 XWindowChanges"
    [
      ( "window_changes_to_c",
        [
          Alcotest.test_case "CW flags" `Quick test_flags;
          Alcotest.test_case "no changes" `Quick test_no_changes;
          Alcotest.test_case "geometry" `Quick test_geometry;
          Alcotest.test_case "one field" `Quick test_partial;
          Alcotest.test_case "stacking" `Quick test_stacking;
          Alcotest.test_case "stacking with sibling" `Quick
            test_stacking_sibling;
        ] );
      ( "value_mask",
        [
          Alcotest.test_case "keeps the fields it names" `Quick
            test_mask_filters;
          Alcotest.test_case "flag without a field" `Quick test_mask_no_field;
          Alcotest.test_case "sibling without stack mode" `Quick
            test_mask_sibling_alone;
          Alcotest.test_case "stack mode alone" `Quick
            test_mask_stack_mode_alone;
        ] );
    ]
