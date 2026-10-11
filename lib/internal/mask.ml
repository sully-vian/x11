type 'a mask = int
type event_tag
type key_tag
type eventMask = event_tag mask
type keyMask = key_tag mask

let ( ||| ) = ( lor )
