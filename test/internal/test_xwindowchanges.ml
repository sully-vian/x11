open X11_internal
open Ctypes
open C.Types
open Type_description.Enums
open Xwindowchanges

(* CW flags as the protocol defines them, to catch a wrong constant *)
let cw_x = 1
let cw_y = 2
let cw_width = 4
let cw_height = 8
let cw_border_width = 16
let cw_sibling = 32
let cw_stack_mode = 64

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
    (cw_x lor cw_y lor cw_width lor cw_height lor cw_border_width)
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
  Alcotest.(check int) "value_mask" cw_width mask;
  Alcotest.(check int) "width" 1 (getf c xwc_width)

(* A raise: a stack mode alone, relative to all siblings *)
let test_stacking () =
  let mask, c =
    Xwindowchanges_ctypes.window_changes_to_c
      (window_changes ~stacking:(Above, None) ())
  in
  Alcotest.(check int) "value_mask" cw_stack_mode mask;
  Alcotest.(check bool) "stack_mode" true (getf c xwc_stack_mode = Above)

(* Just below a given sibling: the sibling comes with its stack mode *)
let test_stacking_sibling () =
  let mask, c =
    Xwindowchanges_ctypes.window_changes_to_c
      (window_changes ~stacking:(Below, Some (Unsigned.ULong.of_int 42)) ())
  in
  Alcotest.(check int) "value_mask" (cw_sibling lor cw_stack_mode) mask;
  Alcotest.(check bool) "stack_mode" true (getf c xwc_stack_mode = Below);
  Alcotest.(check int) "sibling" 42 (Unsigned.ULong.to_int (getf c xwc_sibling))

let () =
  Alcotest.run "X11 XWindowChanges"
    [
      ( "window_changes_to_c",
        [
          Alcotest.test_case "no changes" `Quick test_no_changes;
          Alcotest.test_case "geometry" `Quick test_geometry;
          Alcotest.test_case "one field" `Quick test_partial;
          Alcotest.test_case "stacking" `Quick test_stacking;
          Alcotest.test_case "stacking with sibling" `Quick
            test_stacking_sibling;
        ] );
    ]
