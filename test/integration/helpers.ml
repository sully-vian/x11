(* Runs [f] against its own Xvfb, with DISPLAY set to it. Xvfb picks a free
   display and, with -displayfd 1, writes its number to our pipe once it
   accepts connections: no fixed wait, no clash with a running server. *)
let with_xvfb f () =
  let ready_out, ready_in = Unix.pipe ~cloexec:true () in
  let pid =
    Unix.create_process "Xvfb"
      [| "Xvfb"; "-displayfd"; "1" |]
      Unix.stdin ready_in Unix.stderr
  in
  (* Only Xvfb holds the write end now, so the read fails if it exits *)
  Unix.close ready_in;
  let ready = Unix.in_channel_of_descr ready_out in
  let cleanup () =
    close_in_noerr ready;
    (try Unix.kill pid Sys.sigterm with _ -> ());
    ignore (try Unix.waitpid [] pid with _ -> (pid, Unix.WEXITED 0))
  in
  Fun.protect ~finally:cleanup (fun () ->
      let display =
        try input_line ready
        with End_of_file -> Alcotest.fail "Xvfb exited before it was ready"
      in
      Unix.putenv "DISPLAY" (":" ^ display);
      f ())
