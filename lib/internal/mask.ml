type 'a mask = int
type eventMask = [ `Event ] mask
type keyMask = [ `Key | `Any ] mask
type stateMask = [ `Key | `Button ] mask

let ( ||| ) = ( lor )
let ( &&& ) m flags = m land flags <> 0
