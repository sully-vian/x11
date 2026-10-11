let () =
  Alcotest.run "X11 internals"
    [
      ("XEvent", Test_xevent.suite);
      (*("XWindowAttributes", Test_xwindowattributes.suite);*)
    ]
