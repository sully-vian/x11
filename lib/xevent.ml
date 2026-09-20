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

type xKeyEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window;
  time : time;
  x : int;
  y : int;
  x_root : int;
  y_root : int;
  state : int;
  keycode : int;
  same_screen : bool;
}

type xButtonEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window;
  time : time;
  x : int;
  y : int;
  x_root : int;
  y_root : int;
  state : int;
  button : int;
  same_screen : bool;
}

type xButtonPressedEvent = xButtonEvent
type xButtonReleasedEvent = xButtonEvent

type xMotionEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window;
  time : time;
  x : int;
  y : int;
  x_root : int;
  y_root : int;
  state : int;
  same_screen : bool;
}

type xPointerMovedEvent = xMotionEvent

type xCrossingEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window;
  time : time;
  x : int;
  y : int;
  x_root : int;
  y_root : int;
  mode : notifyMode;
  detail : notifyDetail;
}

type xEnterWindowEvent = xCrossingEvent
type xLeaveWindowEvent = xCrossingEvent

type xFocusChangeEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  mode : notifyMode;
  detail : notifyDetail;
}

type xFocusInEvent = xFocusChangeEvent
type xFocusOutEvent = xFocusChangeEvent

type xKeymapEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  key_vector : string;
}

type xExposeEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  x : int;
  y : int;
  width : int;
  height : int;
  count : int;
}

type xGraphicsExposeEvent = {
  serial : int;
  send_event : bool;
  display : display;
  drawable : drawable;
  x : int;
  y : int;
  count : int;
  major_code : int;
  minor_code : int;
}

type xNoExposeEvent = {
  serial : int;
  send_event : bool;
  display : display;
  drawable : drawable;
  major_code : int;
  minor_code : int;
}

type xVisibilityEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  state : int;
}

type xCreateWindowEvent = {
  serial : int;
  send_event : bool;
  display : display;
  parent : window;
  window : window;
  x : int;
  y : int;
  width : int;
  height : int;
  border_width : int;
  override_redirect : bool;
}

type xDestroyWindowEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
}

type xUnmapEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  from_configure : bool;
}

type xMapEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  override_redirect : bool;
}

type xMapRequestEvent = {
  serial : int;
  send_event : bool;
  display : display;
  parent : window;
  window : window;
}

type xReparentEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  parent : window;
  x : int;
  y : int;
  override_redirect : bool;
}

type xConfigureEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  x : int;
  y : int;
  width : int;
  height : int;
  border_width : int;
  above : window;
  override_redirect : bool;
}

type xGravityEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  x : int;
  y : int;
}

type xResizeRequestEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  width : int;
  height : int;
}

type xConfigureRequestEvent = {
  serial : int;
  send_event : bool;
  display : display;
  parent : window;
  window : window;
  x : int;
  y : int;
  width : int;
  height : int;
  border_width : int;
  above : window;
  detail : windowStackingMethod;
  value_mask : int;
}

type xCirculateEvent = {
  serial : int;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  place : circulationRequest;
}

type xCirculateRequestEvent = {
  serial : int;
  send_event : bool;
  display : display;
  parent : window;
  window : window;
  place : circulationRequest;
}

type xPropertyEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  atom : atom;
  time : time;
  state : propertyNotification;
}

type xSelectionClearEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  selection : atom;
  time : time;
}

type xSelectionRequestEvent = {
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

type xSelectionEvent = {
  serial : int;
  send_event : bool;
  display : display;
  requestor : window;
  selection : atom;
  target : atom;
  property : atom;
  time : time;
}

type xColormapEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  colormap : colormap;
  c_new : bool;
  state : colorMapNotification;
}

type xClientMessageEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  message_type : atom;
  data : message_data;
}

type xMappingEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
  request : int;
  first_keycode : int;
  count : int;
}

type xErrorEvent = {
  display : display;
  resourceid : xid;
  serial : int;
  error_code : int;
  request_code : int;
  minor_code : int;
}

type xAnyEvent = {
  serial : int;
  send_event : bool;
  display : display;
  window : window;
}

type xGenericEvent = {
  serial : int;
  send_event : bool;
  display : display;
  extension : int;
  evtype : int;
}

type xGenericEventCookie = {
  serial : int;
  send_event : bool;
  display : display;
  extension : int;
  evtype : int;
  cookie : int;
  data : string;
}

type xEvent =
  | XErrorEvent of xErrorEvent (* 0 *)
  | TODO of unit (* 1 *)
  | XKeyPress of xKeyEvent (* 2 *)
  | XKeyRelease of xKeyEvent (* 3 *)
  | XButtonPress of xButtonEvent (* 4 *)
  | XButtonRelease of xButtonEvent (* 5 *)
  | XMotionNotify of xMotionEvent (* 6 *)
  | XEnterNotify of xCrossingEvent (* 7 *)
  | XLeaveNotify of xCrossingEvent (* 8 *)
  | XFocusIn of xFocusChangeEvent (* 9 *)
  | XFocusOut of xFocusChangeEvent (* 10 *)
  | XKeymapNotify of xKeymapEvent (* 11 *)
  | XExpose of xExposeEvent (* 12 *)
  | XGraphicsExpose of xGraphicsExposeEvent (* 13 *)
  | XNoExpose of xNoExposeEvent (* 14 *)
  | XVisibilityNotify of xVisibilityEvent (* 15 *)
  | XCreateWindow of xCreateWindowEvent (* 16 *)
  | XDestroyWindow of xDestroyWindowEvent (* 17 *)
  | XUnmap of xUnmapEvent (* 18 *)
  | XMap of xMapEvent (* 19 *)
  | XMapRequest of xMapRequestEvent (* 20 *)
  | XReparent of xReparentEvent (* 21 *)
  | XConfigureNotify of xConfigureEvent (* 22 *)
  | XConfigureRequest of xConfigureRequestEvent (* 23 *)
  | XGravityNotify of xGravityEvent (* 24 *)
  | XResizeRequest of xResizeRequestEvent (* 25 *)
  | XCirculate of xCirculateEvent (* 26 *)
  | XCirculateRequest of xCirculateRequestEvent (* 27 *)
  | XProperty of xPropertyEvent (* 28 *)
  | XSelectionClear of xSelectionClearEvent (* 29 *)
  | XSelectionRequest of xSelectionRequestEvent (* 30 *)
  | XSelection of xSelectionEvent (* 31 *)
  | XColormap of xColormapEvent (* 32 *)
  | XClientMessage of xClientMessageEvent (* 33 *)
  | XMapping of xMappingEvent (* 34 *)
  | XGeneric of xGenericEvent (* 35 *)
  | XGenericCookie of xGenericEventCookie (* 36 *)
