open X11_internal
open C.Types
open Xwindowattributes
open Type_description.Enums
open Mask

(* External C functions *)
external get_xwa_basic_raw : unit -> nativeint = "get_xwa_basic"
external get_xwa_zeroed_raw : unit -> nativeint = "get_xwa_zeroed"

external get_xwa_negative_coords_raw : unit -> nativeint
  = "get_xwa_negative_coords"

external get_xwa_huge_dimensions_raw : unit -> nativeint
  = "get_xwa_huge_dimensions"

external get_xwa_input_only_raw : unit -> nativeint = "get_xwa_input_only"

external get_xwa_max_masks_planes_raw : unit -> nativeint
  = "get_xwa_max_masks_planes"

external get_xwa_bools_true_raw : unit -> nativeint = "get_xwa_bools_true"

external get_xwa_gravities_store_raw : unit -> nativeint
  = "get_xwa_gravities_store"

external get_xwa_unviewable_raw : unit -> nativeint = "get_xwa_unviewable"
external get_xwa_max_pointers_raw : unit -> nativeint = "get_xwa_max_pointers"

(* The C stubs return the address of a static [XWindowAttributes]: read it
   through the same converter as [get_window_attributes] *)
let address ptr = Nativeint.to_int (Ctypes.raw_address_of_ptr ptr)

let of_raw_address raw =
  Ctypes.(!@(from_voidp xwindowattributes (ptr_of_raw_address raw)))
  |> Xwindowattributes_ctypes.window_attributes_of_c

let get_xwa_basic () = of_raw_address (get_xwa_basic_raw ())
let get_xwa_zeroed () = of_raw_address (get_xwa_zeroed_raw ())
let get_xwa_negative_coords () = of_raw_address (get_xwa_negative_coords_raw ())
let get_xwa_huge_dimensions () = of_raw_address (get_xwa_huge_dimensions_raw ())
let get_xwa_input_only () = of_raw_address (get_xwa_input_only_raw ())

let get_xwa_max_masks_planes () =
  of_raw_address (get_xwa_max_masks_planes_raw ())

let get_xwa_bools_true () = of_raw_address (get_xwa_bools_true_raw ())
let get_xwa_gravities_store () = of_raw_address (get_xwa_gravities_store_raw ())
let get_xwa_unviewable () = of_raw_address (get_xwa_unviewable_raw ())
let get_xwa_max_pointers () = of_raw_address (get_xwa_max_pointers_raw ())

let test_xwa_basic () =
  let xwa = get_xwa_basic () in
  Alcotest.(check (pair int int)) "pos" (100, 200) xwa.pos;
  Alcotest.(check (pair int int)) "size" (800, 600) xwa.size;
  Alcotest.(check int) "border_width" 2 xwa.border_width;
  Alcotest.(check int) "depth" 24 xwa.depth;
  Alcotest.(check int) "visual" 0x12345678 (address xwa.visual);
  Alcotest.(check int) "root" 1234 (Unsigned.ULong.to_int xwa.root);
  Alcotest.(check bool) "c_class" true (xwa.c_class = InputOutput);
  Alcotest.(check bool) "bit_gravity" true (xwa.bit_gravity = NorthWestGravity);
  Alcotest.(check bool) "win_gravity" true (xwa.win_gravity = NorthWestGravity);
  Alcotest.(check bool) "backing_store" true (xwa.backing_store = NotUseful);
  Alcotest.(check int) "backing_planes" 0xFFFFFFFF xwa.backing_planes;
  Alcotest.(check int) "backing_pixel" 0 xwa.backing_pixel;
  Alcotest.(check bool) "save_under" false xwa.save_under;
  Alcotest.(check bool) "map_state" true (xwa.map_state = IsViewable);
  Alcotest.(check bool)
    "all_event_masks" true
    (structureNotifyMask ||| exposureMask = xwa.all_event_masks);
  Alcotest.(check bool)
    "your_event_mask" true
    (structureNotifyMask = xwa.your_event_mask);
  Alcotest.(check int) "do_not_propagate_mask" 0 xwa.do_not_propagate_mask;
  Alcotest.(check bool) "override_redirect" false xwa.override_redirect;
  Alcotest.(check int) "colormap" 5678 (Unsigned.ULong.to_int xwa.colormap);
  Alcotest.(check int) "screen" 0x87654321 (address xwa.screen);
  ()

