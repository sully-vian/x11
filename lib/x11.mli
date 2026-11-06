type keycode
(** {{:https://tronche.com/gui/x/xlib/input/keyboard-encoding.html} KeyCode} *)

type display
type 'a xid
type window = [ `Window ] xid
type cursor = [ `Cursor ] xid
type time

val currentTime : time
(** Stands for the server's current time in requests that take a timestamp, such
    as XSetInputFocus. It is never a real time, so events never carry it *)

type drawable = [ `Window | `Pixmap ] xid
(** A window or a pixmap, as X.h's Drawable *)

type atom
type colormap = [ `Colormap ] xid
type circulationRequest = PlaceOnTop | PlaceOnBottom
type propertyNotification = PropertyNewValue | PropertyDelete
type colorMapNotification = ColormapUninstalled | ColormapInstalled
type windowStackingMethod = Above | Below | TopIf | BottomIf | Opposite

(** {1 Keysyms} *)

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

type (+'a, +'c) mask
(** A set of X flags.

    ['a] lists the kinds of flags it may hold: a constant such as
    [shiftMask : ([> `Key ], 'c) mask] fits any field that allows [`Key] flags,
    and nothing else.

    The X protocol gives each mask field its own set type, listing the bits
    valid there: grab modifiers are a [SETofKEYMASK] or [AnyModifier], an event
    state a [SETofKEYBUTMASK]. These sets overlap, so a flag is often valid in
    several fields. A tag stands for a group of flags the protocol always allows
    or refuses together, a field lists the tags it accepts, and the open type of
    a constant lets it fit every one of them. Using a flag where X would answer
    [BadValue] is then a type error.

    ['c] says whether the mask can be or-ed. Only {!anyModifier} can't, since X
    only accepts it alone. A constant fits either, so that a list can hold
    {!anyModifier} next to sets of modifiers. *)

type union
(** ['c] of the masks known not to be {!anyModifier} *)

type alone
(** ['c] of the masks that may be {!anyModifier} *)

val ( ||| ) : ('a, union) mask -> ('a, union) mask -> ('a, 'c) mask
(** Union, like C's [|]. {!anyModifier} can't be an operand: X answers
    [AnyModifier | ShiftMask] with [BadValue]. *)

val ( &&& ) : ('a, 'c) mask -> ('a, 'd) mask -> bool
(** [m &&& flags] is [true] when [m] holds at least one of [flags], like C's
    [m & flags]: [ev.state &&& controlMask] tests whether Control was held *)

val ( &~ ) : ('a, 'c) mask -> ('a, 'd) mask -> ('a, 'c) mask
(** [m &~ flags] is [m] without [flags], like C's [m & ~flags].

    There is no complement on its own. [~m] flips every bit of the integer, so
    it would also set the flags of kinds ['a] excludes (the [`Button] flags in a
    modifier mask) and bits no X mask defines: X would answer [BadValue].
    Keeping only the bits valid for the mask isn't possible either, since the
    tags only exist at compile time. Removing flags can't produce an invalid
    mask, and it is what C uses [~] for. *)

val ( &. ) :
  ([< `Key | `Button ], 'c) mask -> ([< `Key ], 'd) mask -> ([> `Key ], 'd) mask
(** [m &. modifiers] is the [modifiers] that [m] holds, like C's [m & modifiers].
    The result has no buttons or XKB group, so it fits a grab: it's how an
    event's state becomes one, as in
    [grab_key dpy kc (ev.state &. (mod4Mask ||| shiftMask)) w ...]. It only holds
    bits of [modifiers], so it may be {!anyModifier} only if they may. *)

(** {2 Event Masks} *)

(* Each tag is named after the protocol sets its flags belong to, besides
   SETofEVENT which holds them all *)

type eventFlags =
  [ `Event | `PointerEvent | `DeviceEvent | `PointerDeviceEvent ]

type pointerEventFlags = [ `PointerEvent | `PointerDeviceEvent ]
type deviceEventFlags = [ `DeviceEvent | `PointerDeviceEvent ]

type 'a eventMask = (([> eventFlags ] as 'a), union) mask
(** The events a client selects: [SETofEVENT]. Annotate a value with
    [_ eventMask]: its row stays open, so it can still take other flags. Likewise
    for the next two types. *)

type 'a pointerEventMask = (([> pointerEventFlags ] as 'a), union) mask
(** The events a pointer grab reports: [SETofPOINTEREVENT] *)

type 'a deviceEventMask = (([> deviceEventFlags ] as 'a), union) mask
(** The events a window can keep from propagating: [SETofDEVICEEVENT] *)

val noEventMask : ([< eventFlags ], 'c) mask
(** The empty set, which fits every event mask type *)

val keyPressMask : ([> `DeviceEvent ], 'c) mask
val keyReleaseMask : ([> `DeviceEvent ], 'c) mask
val buttonPressMask : ([> `PointerDeviceEvent ], 'c) mask
val buttonReleaseMask : ([> `PointerDeviceEvent ], 'c) mask
val enterWindowMask : ([> `PointerEvent ], 'c) mask
val leaveWindowMask : ([> `PointerEvent ], 'c) mask
val pointerMotionMask : ([> `PointerDeviceEvent ], 'c) mask
val pointerMotionHintMask : ([> `PointerEvent ], 'c) mask
val button1MotionMask : ([> `PointerDeviceEvent ], 'c) mask
val button2MotionMask : ([> `PointerDeviceEvent ], 'c) mask
val button3MotionMask : ([> `PointerDeviceEvent ], 'c) mask
val button4MotionMask : ([> `PointerDeviceEvent ], 'c) mask
val button5MotionMask : ([> `PointerDeviceEvent ], 'c) mask
val buttonMotionMask : ([> `PointerDeviceEvent ], 'c) mask
val keymapStateMask : ([> `PointerEvent ], 'c) mask
val exposureMask : ([> `Event ], 'c) mask
val visibilityChangeMask : ([> `Event ], 'c) mask
val structureNotifyMask : ([> `Event ], 'c) mask
val resizeRedirectMask : ([> `Event ], 'c) mask
val substructureNotifyMask : ([> `Event ], 'c) mask
val substructureRedirectMask : ([> `Event ], 'c) mask
val focusChangeMask : ([> `Event ], 'c) mask
val propertyChangeMask : ([> `Event ], 'c) mask
val colormapChangeMask : ([> `Event ], 'c) mask
val ownerGrabButtonMask : ([> `Event ], 'c) mask

(** {2 Key and Button Masks} *)

type 'p keyMask = ('a, 'c) mask constraint 'p = ([> `Key ] as 'a) * 'c
(** The modifiers of a key or button grab: [SETofKEYMASK or AnyModifier].
    Annotate a value with [_ keyMask]: ['p] holds an open row and ['c], and both
    follow the value.

    A type declaration refuses [_], so [{ m : _ keyMask }] doesn't compile. A
    field takes {!bindingMask}, or [([ `Key ] * alone) keyMask] if it may hold
    {!anyModifier}, or a parameter of the record. *)

type bindingMask = ([ `Key ], union) mask
(** The modifiers of a table of shortcuts without {!anyModifier}: a field of this
    type can be or-ed, as [k.m ||| lockMask], and grabbed. *)

type stateMask = ([ `Key | `Button ], union) mask
(** The modifiers and pointer buttons held during an input event:
    [SETofKEYBUTMASK], and the XKB group *)

val noModifier : ([> `Key ], 'c) mask
(** No modifier: C writes [0] *)

val shiftMask : ([> `Key ], 'c) mask
val lockMask : ([> `Key ], 'c) mask
val controlMask : ([> `Key ], 'c) mask
val mod1Mask : ([> `Key ], 'c) mask
val mod2Mask : ([> `Key ], 'c) mask
val mod3Mask : ([> `Key ], 'c) mask
val mod4Mask : ([> `Key ], 'c) mask
val mod5Mask : ([> `Key ], 'c) mask
val button1Mask : ([> `Button ], 'c) mask
val button2Mask : ([> `Button ], 'c) mask
val button3Mask : ([> `Button ], 'c) mask
val button4Mask : ([> `Button ], 'c) mask
val button5Mask : ([> `Button ], 'c) mask

val anyModifier : ([> `Key ], alone) mask
(** Any combination of modifiers, including none: grabs only, and alone *)

type grabMode = GrabModeSync | GrabModeAsync
type button

val anyButton : button
val button1 : button
val button2 : button
val button3 : button
val button4 : button
val button5 : button

type windowClass = CopyFromParent | InputOutput | InputOnly
type mapState = IsUnmapped | IsUnviewable | IsViewable
type backingStore = NotUseful | WhenMapped | Always

(** Bit and window gravity. [ForgetGravity] only occurs as a bit gravity and
    [UnmapGravity] only as a window gravity: X uses 0 for both. *)
type gravity =
  | ForgetGravity
  | UnmapGravity
  | NorthWestGravity
  | NorthGravity
  | NorthEastGravity
  | WestGravity
  | CenterGravity
  | EastGravity
  | SouthWestGravity
  | SouthGravity
  | SouthEastGravity
  | StaticGravity

(** {1 Event Data Structures} *)

type message_data =
  | Bytes of char array
  | Shorts of int array
  | Longs of Signed.long array

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
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window option;
      (** Child of [window] that contains the pointer, [None] when the pointer
          is in [window] itself *)
  time : time;
  pos : int * int;
  pos_root : int * int;
  state : stateMask;
  keycode : keycode;
  same_screen : bool;
}
(** {{:https://man.archlinux.org/man/XKeyEvent.3} XKeyEvent} *)

type buttonEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window option;
      (** Child of [window] that contains the pointer, [None] when the pointer
          is in [window] itself *)
  time : time;
  pos : int * int;
  pos_root : int * int;
  state : stateMask;
  button : button;
  same_screen : bool;
}
(** {{:https://man.archlinux.org/man/XButtonEvent.3} XButtonEvent} *)

type buttonPressedEvent = buttonEvent
(** {{:https://man.archlinux.org/man/XButtonEvent.3} XButtonPressedEvent} *)

type buttonReleasedEvent = buttonEvent
(** {{:https://man.archlinux.org/man/XButtonEvent.3} XButtonReleasedEvent} *)

type motionEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window option;
      (** Child of [window] that contains the pointer, [None] when the pointer
          is in [window] itself *)
  time : time;
  pos : int * int;
  pos_root : int * int;
  state : stateMask;
  is_hint : bool;
  same_screen : bool;
}
(** {{:https://man.archlinux.org/man/XMotionEvent.3} XMotionEvent} *)

type pointerMovedEvent = motionEvent

type crossingEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  root : window;
  subwindow : window option;
      (** Child of [window] that contains the pointer, [None] when the pointer
          is in [window] itself *)
  time : time;
  pos : int * int;
  pos_root : int * int;
  mode : notifyMode;
  detail : notifyDetail;
  same_screen : bool;
  focus : bool;
  state : stateMask;
}
(** {{:https://man.archlinux.org/man/XCrossingEvent.3} XCrossingEvent} *)

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
(** {{:https://man.archlinux.org/man/XFocusChangeEvent.3} XFocusChangeEvent} *)

type focusInEvent = focusChangeEvent
type focusOutEvent = focusChangeEvent

type keymapEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  key_vector : string;
}
(** {{:https://man.archlinux.org/man/XKeymapEvent.3} XKeymapEvent} *)

type exposeEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  pos : int * int;
  size : int * int;
  count : int;
}
(** {{:https://man.archlinux.org/man/XExposeEvent.3} XExposeEvent} *)

type graphicsExposeEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  drawable : drawable;
  pos : int * int;
  count : int;
  codes : int * int;
}
(** {{:https://man.archlinux.org/man/XGraphicsExposeEvent.3}
     XGraphicsExposeEvent} *)

type noExposeEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  drawable : drawable;
  codes : int * int;
}
(** {{:https://man.archlinux.org/man/XNoExposeEvent.3} XNoExposeEvent} *)

type visibilityEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  window : window;
  state : int;
}
(** {{:https://man.archlinux.org/man/XVisibilityEvent.3} XVisibilityEvent} *)

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
(** {{:https://man.archlinux.org/man/XCreateWindowEvent.3} XCreateWindowEvent}
*)

type destroyWindowEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  event : window;
  window : window;
}
(** {{:https://man.archlinux.org/man/XDestroyWindowEvent.3} XDestroyWindowEvent}
*)

type unmapEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  from_configure : bool;
}
(** {{:https://man.archlinux.org/man/XUnmapEvent.3} XUnmapEvent} *)

type mapEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  event : window;
  window : window;
  override_redirect : bool;
}
(** {{:https://man.archlinux.org/man/XMapEvent.3} XMapEvent} *)

type mapRequestEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  parent : window;
  window : window;
}
(** {{:https://man.archlinux.org/man/XMapRequestEvent.3} XMapRequestEvent} *)

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
  above : window option;
      (** Sibling the window is just above, [None] when it is at the bottom of
          the stack *)
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
  above : window option;
      (** Sibling to restack against, [None] if the request gives none *)
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

(** What a [MappingNotify] reports as changed *)
type mappingRequest = MappingModifier | MappingKeyboard | MappingPointer

type mappingEvent = {
  serial : Unsigned.ulong;
  send_event : bool;
  display : display;
  request : mappingRequest;
  first_keycode : int;
  count : int;
}

type errorEvent = {
  display : display;
  resourceid : [ `Unknown ] xid;
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

val atom_of_long : Signed.long -> atom
(** Reads a [Longs] item of a [ClientMessage] as an atom, such as the protocol
    of a [WM_PROTOCOLS] message. Its [message_type] says which items are atoms.
*)

(** {1 Core Functions} *)

val open_display : string option -> display option
(** {{:https://man.archlinux.org/man/XOpenDisplay.3} XOpenDisplay} *)

val close_display : display -> unit
(** {{:https://man.archlinux.org/man/XCloseDisplay.3} XCloseDisplay} *)

val flush : display -> unit
(** {{:https://man.archlinux.org/man/XFlush.3} XFlush} *)

val clear_window : display -> window -> unit
(** {{:https://man.archlinux.org/man/XClearWindow.3} XClearWindow} *)

val set_window_background : display -> window -> int -> unit
(** {{:https://man.archlinux.org/man/XSetWindowBackground.3}
     XSetWindowBackground} *)

val destroy_window : display -> window -> unit
(** {{:https://man.archlinux.org/man/XDestroyWindow.3} XDestroyWindow}: destroys
    the window and its subwindows *)

val map_raised : display -> window -> unit
(** {{:https://man.archlinux.org/man/XMapRaised.3} XMapRaise} *)

val map_subwindows : display -> window -> unit
(** {{:https://man.archlinux.org/man/XMapSubwindows.3} XMapSubwindows} *)

val map_window : display -> window -> unit
(** {{:https://man.archlinux.org/man/XMapWindow.3} XMapWindow} *)

val unmap_subwindows : display -> window -> unit
(** {{:https://man.archlinux.org/man/XUnmapSubwindows.3} XUnmapSubwindows} *)

val unmap_window : display -> window -> unit
(** {{:https://man.archlinux.org/man/XUnmapWindow.3} XUnmapWindow} *)

val intern_atom : display -> string -> bool -> atom option
(** {{:https://man.archlinux.org/man/XInternAtom.3} XInternAtom}: the atom named
    [name], created unless [only_if_exists] is set, in which case a missing atom
    gives [None] *)

val set_wm_protocols : display -> window -> atom list -> unit
(** {{:https://man.archlinux.org/man/XSetWMProtocols.3} XSetWMProtocols}:
    replaces the window's [WM_PROTOCOLS], the protocols it takes part in, such
    as [WM_DELETE_WINDOW] *)

val store_name : display -> window -> string -> unit
(** {{:https://man.archlinux.org/man/XStoreName.3} XStoreName}: sets the
    window's [WM_NAME], the title window managers and tools like xdotool show *)

val create_simple_window :
  display -> window -> int * int -> int * int -> int -> int -> int -> window
(** {{:https://man.archlinux.org/man/XCreateWindow.3} XCreateSimpleWindow} *)

val move_resize_window : display -> window -> int * int -> int * int -> unit
(** {{:https://man.archlinux.org/man/XMoveResizeWindow.3} XMoveResizeWindow} *)

val default_root_window : display -> window
(** {{:https://man.archlinux.org/man/DefaultRootWindow.3} XDefaultRootWindow} *)

type screenNumber
(** The [int screen_number] Xlib takes, as opposed to {!type-screen}, a
    [Screen *]. Only {!default_screen} gives one: Xlib doesn't check the number,
    and reads past its screens for an invalid one. *)

val default_screen : display -> screenNumber
(** {{:https://man.archlinux.org/man/DefaultScreen.3} XDefaultScreen} *)

val display_width : display -> screenNumber -> int
(** {{:https://man.archlinux.org/man/DisplayWidth.3} XDisplayWidth} *)

val display_height : display -> screenNumber -> int
(** {{:https://man.archlinux.org/man/DisplayHeight.3} XDisplayHeight} *)

val raise_window : display -> window -> unit
(** {{:https://man.archlinux.org/man/XRaiseWindow.3} XRaiseWindow} *)

val select_input : display -> window -> ([< eventFlags ], 'c) mask -> unit
(** {{:https://man.archlinux.org/man/XSelectInput.3} XSelectInput} *)

val keysym_to_keycode : display -> keysym -> keycode option
(** {{:https://man.archlinux.org/man/XKeysymToKeycode.3} XKeysymToKeycode}: a
    key that produces [keysym] in the current keyboard mapping, [None] if no key
    does *)

val kill_client : display -> _ xid -> unit
(** {{:https://man.archlinux.org/man/XKillClient.3} XKillClient} *)

val xkb_keycode_to_keysym : display -> keycode -> int -> int -> keysym option
(** {{:https://man.archlinux.org/man/XkbKeycodeToKeysym.3} XkbKeycodeToKeysym}:
    the keysym at [group] and shift [level] of [keycode], or [None] *)

val string_to_keysym : string -> keysym option
(** {{:https://man.archlinux.org/man/XStringToKeysym.3} XStringToKeysym}: the
    keysym named [name] (as in [XK_name], e.g. ["space"], not [" "]), [None] if
    there is no such keysym *)

val grab_button :
  display ->
  button ->
  ([ `Key ], 'c) mask ->
  window ->
  bool ->
  ([< pointerEventFlags ], 'd) mask ->
  grabMode ->
  grabMode ->
  window option ->
  cursor option ->
  unit
(** {{:https://man.archlinux.org/man/XGrabButton.3} XGrabButton} *)

val grab_key :
  display ->
  keycode ->
  ([ `Key ], 'c) mask ->
  window ->
  bool ->
  grabMode ->
  grabMode ->
  unit
(** {{:https://man.archlinux.org/man/XGrabKey.3} XGrabKey} *)

type focus =
  | FocusNone  (** C's [None] *)
  | FocusPointerRoot  (** C's [PointerRoot] *)
  | FocusWindow of window  (** Any other [Window] *)

type revertTo = RevertToNone | RevertToPointerRoot | RevertToParent

val set_input_focus : display -> focus -> revertTo -> time -> unit
(** {{:https://man.archlinux.org/man/XSetInputFocus.3} XSetInputFocus}. Note
    that with Xlib's default error handler, focusing a window that isn't
    viewable ([BadMatch]) exits the program. *)

val get_input_focus : display -> focus * revertTo
(** {{:https://man.archlinux.org/man/XGetInputFocus.3} XGetInputFocus}, with the
    [focus_return] and [revert_to_return] out-parameters returned as a pair *)

val next_event : display -> xEvent
(** {{:https://man.archlinux.org/man/XNextEvent.3} XNextEvent} *)

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
  bit_gravity : gravity;
  win_gravity : gravity;
  backing_store : backingStore;
  backing_planes : int;
  backing_pixel : int;
  save_under : bool;
  colormap : colormap;
  map_installed : bool;
  map_state : mapState;
  all_event_masks : 'a. (([> eventFlags ] as 'a), union) mask;
  your_event_mask : 'a. (([> eventFlags ] as 'a), union) mask;
  do_not_propagate_mask : 'a. (([> deviceEventFlags ] as 'a), union) mask;
  override_redirect : bool;
  screen : screen;
}

val get_window_attributes : display -> window -> windowAttributes option
(** {{:https://man.archlinux.org/man/XGetWindowAttributes.3}
     XGetWindowAttributes}. [None] if the request fails. Note that with Xlib's
    default error handler, a [BadWindow] error exits the program before this
    returns. *)

type windowChanges = {
  x : int option;
  y : int option;
  width : int option;
  height : int option;
  border_width : int option;
  stacking : (windowStackingMethod * window option) option;
}
(** {{:https://man.archlinux.org/man/XConfigureWindow.3} XWindowChanges} and its
    [value_mask] in one value: a field is [Some v] when C would set it to [v]
    and add its [CW*] flag to the mask, [None] when the flag would be left out.

    [stacking] holds [stack_mode] and [sibling] together, since X refuses
    [CWSibling] without [CWStackMode]: [Some (mode, None)] stands for
    [CWStackMode] alone, [Some (mode, Some s)] for both flags. *)

val window_changes :
  ?x:int ->
  ?y:int ->
  ?width:int ->
  ?height:int ->
  ?border_width:int ->
  ?stacking:windowStackingMethod * window option ->
  unit ->
  windowChanges
(** The changes with the given fields set, as in
    [window_changes ~x:10 ~y:20 ()]. [window_changes ()] has a [value_mask] of
    0. *)

val configure_window : display -> window -> windowChanges -> unit
(** {{:https://man.archlinux.org/man/XConfigureWindow.3} XConfigureWindow}, with
    the [value_mask] built from the fields that are [Some] *)
