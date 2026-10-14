open X11_internal
open Xevent
open Helpers

external get_raw_client_message_ev_b : unit -> nativeint
  = "get_raw_client_message_ev_b"

external get_raw_client_message_ev_s : unit -> nativeint
  = "get_raw_client_message_ev_s"

external get_raw_client_message_ev_l : unit -> nativeint
  = "get_raw_client_message_ev_l"

let test_client_message_ev_b () =
  match xevent_of_raw_address (get_raw_client_message_ev_b ()) with
  | ClientMessage ev -> (
      Alcotest.(check int) "serial" 330 (Unsigned.ULong.to_int ev.serial);
      Alcotest.(check bool) "send_event" true ev.send_event;
      match ev.data with
      | Bytes b ->
          Alcotest.(check (seq char))
            "data"
            ("ABCDEFGHIJKLMNOPQRST" |> String.to_seq)
            (Array.to_seq b)
      | _ -> Alcotest.fail "Expected bytes")
  | _ -> Alcotest.fail "Expected ClientMessage event"

let test_client_meessage_ev_s () =
  match xevent_of_raw_address (get_raw_client_message_ev_s ()) with
  | ClientMessage ev -> (
      match ev.data with
      | Shorts s ->
          Alcotest.(check (array int))
            "data"
            [| 0; 1; 2; 3; 4; 5; 6; 7; 8; 9 |]
            s
      | _ -> Alcotest.fail "Expected short")
  | _ -> Alcotest.fail "Expected ClientMessage event"

let test_client_meessage_ev_l () =
  match xevent_of_raw_address (get_raw_client_message_ev_l ()) with
  | ClientMessage ev -> (
      match ev.data with
      | Longs s ->
          Alcotest.(check (array int))
            "data" [| 0; 1; 2; 3; 4 |]
            (Array.map Signed.Long.to_int s)
      | _ -> Alcotest.fail "Expected long")
  | _ -> Alcotest.fail "Expected ClientMessage event"

let suite =
  let open Alcotest in
  ( "XClientMessageEvent",
    [
      test_case "ClientMessage (bytes)" `Quick test_client_message_ev_b;
      test_case "ClientMessage (shorts)" `Quick test_client_meessage_ev_s;
      test_case "ClientMessage (longs)" `Quick test_client_meessage_ev_l;
    ] )