let test_xwa_zeroed () =
  let xwa = get_xwa_zeroed () in
  Alcotest.(check (pair int int)) "pos" (0, 0) xwa.pos;
  Alcotest.(check (pair int int)) "size" (0, 0) xwa.size;
  Alcotest.(check int) "border_width" 0 xwa.border_width;
  Alcotest.(check int) "depth" 0 xwa.depth;
  Alcotest.(check bool) "c_class" true (xwa.c_class = CopyFromParent);
  Alcotest.(check bool) "bit_gravity" true (xwa.bit_gravity = ForgetGravity);
  Alcotest.(check bool) "win_gravity" true (xwa.win_gravity = UnmapGravity);
  Alcotest.(check bool) "backing_store" true (xwa.backing_store = NotUseful);
  Alcotest.(check int) "backing_planes" 0 xwa.backing_planes;
  Alcotest.(check int) "backing_pixel" 0 xwa.backing_pixel;
  Alcotest.(check bool) "save_under" false xwa.save_under;
  Alcotest.(check bool) "map_state" true (xwa.map_state = IsUnmapped);
  Alcotest.(check bool)
    "all_event_masks" true
    (noEventMask = xwa.all_event_masks);
  Alcotest.(check bool)
    "your_event_mask" true
    (noEventMask = xwa.your_event_mask);
  Alcotest.(check int) "do_not_propagate_mask" 0 xwa.do_not_propagate_mask;
  Alcotest.(check bool) "override_redirect" false xwa.override_redirect;
  ()

let test_xwa_negative_coords () =
  let xwa = get_xwa_negative_coords () in
  Alcotest.(check (pair int int)) "pos" (-1500, -2000) xwa.pos;
  Alcotest.(check (pair int int)) "size" (1920, 1080) xwa.size;
  Alcotest.(check int) "border_width" 0 xwa.border_width;
  Alcotest.(check int) "depth" 24 xwa.depth;
  Alcotest.(check bool) "c_class" true (xwa.c_class = InputOutput);
  Alcotest.(check bool) "bit_gravity" true (xwa.bit_gravity = NorthWestGravity);
  Alcotest.(check bool) "win_gravity" true (xwa.win_gravity = NorthWestGravity);
  Alcotest.(check bool) "backing_store" true (xwa.backing_store = NotUseful);
  Alcotest.(check bool) "save_under" false xwa.save_under;
  Alcotest.(check bool) "map_state" true (xwa.map_state = IsViewable);
  Alcotest.(check bool) "map_installed" true xwa.map_installed;
  Alcotest.(check bool) "override_redirect" false xwa.override_redirect;
  ()

let test_xwa_huge_dimensions () =
  let xwa = get_xwa_huge_dimensions () in
  Alcotest.(check (pair int int)) "pos" (0, 0) xwa.pos;
  Alcotest.(check (pair int int)) "size" (2147483647, 2147483647) xwa.size;
  Alcotest.(check int) "border_width" 2147483647 xwa.border_width;
  Alcotest.(check int) "depth" 32 xwa.depth;
  Alcotest.(check bool) "c_class" true (xwa.c_class = InputOutput);
  Alcotest.(check bool) "bit_gravity" true (xwa.bit_gravity = NorthWestGravity);
  Alcotest.(check bool) "win_gravity" true (xwa.win_gravity = NorthWestGravity);
  Alcotest.(check bool) "backing_store" true (xwa.backing_store = NotUseful);
  Alcotest.(check bool) "save_under" false xwa.save_under;
  Alcotest.(check bool) "map_state" true (xwa.map_state = IsViewable);
  Alcotest.(check bool) "map_installed" true xwa.map_installed;
  Alcotest.(check bool) "override_redirect" false xwa.override_redirect;
  ()

let test_xwa_input_only () =
  let xwa = get_xwa_input_only () in
  Alcotest.(check (pair int int)) "pos" (10, 10) xwa.pos;
  Alcotest.(check (pair int int)) "size" (100, 100) xwa.size;
  Alcotest.(check int) "border_width" 0 xwa.border_width;
  Alcotest.(check int) "depth" 0 xwa.depth;
  Alcotest.(check bool) "c_class" true (xwa.c_class = InputOnly);
  Alcotest.(check bool) "bit_gravity" true (xwa.bit_gravity = ForgetGravity);
  Alcotest.(check bool) "win_gravity" true (xwa.win_gravity = NorthWestGravity);
  Alcotest.(check bool) "backing_store" true (xwa.backing_store = NotUseful);
  Alcotest.(check int) "backing_planes" 0 xwa.backing_planes;
  Alcotest.(check int) "backing_pixel" 0 xwa.backing_pixel;
  Alcotest.(check bool) "save_under" false xwa.save_under;
  (* Alcotest.(check int) "colormap" 0 xwa.colormap;*)
  Alcotest.(check bool) "map_installed" false xwa.map_installed;
  Alcotest.(check bool) "map_state" true (xwa.map_state = IsUnmapped);
  Alcotest.(check bool)
    "all_event_masks" true
    (enterWindowMask ||| leaveWindowMask = xwa.all_event_masks);
  Alcotest.(check bool)
    "your_event_mask" true
    (enterWindowMask = xwa.your_event_mask);
  Alcotest.(check bool) "override_redirect" true xwa.override_redirect;
  ()

