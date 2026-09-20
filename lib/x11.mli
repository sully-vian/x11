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
  | XErrorEvent of xErrorEvent
  | TODO of unit
  | XKeyPress of xKeyEvent
  | XKeyRelease of xKeyEvent
  | XButtonPress of xButtonEvent
  | XButtonRelease of xButtonEvent
  | XMotionNotify of xMotionEvent
  | XEnterNotify of xCrossingEvent
  | XLeaveNotify of xCrossingEvent
  | XFocusIn of xFocusChangeEvent
  | XFocusOut of xFocusChangeEvent
  | XKeymapNotify of xKeymapEvent
  | XExpose of xExposeEvent
  | XGraphicsExpose of xGraphicsExposeEvent
  | XNoExpose of xNoExposeEvent
  | XVisibilityNotify of xVisibilityEvent
  | XCreateWindow of xCreateWindowEvent
  | XDestroyWindow of xDestroyWindowEvent
  | XUnmap of xUnmapEvent
  | XMap of xMapEvent
  | XMapRequest of xMapRequestEvent
  | XReparent of xReparentEvent
  | XConfigureNotify of xConfigureEvent
  | XConfigureRequest of xConfigureRequestEvent
  | XGravityNotify of xGravityEvent
  | XResizeRequest of xResizeRequestEvent
  | XCirculate of xCirculateEvent
  | XCirculateRequest of xCirculateRequestEvent
  | XProperty of xPropertyEvent
  | XSelectionClear of xSelectionClearEvent
  | XSelectionRequest of xSelectionRequestEvent
  | XSelection of xSelectionEvent
  | XColormap of xColormapEvent
  | XClientMessage of xClientMessageEvent
  | XMapping of xMappingEvent
  | XGeneric of xGenericEvent
  | XGenericCookie of xGenericEventCookie

val open_display : string option -> display option
val close_display : display -> unit
