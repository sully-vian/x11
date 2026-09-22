open C.Functions

type xid
type time
type atom
type colormap
type drawable
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
  | ErrorEvent of errorEvent (* 0 *)
  | TODO of unit (* 1 *)
  | KeyPress of keyEvent (* 2 *)
  | KeyRelease of keyEvent (* 3 *)
  | ButtonPress of buttonEvent (* 4 *)
  | ButtonRelease of buttonEvent (* 5 *)
  | MotionNotify of motionEvent (* 6 *)
  | EnterNotify of crossingEvent (* 7 *)
  | LeaveNotify of crossingEvent (* 8 *)
  | FocusIn of focusChangeEvent (* 9 *)
  | FocusOut of focusChangeEvent (* 10 *)
  | KeymapNotify of keymapEvent (* 11 *)
  | Expose of exposeEvent (* 12 *)
  | GraphicsExpose of graphicsExposeEvent (* 13 *)
  | NoExpose of noExposeEvent (* 14 *)
  | VisibilityNotify of visibilityEvent (* 15 *)
  | CreateWindow of createWindowEvent (* 16 *)
  | DestroyWindow of destroyWindowEvent (* 17 *)
  | Unmap of unmapEvent (* 18 *)
  | Map of mapEvent (* 19 *)
  | MapRequest of mapRequestEvent (* 20 *)
  | Reparent of reparentEvent (* 21 *)
  | ConfigureNotify of configureEvent (* 22 *)
  | ConfigureRequest of configureRequestEvent (* 23 *)
  | GravityNotify of gravityEvent (* 24 *)
  | ResizeRequest of resizeRequestEvent (* 25 *)
  | Circulate of circulateEvent (* 26 *)
  | CirculateRequest of circulateRequestEvent (* 27 *)
  | Property of propertyEvent (* 28 *)
  | SelectionClear of selectionClearEvent (* 29 *)
  | SelectionRequest of selectionRequestEvent (* 30 *)
  | Selection of selectionEvent (* 31 *)
  | Colormap of colormapEvent (* 32 *)
  | ClientMessage of clientMessageEvent (* 33 *)
  | Mapping of mappingEvent (* 34 *)
  | Generic of genericEvent (* 35 *)
  | GenericCookie of genericEventCookie (* 36 *)
