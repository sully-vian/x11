let () =
  Alcotest.run "X11 Core Bindings"
    [
      ("XEvent", Test_xevent.suite);
      ("XWindowAttributes", Test_xwindowattributes.suite);
      ("X11 X", Test_x.suite);
      ("X11 compilation", Test_compilation.suite);
    ]
