type 'a mask = int

type eventMask =
  [ `Event | `PointerEvent | `DeviceEvent | `PointerDeviceEvent ] mask

type pointerEventMask = [ `PointerEvent | `PointerDeviceEvent ] mask
type deviceEventMask = [ `DeviceEvent | `PointerDeviceEvent ] mask
type keyMask = [ `Key | `Any ] mask
type stateMask = [ `Key | `Button ] mask

let ( ||| ) = ( lor )
let ( &&& ) m flags = m land flags <> 0
