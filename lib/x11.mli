type cursor
type keysym
type keycode
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
  keycode : int;
  same_screen : bool;
}

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
  button : int;
  same_screen : bool;
}

type buttonPressedEvent = buttonEvent
type buttonReleasedEvent = buttonEvent

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

type focusInEvent = focusChangeEvent
type focusOutEvent = focusChangeEvent

type keymapEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  key_vector : string;
}

type exposeEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  pos : int * int;
  size : int * int;
  count : int;
}

type graphicsExposeEvent = {
  serial : int;
  send_event : bool;
  display : display;
  drawable : drawable;
  pos : int * int;
  count : int;
  codes : int * int;
}

type noExposeEvent = {
  serial : int;
  send_event : bool;
  display : display;
  drawable : drawable;
  codes : int * int;
}

type visibilityEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  state : int;
}

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

type destroyWindowEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
}

type unmapEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  from_configure : bool;
}

type mapEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  override_redirect : bool;
}

type mapRequestEvent = {
  serial : int;
  send_event : bool;
  display : display;
  parent : window;
  window : window;
}

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

type 'a mask

val ( ||| ) : 'a mask -> 'a mask -> 'a mask

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
val open_display : string option -> display option
val close_display : display -> unit
val flush : display -> unit
val move_resize_window : display -> window -> int * int -> int * int -> unit
val default_root_window : display -> window
val raise_window : display -> window -> unit
val select_input : display -> window -> eventMask -> unit
val keysym_to_keycode : display -> keysym -> keycode

val grab_button :
  display ->
  button ->
  keyMask ->
  window ->
  bool ->
  eventMask ->
  grabMode ->
  grabMode ->
  window ->
  cursor ->
  unit

val grab_key :
  display ->
  keycode ->
  keyMask ->
  window ->
  bool ->
  grabMode ->
  grabMode ->
  unit

val next_event : display -> xEvent

type visual
type screen

type windowAttributes = {
  pos : int * int;
  size : int * int;
  border_width : int;
  depth : int;
  visual : visual;
  root : window;
  c_class : int;
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
