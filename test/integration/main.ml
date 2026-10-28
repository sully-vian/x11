(* Each module tests one function or feature against Xvfb. A new one must be
   added here, or its tests won't run. *)
let () =
  Alcotest.run "X11 Integration"
    [
      Key_events.suite;
      Event_state.suite;
      Keysym_to_keycode.suite;
      Get_window_attributes.suite;
      Configure_window.suite;
      Window_mapping.suite;
      Store_name.suite;
      Intern_atom.suite;
      Set_wm_protocols.suite;
      Destroy_window.suite;
    ]