let test_xwa_max_masks_planes () =
  let xwa = get_xwa_max_masks_planes () in
  Alcotest.(check (pair int int)) "pos" (0, 0) xwa.pos;
  Alcotest.(check (pair int int)) "size" (10, 10) xwa.size;
  Alcotest.(check int) "border_width" 0 xwa.border_width;
  Alcotest.(check int) "depth" 24 xwa.depth;
  Alcotest.(check bool) "c_class" true (xwa.c_class = InputOutput);
  Alcotest.(check bool) "bit_gravity" true (xwa.bit_gravity = NorthWestGravity);
  Alcotest.(check bool) "win_gravity" true (xwa.win_gravity = NorthWestGravity);
  Alcotest.(check bool) "backing_store" true (xwa.backing_store = NotUseful);
  Alcotest.(check int) "backing_planes max" (-1) xwa.backing_planes;
  Alcotest.(check int) "backing_pixel max" (-1) xwa.backing_pixel;
  Alcotest.(check bool) "save_under" false xwa.save_under;
  Alcotest.(check bool) "map_state" true (xwa.map_state = IsViewable);
  Alcotest.(check bool) "map_installed" true xwa.map_installed;
  (*Alcotest.(check bool)
    "all_event_masks max" true
    (xwa.all_event_masks = max_int);
  Alcotest.(check bool)
    "your_event_mask max" true
    (xwa.your_event_mask = max_int);*)
  Alcotest.(check int)
    "do_not_propagate_mask max" (-1) xwa.do_not_propagate_mask;
  Alcotest.(check bool) "override_redirect" false xwa.override_redirect;
  ()

let test_xwa_bools_true () =
  let xwa = get_xwa_bools_true () in
  Alcotest.(check (pair int int)) "pos" (5, 5) xwa.pos;
  Alcotest.(check (pair int int)) "size" (50, 50) xwa.size;
  Alcotest.(check int) "border_width" 1 xwa.border_width;
  Alcotest.(check int) "depth" 8 xwa.depth;
  Alcotest.(check bool) "c_class" true (xwa.c_class = InputOutput);
  Alcotest.(check bool) "bit_gravity" true (xwa.bit_gravity = NorthWestGravity);
  Alcotest.(check bool) "win_gravity" true (xwa.win_gravity = NorthWestGravity);
  Alcotest.(check bool) "backing_store" true (xwa.backing_store = NotUseful);
  Alcotest.(check int) "backing_planes" 0xFF xwa.backing_planes;
  Alcotest.(check int) "backing_pixel" 0xFF xwa.backing_pixel;
  Alcotest.(check bool) "save_under" true xwa.save_under;
  Alcotest.(check bool) "map_installed" true xwa.map_installed;
  Alcotest.(check bool) "map_state" true (xwa.map_state = IsViewable);
  Alcotest.(check int) "do_not_propagate_mask" 0 xwa.do_not_propagate_mask;
  Alcotest.(check bool) "override_redirect" true xwa.override_redirect;
  ()

let test_xwa_gravities_store () =
  let xwa = get_xwa_gravities_store () in
  Alcotest.(check (pair int int)) "pos" (20, 20) xwa.pos;
  Alcotest.(check (pair int int)) "size" (200, 200) xwa.size;
  Alcotest.(check int) "border_width" 5 xwa.border_width;
  Alcotest.(check int) "depth" 32 xwa.depth;
  Alcotest.(check bool) "c_class" true (xwa.c_class = InputOutput);
  Alcotest.(check bool) "bit_gravity" true (xwa.bit_gravity = CenterGravity);
  Alcotest.(check bool) "win_gravity" true (xwa.win_gravity = StaticGravity);
  Alcotest.(check bool) "backing_store" true (xwa.backing_store = Always);
  Alcotest.(check int) "backing_planes" 0xFFFFFF xwa.backing_planes;
  Alcotest.(check int) "backing_pixel" 0xABCDEF xwa.backing_pixel;
  Alcotest.(check bool) "save_under" false xwa.save_under;
  Alcotest.(check bool) "map_state" true (xwa.map_state = IsViewable);
  Alcotest.(check bool) "map_installed" false xwa.map_installed;
  Alcotest.(check int) "do_not_propagate_mask" 0 xwa.do_not_propagate_mask;
  Alcotest.(check bool) "override_redirect" false xwa.override_redirect;
  ()

