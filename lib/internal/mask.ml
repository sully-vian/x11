type (+'a, +'c) mask = int
type union
type alone
type eventFlags = [ `Event | `PointerEvent | `DeviceEvent | `PointerDeviceEvent ]
type pointerEventFlags = [ `PointerEvent | `PointerDeviceEvent ]
type deviceEventFlags = [ `DeviceEvent | `PointerDeviceEvent ]
type 'a eventMask = (([> eventFlags ] as 'a), union) mask
type 'a pointerEventMask = (([> pointerEventFlags ] as 'a), union) mask
type 'a deviceEventMask = (([> deviceEventFlags ] as 'a), union) mask
type 'p keyMask = ('a, 'c) mask constraint 'p = ([> `Key ] as 'a) * 'c
type bindingMask = ([ `Key ], union) mask
type stateMask = ([ `Key | `Button ], union) mask
type configureWindowMask = ([ `ConfigureWindow ], union) mask

let ( ||| ) = ( lor )
let ( &&& ) m flags = m land flags <> 0
let ( &~ ) m flags = m land lnot flags
let ( &. ) = ( land )
let noModifier = 0
