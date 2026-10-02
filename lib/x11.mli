type cursor
type keycode
(** {{:https://tronche.com/gui/x/iccccm/sec-4.html#4.2.1} XKeycode} *)
type display
type window
type time
type drawable
type atom
type colormap
type xid
type circulationRequest = PlaceOnTop | PlaceOnBottom
type propertyNotification = PropertyNewValue | PropertyDelete
type colorMapNotification = ColormapUninstalled | ColormapInstalled
type windowStackingMethod = Above | Below | TopIf | BottomIf | Opposite

(** {1 Keycodes} *)

type keysym
(** {{:https://tronche.com/gui/x/xlib/input/keyboard-encoding.html#KeySym}
     KeySym} *)

val xk_BackSpace : keysym
val xk_Tab : keysym
val xk_Linefeed : keysym
val xk_Clear : keysym
val xk_Return : keysym
val xk_Pause : keysym
val xk_Scroll_Lock : keysym
val xk_Sys_Req : keysym
val xk_Escape : keysym
val xk_Delete : keysym
val xk_space : keysym
val xk_exclam : keysym
val xk_quotedbl : keysym
val xk_numbersign : keysym
val xk_dollar : keysym
val xk_percent : keysym
val xk_ampersand : keysym
val xk_apostrophe : keysym
val xk_quoteright : keysym
val xk_parenleft : keysym
val xk_parenright : keysym
val xk_asterisk : keysym
val xk_plus : keysym
val xk_comma : keysym
val xk_minus : keysym
val xk_period : keysym
val xk_slash : keysym
val xk_0 : keysym
val xk_1 : keysym
val xk_2 : keysym
val xk_3 : keysym
val xk_4 : keysym
val xk_5 : keysym
val xk_6 : keysym
val xk_7 : keysym
val xk_8 : keysym
val xk_9 : keysym
val xk_colon : keysym
val xk_semicolon : keysym
val xk_less : keysym
val xk_equal : keysym
val xk_greater : keysym
val xk_question : keysym
val xk_A : keysym
val xk_B : keysym
val xk_C : keysym
val xk_D : keysym
val xk_E : keysym
val xk_F : keysym
val xk_G : keysym
val xk_H : keysym
val xk_I : keysym
val xk_J : keysym
val xk_K : keysym
val xk_L : keysym
val xk_M : keysym
val xk_N : keysym
val xk_O : keysym
val xk_P : keysym
val xk_Q : keysym
val xk_R : keysym
val xk_S : keysym
val xk_T : keysym
val xk_U : keysym
val xk_V : keysym
val xk_W : keysym
val xk_X : keysym
val xk_Y : keysym
val xk_Z : keysym
val xk_bracketleft : keysym
val xk_backslash : keysym
val xk_bracketright : keysym
val xk_asciicircum : keysym
val xk_underscore : keysym
val xk_grave : keysym
val xk_quoteleft : keysym
val xk_a : keysym
val xk_b : keysym
val xk_c : keysym
val xk_d : keysym
val xk_e : keysym
val xk_f : keysym
val xk_g : keysym
val xk_h : keysym
val xk_i : keysym
val xk_j : keysym
val xk_k : keysym
val xk_l : keysym
val xk_m : keysym
val xk_n : keysym
val xk_o : keysym
val xk_p : keysym
val xk_q : keysym
val xk_r : keysym
val xk_s : keysym
val xk_t : keysym
val xk_u : keysym
val xk_v : keysym
val xk_w : keysym
val xk_x : keysym
val xk_y : keysym
val xk_z : keysym
val xk_braceleft : keysym
val xk_bar : keysym
val xk_braceright : keysym
val xk_asciitilde : keysym

(** {1 Masks and Modifiers} *)

type 'a mask

val ( ||| ) : 'a mask -> 'a mask -> 'a mask

(** {2 Event Masks} *)

type event_tag
type eventMask = event_tag mask

val noEventMask : eventMask
val keyPressMask : eventMask
val keyReleaseMask : eventMask
val buttonPressMask : eventMask
val buttonReleaseMask : eventMask
val enterWindowMask : eventMask
val leaveWindowMask : eventMask
val pointerMotionMask : eventMask
val pointerMotionHintMask : eventMask
val button1MotionMask : eventMask
val button2MotionMask : eventMask
val button3MotionMask : eventMask
val button4MotionMask : eventMask
val button5MotionMask : eventMask
val buttonMotionMask : eventMask
val keymapStateMask : eventMask
val exposureMask : eventMask
val visibilityChangeMask : eventMask
val structureNotifyMask : eventMask
val resizeRedirectMask : eventMask
val substructureNotifyMask : eventMask
val substructureRedirectMask : eventMask
val focusChangeMask : eventMask
val propertyChangeMask : eventMask
val colormapChangeMask : eventMask
val ownerGrabButtonMask : eventMask

(** {2 Key Masks} *)

type key_tag
type keyMask = key_tag mask

val shiftMask : keyMask
val lockMask : keyMask
val controlMask : keyMask
val mod1Mask : keyMask
val mod2Mask : keyMask
val mod3Mask : keyMask
val mod4Mask : keyMask
val mod5Mask : keyMask

type grabMode

val grabModeSync : grabMode
val grabModeAsync : grabMode

type button

val anyButton : button
val button1 : button
val button2 : button
val button3 : button
val button4 : button
val button5 : button

type windowClass

val copyFromParent : windowClass
val inputOutput : windowClass
val inputOnly : windowClass

(** {1 Event Data Structures} *)

type message_data =
  | Bytes of char array
  | Shorts of int array
  | Longs of int array

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

type keyEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window;
  time : time;
  pos : int * int;
  root_pos : int * int;
  state : int;
  keycode : keycode;
  same_screen : bool;
}
(** {{:https://man.archlinux.org/man/XKeyEvent.3.en} XKeyEvent} *)

type buttonEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window;
  time : time;
  pos : int * int;
  root_pos : int * int;
  state : int;
  button : button;
  same_screen : bool;
}
(** {{:https://man.archlinux.org/man/XButtonEvent.3.en} XButtonEvent} *)

type buttonPressedEvent = buttonEvent
(** {{:https://man.archlinux.org/man/XButtonEvent.3.en} XButtonPressedEvent} *)

type buttonReleasedEvent = buttonEvent
(** {{:https://man.archlinux.org/man/XButtonEvent.3.en} XButtonReleasedEvent} *)

type motionEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window;
  time : time;
  pos : int * int;
  root_pos : int * int;
  state : int;
  same_screen : bool;
}
(** {{:https://man.archlinux.org/man/XMotionEvent.3.en} XMotionEvent} *)

type pointerMovedEvent = motionEvent

type crossingEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window;
  time : time;
  pos : int * int;
  root_pos : int * int;
  mode : notifyMode;
  detail : notifyDetail;
}
(** {{:https://man.archlinux.org/man/XCrossingEvent.3.en} XCrossingEvent} *)

type enterWindowEvent = crossingEvent
type leaveWindowEvent = crossingEvent

type focusChangeEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  mode : notifyMode;
  detail : notifyDetail;
}
(** {{:https://man.archlinux.org/man/XFocusChangeEvent.3.en} XFocusChangeEvent}
*)

type focusInEvent = focusChangeEvent
type focusOutEvent = focusChangeEvent

type keymapEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  key_vector : string;
}
(** {{:https://man.archlinux.org/man/XKeymapEvent.3.en} XKeymapEvent} *)

type exposeEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  pos : int * int;
  size : int * int;
  count : int;
}
(** {{:https://man.archlinux.org/man/XExposeEvent.3.en} XExposeEvent} *)

type graphicsExposeEvent = {
  serial : int;
  send_event : bool;
  display : display;
  drawable : drawable;
  pos : int * int;
  count : int;
  codes : int * int;
}
(** {{:https://man.archlinux.org/man/XGraphicsExposeEvent.3.en}
     XGraphicsExposeEvent} *)

type noExposeEvent = {
  serial : int;
  send_event : bool;
  display : display;
  drawable : drawable;
  codes : int * int;
}
(** {{:https://man.archlinux.org/man/XNoExposeEvent.3.en} XNoExposeEvent} *)

type visibilityEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  state : int;
}
(** {{:https://man.archlinux.org/man/XVisibilityEvent.3.en} XVisibilityEvent} *)

type createWindowEvent = {
  serial : int;
  send_event : bool;
  display : display;
  parent : window;
  window : window;
  pos : int * int;
  size : int * int;
  border_width : int;
  override_redirect : bool;
}
(** {{:https://man.archlinux.org/man/XCreateWindowEvent.3.en}
     XCreateWindowEvent} *)

type destroyWindowEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
}
(** {{:https://man.archlinux.org/man/XDestroyWindowEvent.3.en}
     XDestroyWindowEvent} *)

type unmapEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  from_configure : bool;
}
(** {{:https://man.archlinux.org/man/XUnmapEvent.3.en} XUnmapEvent} *)

type mapEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  override_redirect : bool;
}
(** {{:https://man.archlinux.org/man/XMapEvent.3.en} XMapEvent} *)

type mapRequestEvent = {
  serial : int;
  send_event : bool;
  display : display;
  parent : window;
  window : window;
}
(** {{:https://man.archlinux.org/man/XMapRequestEvent.3.en} XMapRequestEvent} *)

type reparentEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  parent : window;
  pos : int * int;
  override_redirect : bool;
}

type configureEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  pos : int * int;
  size : int * int;
  border_width : int;
  above : window;
  override_redirect : bool;
}

type gravityEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  pos : int * int;
}

type resizeRequestEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  size : int * int;
}

type configureRequestEvent = {
  serial : int;
  send_event : bool;
  display : display;
  parent : window;
  window : window;
  pos : int * int;
  size : int * int;
  border_width : int;
  above : window;
  detail : windowStackingMethod;
  value_mask : int;
}

type circulateEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  place : circulationRequest;
}

type circulateRequestEvent = {
  serial : int;
  send_event : bool;
  display : display;
  parent : window;
  window : window;
  place : circulationRequest;
}

type propertyEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  atom : atom;
  time : time;
  state : propertyNotification;
}

type selectionClearEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  selection : atom;
  time : time;
}

type selectionRequestEvent = {
  serial : int;
  send_event : bool;
  display : display;
  owner : window;
  requestor : window;
  selection : atom;
  target : atom;
  property : atom;
  time : time;
}

type selectionEvent = {
  serial : int;
  send_event : bool;
  display : display;
  requestor : window;
  selection : atom;
  target : atom;
  property : atom;
  time : time;
}

type colormapEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  colormap : colormap;
  c_new : bool;
  state : colorMapNotification;
}

type clientMessageEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  message_type : atom;
  data : message_data;
}

type mappingEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  request : int;
  first_keycode : int;
  count : int;
}

type errorEvent = {
  display : display;
  resourceid : xid;
  serial : int;
  codes : int * int * int;
}

type anyEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
}

type genericEvent = {
  serial : int;
  send_event : bool;
  display : display;
  extension : int;
  evtype : int;
}

type genericEventCookie = {
  serial : int;
  send_event : bool;
  display : display;
  extension : int;
  evtype : int;
  cookie : int;
  data : string;
}

(** {1 The XEvent Type} *)

type xEvent =
  | ErrorEvent of errorEvent
  | TODO of unit
  | KeyPress of keyEvent
  | KeyRelease of keyEvent
  | ButtonPress of buttonEvent
  | ButtonRelease of buttonEvent
  | MotionNotify of motionEvent
  | EnterNotify of crossingEvent
  | LeaveNotify of crossingEvent
  | FocusIn of focusChangeEvent
  | FocusOut of focusChangeEvent
  | KeymapNotify of keymapEvent
  | Expose of exposeEvent
  | GraphicsExpose of graphicsExposeEvent
  | NoExpose of noExposeEvent
  | VisibilityNotify of visibilityEvent
  | CreateWindow of createWindowEvent
  | DestroyWindow of destroyWindowEvent
  | Unmap of unmapEvent
  | Map of mapEvent
  | MapRequest of mapRequestEvent
  | Reparent of reparentEvent
  | ConfigureNotify of configureEvent
  | ConfigureRequest of configureRequestEvent
  | GravityNotify of gravityEvent
  | ResizeRequest of resizeRequestEvent
  | Circulate of circulateEvent
  | CirculateRequest of circulateRequestEvent
  | Property of propertyEvent
  | SelectionClear of selectionClearEvent
  | SelectionRequest of selectionRequestEvent
  | Selection of selectionEvent
  | Colormap of colormapEvent
  | ClientMessage of clientMessageEvent
  | Mapping of mappingEvent
  | Generic of genericEvent
  | GenericCookie of genericEventCookie

(** {1 Core Functions} *)

val open_display : string option -> display option
(** {{:https://man.archlinux.org/man/XOpenDisplay.3.en} XOpenDisplay} *)

val close_display : display -> unit
(** {{:https://man.archlinux.org/man/XCloseDisplay.3.en} XCloseDisplay} *)

val flush : display -> unit
(** {{:https://man.archlinux.org/man/XFlush.3.en} XFlush} *)

val clear_window : display -> window -> unit
(** {{:https://man.archlinux.org/man/XClearWindow.3.en} XClearWindow} *)

val set_window_background : display -> window -> int -> unit
(** {{:https://man.archlinux.org/man/XSetWindowBackground.3.en}
     XSetWindowBackground} *)

val map_window : display -> window -> unit
(** {{:https://man.archlinux.org/man/XMapWindow.3.en} XMapWindow} *)

val create_simple_window :
  display -> window -> int * int -> int * int -> int -> int -> int -> window
(** {{:https://man.archlinux.org/man/XCreateWindow.3.en} XCreateSimpleWindow} *)

val move_resize_window : display -> window -> int * int -> int * int -> unit
(** {{:https://man.archlinux.org/man/XMoveResizeWindow.3.en} XMoveResizeWindow}
*)

val default_root_window : display -> window
(** {{:https://man.archlinux.org/man/XDefaultRootWindow.3.en}
     XDefaultRootWindow} *)

val raise_window : display -> window -> unit
(** {{:https://man.archlinux.org/man/XRaiseWindow.3.en} XRaiseWindow} *)

val select_input : display -> window -> eventMask -> unit
(** {{:https://man.archlinux.org/man/XSelectInput.3.en} XSelectInput} *)

val keysym_to_keycode : display -> keysym -> keycode
(** {{:https://man.archlinux.org/man/XKeysymToKeycode.3.en} XKeysymToKeycode} *)

val grab_button :
  display ->
  button ->
  keyMask ->
  window ->
  bool ->
  eventMask ->
  grabMode ->
  grabMode ->
  window option ->
  cursor option ->
  unit
(** {{:https://man.archlinux.org/man/XGrabButton.3.en} XGrabButton} *)

val grab_key :
  display ->
  keycode ->
  keyMask ->
  window ->
  bool ->
  grabMode ->
  grabMode ->
  unit
(** {{:https://man.archlinux.org/man/XGrabKey.3.en} XGrabKey} *)

val next_event : display -> xEvent
(** {{:https://man.archlinux.org/man/XNextEvent.3.en} XNextEvent} *)

type visual
type screen

type windowAttributes = {
  pos : int * int;
  size : int * int;
  border_width : int;
  depth : int;
  visual : visual;
  root : window;
  c_class : windowClass;
  bit_gravity : int;
  win_gravity : int;
  backing_store : int;
  backing_planes : int;
  backing_pixel : int;
  save_under : bool;
  colormap : colormap;
  map_installed : bool;
  map_state : int;
  all_event_masks : eventMask;
  your_event_mask : eventMask;
  do_not_propagate_mask : int;
  override_redirect : bool;
  screen : screen;
}

val get_window_attributes : display -> window -> windowAttributes
