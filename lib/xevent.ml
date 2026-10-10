open C.Types
open Type_description

type xid
type colormap
type drawable
type circulationRequest = PlaceOnTop | PlaceOnBottom
type propertyNotification = PropertyNewValue | PropertyDelete
type colorMapNotification = ColormapUninstalled | ColormapInstalled
type windowStackingMethod = Above | Below | TopIf | BottomIf | Opposite

type message_data =
  | Bytes of char array
  | Shorts of int array
  | Longs of Signed.long array

include Enums

type keyEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window;
  time : time;
  pos : int * int;
  pos_root : int * int;
  state : int;
  keycode : keycode;
  same_screen : bool;
}

type buttonEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window;
  time : time;
  pos : int * int;
  pos_root : int * int;
  state : int;
  button : button;
  same_screen : bool;
}

type buttonPressedEvent = buttonEvent
type buttonReleasedEvent = buttonEvent

type motionEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window;
  time : time;
  pos : int * int;
  pos_root : int * int;
  state : int;
  same_screen : bool;
}

type pointerMovedEvent = motionEvent

type crossingEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window;
  time : time;
  pos : int * int;
  pos_root : int * int;
  mode : notifyMode;
  detail : notifyDetail;
}

type enterWindowEvent = crossingEvent
type leaveWindowEvent = crossingEvent

type focusChangeEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  mode : notifyMode;
  detail : notifyDetail;
}

type focusInEvent = focusChangeEvent
type focusOutEvent = focusChangeEvent

type keymapEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  key_vector : string;
}

type exposeEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  pos : int * int;
  size : int * int;
  count : int;
}

type graphicsExposeEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  drawable : drawable;
  pos : int * int;
  count : int;
  codes : int * int;
}

type noExposeEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  drawable : drawable;
  codes : int * int;
}

type visibilityEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  state : int;
}

type createWindowEvent = {
  serial : Unsigned.ulong;
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
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  event : window;
  window : window;
}

type unmapEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  from_configure : bool;
}

type mapEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  override_redirect : bool;
}

type mapRequestEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  parent : window;
  window : window;
}

type reparentEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  parent : window;
  pos : int * int;
  override_redirect : bool;
}

type configureEvent = {
  serial : Unsigned.ulong;
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
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  pos : int * int;
}

type resizeRequestEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  size : int * int;
}

type configureRequestEvent = {
  serial : Unsigned.ulong;
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
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  place : circulationRequest;
}

type circulateRequestEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  parent : window;
  window : window;
  place : circulationRequest;
}

type propertyEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  atom : atom;
  time : time;
  state : propertyNotification;
}

type selectionClearEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  selection : atom;
  time : time;
}

type selectionRequestEvent = {
  serial : Unsigned.ulong;
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
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  requestor : window;
  selection : atom;
  target : atom;
  property : atom;
  time : time;
}

type colormapEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  colormap : colormap;
  c_new : bool;
  state : colorMapNotification;
}

type clientMessageEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  message_type : atom;
  data : message_data;
}

type mappingEvent = {
  serial : Unsigned.ulong;
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
  serial : Unsigned.ulong;
  codes : int * int * int;
}

type anyEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
}

type genericEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  extension : int;
  evtype : int;
}

type genericEventCookie = {
  serial : Unsigned.ulong;
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
