open Ctypes

module Event_type = struct
  type t =
    | KeyPress
    | KeyRelease
    | ButtonPress
    | ButtonRelease
    | MotionNotify
    | EnterNotify
    | LeaveNotify
    | FocusIn
    | FocusOut
    | KeymapNotify
    | Expose
    | GraphicsExpose
    | NoExpose
    | VisibilityNotify
    | CreateNotify
    | DestroyNotify
    | UnmapNotify
    | MapNotify
    | MapRequest
    | ReparentNotify
    | ConfigureNotify
    | ConfigureRequest
    | GravityNotify
    | ResizeRequest
    | CirculateNotify
    | CirculateRequest
    | PropertyNotify
    | SelectionClear
    | SelectionRequest
    | SelectionNotify
    | ColormapNotify
    | ClientMessage
    | MappingNotify
    | GenericEvent
    | Unknown of int64  (** extension events have dynamic codes *)
end

(* Variants backed by int X constants. Xevent re-exports them with [include]. *)
module Enums = struct
  type circulationRequest = PlaceOnTop | PlaceOnBottom
  type propertyNotification = PropertyNewValue | PropertyDelete
  type colorMapNotification = ColormapUninstalled | ColormapInstalled
  type windowStackingMethod = Above | Below | TopIf | BottomIf | Opposite

  type notifyMode =
    | NotifyNormal
    | NotifyGrab
    | NotifyUngrab
    | NotifyWhileGrabbed

  type notifyDetail =
    | NotifyAncestor
    | NotifyVirtual
    | NotifyInferior
    | NotifyNonlinear
    | NotifyNonlinearVirtual
    | NotifyPointer
    | NotifyPointerRoot
    | NotifyDetailNone
end

open Enums

