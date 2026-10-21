(* Each module tests one function against Xvfb. A new one must be added here,
   or its tests won't run. *)
let () =
  Alcotest.run "X11 Integration"
    [
      Key_events.suite;
      Event_state.suite;
      Get_window_attributes.suite;
      Store_name.suite;
      Intern_atom.suite;
      Set_wm_protocols.suite;
      Destroy_window.suite;
    ]
