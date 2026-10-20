(* Each module tests the conversion of one XEvent struct. A new one must be
   added here, or its tests won't run. *)
let () =
  Alcotest.run "X11 XEvent"
    [
      Xkey.suite;
      Xbutton.suite;
      Xmotion.suite;
      Xcrossing.suite;
      Xfocus.suite;
      Xexpose.suite;
      Xcreatewindow.suite;
      Xdestroywindow.suite;
      Xunmap.suite;
      Xmap.suite;
      Xmaprequest.suite;
      Xreparent.suite;
      Xconfigure.suite;
      Xconfigurerequest.suite;
      Xgravity.suite;
      Xcirculate.suite;
      Xcirculaterequest.suite;
      Xproperty.suite;
      Xclient.suite;
      Xmapping.suite;
    ]