module Types (F : Ctypes.TYPE) = struct
  open F

  type display = unit ptr
  type atom = Unsigned.ULong.t
  type window = Unsigned.ULong.t
  type time = Unsigned.ULong.t
  type keysym = int
  type keycode = int
  type button = int

  let display = ptr void
  let atom = ulong
  let window = ulong
  let time = ulong
  let keysym = int
  let keycode = int
  let button = int
  let eventMask = int
  let grabMode = int
  let cursor = int
  let keyMask = int
  let noEventMask = constant "NoEventMask" int
  let keyPressMask = constant "KeyPressMask" int
  let keyReleaseMask = constant "KeyReleaseMask" int
  let buttonPressMask = constant "ButtonPressMask" int
  let buttonReleaseMask = constant "ButtonReleaseMask" int
  let enterWindowMask = constant "EnterWindowMask" int
  let leaveWindowMask = constant "LeaveWindowMask" int
  let pointerMotionMask = constant "PointerMotionMask" int
  let pointerMotionHintMask = constant "PointerMotionHintMask" int
  let button1MotionMask = constant "Button1MotionMask" int
  let button2MotionMask = constant "Button2MotionMask" int
  let button3MotionMask = constant "Button3MotionMask" int
  let button4MotionMask = constant "Button4MotionMask" int
  let button5MotionMask = constant "Button5MotionMask" int
  let buttonMotionMask = constant "ButtonMotionMask" int
  let keymapStateMask = constant "KeymapStateMask" int
  let exposureMask = constant "ExposureMask" int
  let visibilityChangeMask = constant "VisibilityChangeMask" int
  let structureNotifyMask = constant "StructureNotifyMask" int
  let resizeRedirectMask = constant "ResizeRedirectMask" int
  let substructureNotifyMask = constant "SubstructureNotifyMask" int
  let substructureRedirectMask = constant "SubstructureRedirectMask" int
  let focusChangeMask = constant "FocusChangeMask" int
  let propertyChangeMask = constant "PropertyChangeMask" int
  let colormapChangeMask = constant "ColormapChangeMask" int
  let ownerGrabButtonMask = constant "OwnerGrabButtonMask" int
  let shiftMask = constant "ShiftMask" int
  let lockMask = constant "LockMask" int
  let controlMask = constant "ControlMask" int
  let mod1Mask = constant "Mod1Mask" int
  let mod2Mask = constant "Mod2Mask" int
  let mod3Mask = constant "Mod3Mask" int
  let mod4Mask = constant "Mod4Mask" int
  let mod5Mask = constant "Mod5Mask" int
  let grabModeSync = constant "GrabModeSync" int
  let grabModeAsync = constant "GrabModeAsync" int
  let anyButton = constant "AnyButton" int
  let button1 = constant "Button1" int
  let button2 = constant "Button2" int
  let button3 = constant "Button3" int
  let button4 = constant "Button4" int
  let button5 = constant "Button5" int
  let copyFromParent = constant "CopyFromParent" int
  let inputOutput = constant "InputOutput" int
  let inputOnly = constant "InputOnly" int
  let xk_BackSpace = constant "XK_BackSpace" int
  let xk_Tab = constant "XK_Tab" int
  let xk_Linefeed = constant "XK_Linefeed" int
  let xk_Clear = constant "XK_Clear" int
  let xk_Return = constant "XK_Return" int
  let xk_Pause = constant "XK_Pause" int
  let xk_Scroll_Lock = constant "XK_Scroll_Lock" int
  let xk_Sys_Req = constant "XK_Sys_Req" int
  let xk_Escape = constant "XK_Escape" int
  let xk_Delete = constant "XK_Delete" int
  let xk_space = constant "XK_space" int
  let xk_exclam = constant "XK_exclam" int
  let xk_quotedbl = constant "XK_quotedbl" int
  let xk_numbersign = constant "XK_numbersign" int
  let xk_dollar = constant "XK_dollar" int
  let xk_percent = constant "XK_percent" int
  let xk_ampersand = constant "XK_ampersand" int
  let xk_apostrophe = constant "XK_apostrophe" int
  let xk_quoteright = constant "XK_quoteright" int
  let xk_parenleft = constant "XK_parenleft" int
  let xk_parenright = constant "XK_parenright" int
  let xk_asterisk = constant "XK_asterisk" int
  let xk_plus = constant "XK_plus" int
  let xk_comma = constant "XK_comma" int
  let xk_minus = constant "XK_minus" int
  let xk_period = constant "XK_period" int
  let xk_slash = constant "XK_slash" int
  let xk_0 = constant "XK_0" int
  let xk_1 = constant "XK_1" int
  let xk_2 = constant "XK_2" int
  let xk_3 = constant "XK_3" int
  let xk_4 = constant "XK_4" int
  let xk_5 = constant "XK_5" int
  let xk_6 = constant "XK_6" int
  let xk_7 = constant "XK_7" int
  let xk_8 = constant "XK_8" int
  let xk_9 = constant "XK_9" int
  let xk_colon = constant "XK_colon" int
  let xk_semicolon = constant "XK_semicolon" int
  let xk_less = constant "XK_less" int
  let xk_equal = constant "XK_equal" int
  let xk_greater = constant "XK_greater" int
  let xk_question = constant "XK_question" int
  let xk_A = constant "XK_A" int
  let xk_B = constant "XK_B" int
  let xk_C = constant "XK_C" int
  let xk_D = constant "XK_D" int
  let xk_E = constant "XK_E" int
  let xk_F = constant "XK_F" int
  let xk_G = constant "XK_G" int
  let xk_H = constant "XK_H" int
  let xk_I = constant "XK_I" int
  let xk_J = constant "XK_J" int
  let xk_K = constant "XK_K" int
  let xk_L = constant "XK_L" int
  let xk_M = constant "XK_M" int
  let xk_N = constant "XK_N" int
  let xk_O = constant "XK_O" int
  let xk_P = constant "XK_P" int
  let xk_Q = constant "XK_Q" int
  let xk_R = constant "XK_R" int
  let xk_S = constant "XK_S" int
  let xk_T = constant "XK_T" int
  let xk_U = constant "XK_U" int
  let xk_V = constant "XK_V" int
  let xk_W = constant "XK_W" int
  let xk_X = constant "XK_X" int
  let xk_Y = constant "XK_Y" int
  let xk_Z = constant "XK_Z" int
  let xk_bracketleft = constant "XK_bracketleft" int
  let xk_backslash = constant "XK_backslash" int
  let xk_bracketright = constant "XK_bracketright" int
  let xk_asciicircum = constant "XK_asciicircum" int
  let xk_underscore = constant "XK_underscore" int
  let xk_grave = constant "XK_grave" int
  let xk_quoteleft = constant "XK_quoteleft" int
  let xk_a = constant "XK_a" int
  let xk_b = constant "XK_b" int
  let xk_c = constant "XK_c" int
  let xk_d = constant "XK_d" int
  let xk_e = constant "XK_e" int
  let xk_f = constant "XK_f" int
  let xk_g = constant "XK_g" int
  let xk_h = constant "XK_h" int
  let xk_i = constant "XK_i" int
  let xk_j = constant "XK_j" int
  let xk_k = constant "XK_k" int
  let xk_l = constant "XK_l" int
  let xk_m = constant "XK_m" int
  let xk_n = constant "XK_n" int
  let xk_o = constant "XK_o" int
  let xk_p = constant "XK_p" int
  let xk_q = constant "XK_q" int
  let xk_r = constant "XK_r" int
  let xk_s = constant "XK_s" int
  let xk_t = constant "XK_t" int
  let xk_u = constant "XK_u" int
  let xk_v = constant "XK_v" int
  let xk_w = constant "XK_w" int
  let xk_x = constant "XK_x" int
  let xk_y = constant "XK_y" int
  let xk_z = constant "XK_z" int
  let xk_braceleft = constant "XK_braceleft" int
  let xk_bar = constant "XK_bar" int
  let xk_braceright = constant "XK_braceright" int
  let xk_asciitilde = constant "XK_asciitilde" int

  (* X constants are #defines, not C enums: each enum gets its own typedef of
     int (see the ctypes preamble in dune), and [~typedef:true] makes the
     generated stubs use [sizeof(x11_…)] instead of [sizeof(enum x11_…)]. *)
  let event_type : Event_type.t typ =
    let c name = constant name int64_t in
    enum "x11_event_type" ~typedef:true
      ~unexpected:(fun n -> Event_type.Unknown n)
      Event_type.
        [
          (KeyPress, c "KeyPress");
          (KeyRelease, c "KeyRelease");
          (ButtonPress, c "ButtonPress");
          (ButtonRelease, c "ButtonRelease");
          (MotionNotify, c "MotionNotify");
          (EnterNotify, c "EnterNotify");
          (LeaveNotify, c "LeaveNotify");
          (FocusIn, c "FocusIn");
          (FocusOut, c "FocusOut");
          (KeymapNotify, c "KeymapNotify");
          (Expose, c "Expose");
          (GraphicsExpose, c "GraphicsExpose");
          (NoExpose, c "NoExpose");
          (VisibilityNotify, c "VisibilityNotify");
          (CreateNotify, c "CreateNotify");
          (DestroyNotify, c "DestroyNotify");
          (UnmapNotify, c "UnmapNotify");
          (MapNotify, c "MapNotify");
          (MapRequest, c "MapRequest");
          (ReparentNotify, c "ReparentNotify");
          (ConfigureNotify, c "ConfigureNotify");
          (ConfigureRequest, c "ConfigureRequest");
          (GravityNotify, c "GravityNotify");
          (ResizeRequest, c "ResizeRequest");
          (CirculateNotify, c "CirculateNotify");
          (CirculateRequest, c "CirculateRequest");
          (PropertyNotify, c "PropertyNotify");
          (SelectionClear, c "SelectionClear");
          (SelectionRequest, c "SelectionRequest");
          (SelectionNotify, c "SelectionNotify");
          (ColormapNotify, c "ColormapNotify");
          (ClientMessage, c "ClientMessage");
          (MappingNotify, c "MappingNotify");
          (GenericEvent, c "GenericEvent");
        ]

  let notify_mode : notifyMode typ =
    let c name = constant name int64_t in
    enum "x11_notify_mode" ~typedef:true
      [
        (NotifyNormal, c "NotifyNormal");
        (NotifyGrab, c "NotifyGrab");
        (NotifyUngrab, c "NotifyUngrab");
        (NotifyWhileGrabbed, c "NotifyWhileGrabbed");
      ]

  let notify_detail : notifyDetail typ =
    let c name = constant name int64_t in
    enum "x11_notify_detail" ~typedef:true
      [
        (NotifyAncestor, c "NotifyAncestor");
        (NotifyVirtual, c "NotifyVirtual");
        (NotifyInferior, c "NotifyInferior");
        (NotifyNonlinear, c "NotifyNonlinear");
        (NotifyNonlinearVirtual, c "NotifyNonlinearVirtual");
        (NotifyPointer, c "NotifyPointer");
        (NotifyPointerRoot, c "NotifyPointerRoot");
        (NotifyDetailNone, c "NotifyDetailNone");
      ]

  type xany_event

  let xany_event : xany_event structure typ =
    typedef (structure "xany_anonymous") "XAnyEvent"

  let xany_type = field xany_event "type" event_type
  let xany_serial = field xany_event "serial" ulong
  let xany_send_event = field xany_event "send_event" int
  let xany_display = field xany_event "display" display
  let xany_window = field xany_event "window" window
  let () = seal xany_event

  type xkey_event

  let xkey_event : xkey_event structure typ =
    typedef (structure "xkey_anonymous") "XKeyEvent"

  let xkey_type = field xkey_event "type" int
  let xkey_serial = field xkey_event "serial" ulong
  let xkey_send_event = field xkey_event "send_event" int
  let xkey_display = field xkey_event "display" display
  let xkey_window = field xkey_event "window" window
  let xkey_root = field xkey_event "root" window
  let xkey_subwindow = field xkey_event "subwindow" window
  let xkey_time = field xkey_event "time" time
  let xkey_x = field xkey_event "x" int
  let xkey_y = field xkey_event "y" int
  let xkey_x_root = field xkey_event "x_root" int
  let xkey_y_root = field xkey_event "y_root" int
  let xkey_state = field xkey_event "state" uint
  let xkey_keycode = field xkey_event "keycode" uint
  let xkey_same_screen = field xkey_event "same_screen" int
  let () = seal xkey_event

  type xbutton_event

  let xbutton_event : xbutton_event structure typ =
    typedef (structure "xbutton_anonymous") "XButtonEvent"

  let xbutton_type = field xbutton_event "type" int
  let xbutton_serial = field xbutton_event "serial" ulong
  let xbutton_send_event = field xbutton_event "send_event" int
  let xbutton_display = field xbutton_event "display" display
  let xbutton_window = field xbutton_event "window" window
  let xbutton_root = field xbutton_event "root" window
  let xbutton_subwindow = field xbutton_event "subwindow" window
  let xbutton_time = field xbutton_event "time" time
  let xbutton_x = field xbutton_event "x" int
  let xbutton_y = field xbutton_event "y" int
  let xbutton_x_root = field xbutton_event "x_root" int
  let xbutton_y_root = field xbutton_event "y_root" int
  let xbutton_state = field xbutton_event "state" uint
  let xbutton_button = field xbutton_event "button" uint
  let xbutton_same_screen = field xbutton_event "same_screen" int
  let () = seal xbutton_event

  type xclient_event

  let xclient_event : xclient_event structure typ =
    typedef (structure "xclient_anonymous") "XClientMessageEvent"

  let xc_type = field xclient_event "type" int
  let xc_serial = field xclient_event "serial" ulong
  let xc_send_event = field xclient_event "send_event" int
  let xc_display = field xclient_event "display" display
  let xc_window = field xclient_event "window" window
  let xc_message_type = field xclient_event "message_type" atom
  let xc_format = field xclient_event "format" int

  (*let xc_data = field xclient_event "data" client_message_data*)
  let xc_data_b = field xclient_event "data.b" (array 20 char)
  let xc_data_s = field xclient_event "data.s" (array 10 short)
  let xc_data_l = field xclient_event "data.l" (array 5 long)
  let () = seal xclient_event

  type xfocus_event

  let xfocus_event : xfocus_event structure typ =
    typedef (structure "xfocus_anonymous") "XFocusChangeEvent"

  let xfocus_type = field xfocus_event "type" event_type
  let xfocus_serial = field xfocus_event "serial" ulong
  let xfocus_send_event = field xfocus_event "send_event" int
  let xfocus_display = field xfocus_event "display" display
  let xfocus_window = field xfocus_event "window" window
  let xfocus_mode = field xfocus_event "mode" notify_mode
  let xfocus_detail = field xfocus_event "detail" notify_detail
  let () = seal xfocus_event

  type xcrossing_event

  let xcrossing_event : xcrossing_event structure typ =
    typedef (structure "xcrossing_anonymous") "XCrossingEvent"

  let xcrossing_type = field xcrossing_event "type" event_type
  let xcrossing_serial = field xcrossing_event "serial" ulong
  let xcrossing_send_event = field xcrossing_event "send_event" int
  let xcrossing_display = field xcrossing_event "display" display
  let xcrossing_window = field xcrossing_event "window" window
  let xcrossing_root = field xcrossing_event "root" window
  let xcrossing_subwindow = field xcrossing_event "subwindow" window
  let xcrossing_time = field xcrossing_event "time" time
  let xcrossing_x = field xcrossing_event "x" int
  let xcrossing_y = field xcrossing_event "y" int
  let xcrossing_x_root = field xcrossing_event "x_root" int
  let xcrossing_y_root = field xcrossing_event "y_root" int
  let xcrossing_mode = field xcrossing_event "mode" notify_mode
  let xcrossing_detail = field xcrossing_event "detail" notify_detail
  let xcrossing_same_screen = field xcrossing_event "same_screen" int
  let xcrossing_focus = field xcrossing_event "focus" int
  let xcrossing_state = field xcrossing_event "state" uint
  let () = seal xcrossing_event

  type xmotion_event

  let xmotion_event : xmotion_event structure typ =
    typedef (structure "xmotion_anonymous") "XMotionEvent"

  let xmotion_type = field xmotion_event "type" event_type
  let xmotion_serial = field xmotion_event "serial" ulong
  let xmotion_send_event = field xmotion_event "send_event" int
  let xmotion_display = field xmotion_event "display" display
  let xmotion_window = field xmotion_event "window" window
  let xmotion_root = field xmotion_event "root" window
  let xmotion_subwindow = field xmotion_event "subwindow" window
  let xmotion_time = field xmotion_event "time" time
  let xmotion_x = field xmotion_event "x" int
  let xmotion_y = field xmotion_event "y" int
  let xmotion_x_root = field xmotion_event "x_root" int
  let xmotion_y_root = field xmotion_event "y_root" int
  let xmotion_state = field xmotion_event "state" uint
  let xmotion_is_hint = field xmotion_event "is_hint" char
  let xmotion_same_screen = field xmotion_event "same_screen" int
  let () = seal xmotion_event

  type xexpose_event

  let xexpose_event : xexpose_event structure typ =
    typedef (structure "xexpose_anonymous") "XExposeEvent"

  let xexpose_type = field xexpose_event "type" event_type
  let xexpose_serial = field xexpose_event "serial" ulong
  let xexpose_send_event = field xexpose_event "send_event" int
  let xexpose_display = field xexpose_event "display" display
  let xexpose_window = field xexpose_event "window" window
  let xexpose_x = field xexpose_event "x" int
  let xexpose_y = field xexpose_event "y" int
  let xexpose_width = field xexpose_event "width" int
  let xexpose_height = field xexpose_event "height" int
  let xexpose_count = field xexpose_event "count" int
  let () = seal xexpose_event

  type xdestroywindow_event

  let xdestroywindow_event : xdestroywindow_event structure typ =
    typedef (structure "xdestroywindow_anonymous") "XDestroyWindowEvent"

  let xdestroywindow_type = field xdestroywindow_event "type" event_type
  let xdestroywindow_serial = field xdestroywindow_event "serial" ulong
  let xdestroywindow_send_event = field xdestroywindow_event "send_event" int
  let xdestroywindow_display = field xdestroywindow_event "display" display
  let xdestroywindow_event_window = field xdestroywindow_event "event" window
  let xdestroywindow_window = field xdestroywindow_event "window" window
  let () = seal xdestroywindow_event

  type xunmap_event

  let xunmap_event : xunmap_event structure typ =
    typedef (structure "xunmap_anonymous") "XUnmapEvent"

  let xunmap_type = field xunmap_event "type" event_type
  let xunmap_serial = field xunmap_event "serial" ulong
  let xunmap_send_event = field xunmap_event "send_event" int
  let xunmap_display = field xunmap_event "display" display
  let xunmap_event_window = field xunmap_event "event" window
  let xunmap_window = field xunmap_event "window" window
  let xunmap_from_configure = field xunmap_event "from_configure" int
  let () = seal xunmap_event

  type xevent_union

  let xevent_union : xevent_union union typ = union "_XEvent"
  let xev_any = field xevent_union "xany" xany_event
  let xev_key = field xevent_union "xkey" xkey_event
  let xev_button = field xevent_union "xbutton" xbutton_event
  let xev_client = field xevent_union "xclient" xclient_event
  let xev_focus = field xevent_union "xfocus" xfocus_event
  let xev_crossing = field xevent_union "xcrossing" xcrossing_event
  let xev_motion = field xevent_union "xmotion" xmotion_event
  let xev_expose = field xevent_union "xexpose" xexpose_event

  let xev_destroywindow =
    field xevent_union "xdestroywindow" xdestroywindow_event

  let xev_unmap = field xevent_union "xunmap" xunmap_event
  let () = seal xevent_union
end
