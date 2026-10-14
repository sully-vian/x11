(* Each test runs against its own Xvfb on [display_name] *)
let display_name = ":99"

let with_xvfb f () =
  Unix.putenv "DISPLAY" display_name;
  let pid =
    Unix.create_process "Xvfb" [| "Xvfb"; display_name |] Unix.stdin Unix.stdout
      Unix.stderr
  in
  Unix.sleep 1;
  let cleanup () =
    (try Unix.kill pid Sys.sigterm with _ -> ());
    ignore (try Unix.waitpid [] pid with _ -> (pid, Unix.WEXITED 0))
  in

  let result =
    try f ()
    with exn ->
      cleanup ();
      raise exn
  in
  cleanup ();
  result
