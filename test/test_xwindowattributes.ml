open X11

(* External C functions *)
external get_xwa_basic : unit -> windowAttributes = "get_xwa_basic"

let test_xwa_basic () =
  let xwa = get_xwa_basic () in
  Alcotest.(check (pair int int)) "pos" (100, 200) xwa.pos;
  Alcotest.(check (pair int int)) "size" (800, 600) xwa.size;
  Alcotest.(check int) "border_width" 2 xwa.border_width;
  Alcotest.(check int) "depth" 24 xwa.depth;
  Alcotest.(check int) "c_class" 1 xwa.c_class;
  Alcotest.(check int) "bit_gravity" 1 xwa.bit_gravity;
  Alcotest.(check int) "win_gravity" 1 xwa.win_gravity;
  Alcotest.(check int) "backing_store" 0 xwa.backing_store;
  Alcotest.(check int) "backing_planes" 0xFFFFFFFF xwa.backing_planes;
  Alcotest.(check int) "backing_pixel" 0 xwa.backing_pixel;
  Alcotest.(check bool) "save_under" false xwa.save_under;
  Alcotest.(check int) "map_state" 2 xwa.map_state;
  Alcotest.(check bool)
    "all_event_masks" true
    (structureNotifyMask ||| exposureMask = xwa.all_event_masks);
  Alcotest.(check bool)
    "your_event_mask" true
    (structureNotifyMask = xwa.your_event_mask);
  Alcotest.(check int) "do_not_propagate_mask" 0 xwa.do_not_propagate_mask;
  Alcotest.(check bool) "override_redirect" false xwa.override_redirect;
  ()

let suite =
  let open Alcotest in
  [ test_case "basic" `Quick test_xwa_basic ]
