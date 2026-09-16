let () =
  Alcotest.run "X11 Core Bindings"
    [ ("XEvent", Test_xevent.suite); ("X11 example", Test_example.suite) ]
