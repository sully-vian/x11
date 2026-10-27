open C.Types
open Type_description.Enums

(* XWindowChanges with its value_mask: each field is set exactly when its CW
   flag would be in the mask. The sibling goes with the stack mode, as X
   refuses a sibling without one. *)
type windowChanges = {
  x : int option;
  y : int option;
  width : int option;
  height : int option;
  border_width : int option;
  stacking : (windowStackingMethod * window option) option;
}

let window_changes ?x ?y ?width ?height ?border_width ?stacking () =
  { x; y; width; height; border_width; stacking }
