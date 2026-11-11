open X11_internal
open Xevent
open Helpers

external get_raw_bad_window_error : unit -> nativeint
  = "get_raw_bad_window_error"

external get_raw_extension_error : unit -> nativeint = "get_raw_extension_error"

(* The error handler gets an XErrorEvent, not an XEvent *)
let error_of_raw_address address =
  Ctypes.(!@(from_voidp C.Types.xerror_event (ptr_of_raw_address address)))
  |> Xevent_ctypes.error_of_c

(* BadWindow (3) from GetWindowAttributes (3) *)
let test_bad_window () =
  let ev = error_of_raw_address (get_raw_bad_window_error ()) in
  Alcotest.(check int) "display" 0x3337 (display_address ev.display);
  Alcotest.(check int)
    "resourceid" 0x400001
    (Unsigned.ULong.to_int ev.resourceid);
  Alcotest.(check int) "serial" 342 (Unsigned.ULong.to_int ev.serial);
  Alcotest.(check (triple int int int)) "codes" (3, 3, 0) ev.codes

(* The codes are unsigned chars: 255 doesn't come back as -1 *)
let test_extension () =
  let ev = error_of_raw_address (get_raw_extension_error ()) in
  Alcotest.(check int) "display" 0x3338 (display_address ev.display);
  Alcotest.(check int) "resourceid" 0 (Unsigned.ULong.to_int ev.resourceid);
  Alcotest.(check int) "serial" 343 (Unsigned.ULong.to_int ev.serial);
  Alcotest.(check (triple int int int)) "codes" (255, 140, 7) ev.codes

let suite =
  let open Alcotest in
  ( "XErrorEvent",
    [
      test_case "BadWindow" `Quick test_bad_window;
      test_case "extension error" `Quick test_extension;
    ] )