let test_xwa_unviewable () =
  let xwa = get_xwa_unviewable () in
  Alcotest.(check (pair int int)) "pos" (0, 0) xwa.pos;
  Alcotest.(check (pair int int)) "size" (1920, 1080) xwa.size;
  Alcotest.(check int) "border_width" 0 xwa.border_width;
  Alcotest.(check int) "depth" 24 xwa.depth;
  Alcotest.(check bool) "c_class" true (xwa.c_class = InputOutput);
  Alcotest.(check bool) "bit_gravity" true (xwa.bit_gravity = NorthWestGravity);
  Alcotest.(check bool) "win_gravity" true (xwa.win_gravity = NorthWestGravity);
  Alcotest.(check bool) "backing_store" true (xwa.backing_store = WhenMapped);
  Alcotest.(check bool) "save_under" false xwa.save_under;
  Alcotest.(check bool) "map_installed" true xwa.map_installed;
  Alcotest.(check bool) "map_state" true (xwa.map_state = IsUnviewable);
  Alcotest.(check int) "do_not_propagate_mask" 0 xwa.do_not_propagate_mask;
  Alcotest.(check bool) "override_redirect" false xwa.override_redirect;
  ()

let test_xwa_max_pointers () =
  let xwa = get_xwa_max_pointers () in
  Alcotest.(check (pair int int)) "pos" (0, 0) xwa.pos;
  Alcotest.(check (pair int int)) "size" (1, 1) xwa.size;
  Alcotest.(check int) "border_width" 0 xwa.border_width;
  Alcotest.(check int) "depth" 1 xwa.depth;
  Alcotest.(check bool) "c_class" true (xwa.c_class = InputOutput);
  Alcotest.(check bool) "bit_gravity" true (xwa.bit_gravity = NorthWestGravity);
  Alcotest.(check bool) "win_gravity" true (xwa.win_gravity = NorthWestGravity);
  Alcotest.(check bool) "backing_store" true (xwa.backing_store = NotUseful);
  Alcotest.(check int) "backing_planes" 0 xwa.backing_planes;
  Alcotest.(check int) "backing_pixel" 0 xwa.backing_pixel;
  Alcotest.(check bool) "save_under" false xwa.save_under;
  (* all-ones: unsigned XIDs and pointers must come back unchanged *)
  Alcotest.(check bool) "root" true (Unsigned.ULong.max_int = xwa.root);
  Alcotest.(check bool) "colormap" true (Unsigned.ULong.max_int = xwa.colormap);
  Alcotest.(check int) "visual" (-1) (address xwa.visual);
  Alcotest.(check int) "screen" (-1) (address xwa.screen);
  Alcotest.(check bool) "map_installed" false xwa.map_installed;
  Alcotest.(check bool) "map_state" true (xwa.map_state = IsUnmapped);
  Alcotest.(check bool)
    "all_event_masks" true
    (noEventMask = xwa.all_event_masks);
  Alcotest.(check bool)
    "your_event_mask" true
    (noEventMask = xwa.your_event_mask);
  Alcotest.(check int) "do_not_propagate_mask" 0 xwa.do_not_propagate_mask;
  Alcotest.(check bool) "override_redirect" false xwa.override_redirect;
  ()

let () =
  let open Alcotest in
  run "X11 XWindowAttributes"
    [
      ( "XWindowAttributes",
        [
          test_case "basic" `Quick test_xwa_basic;
          test_case "zeroed" `Quick test_xwa_zeroed;
          test_case "negative_coords" `Quick test_xwa_negative_coords;
          test_case "huge_dimensions" `Quick test_xwa_huge_dimensions;
          test_case "input_only" `Quick test_xwa_input_only;
          test_case "max_masks_planes" `Quick test_xwa_max_masks_planes;
          test_case "bools_true" `Quick test_xwa_bools_true;
          test_case "gravities_store" `Quick test_xwa_gravities_store;
          test_case "unviewable" `Quick test_xwa_unviewable;
          test_case "max_pointers" `Quick test_xwa_max_pointers;
        ] );
    ]
