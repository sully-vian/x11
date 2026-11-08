open Ctypes
open C.Types
open Xwindowchanges

(* The XWindowChanges struct and value_mask that XConfigureWindow takes for
   [changes]. A field is sent when it is [Some] and its flag is in
   [value_mask], which defaults to every flag. Fields outside the mask are left
   at zero: X ignores them. *)
let window_changes_to_c :
    ?value_mask:int -> windowChanges -> int * xwindowchanges structure =
 fun ?(value_mask = -1) changes ->
  let c = make xwindowchanges in
  (* Sets [field] and adds its [flag] to [mask] when there is a [value] and
     [value_mask] lets it through *)
  let set field flag value mask =
    match value with
    | Some value when value_mask land flag <> 0 ->
        setf c field value;
        mask lor flag
    | _ -> mask
  in
  (* X refuses a sibling without a stack mode, so the sibling goes with it *)
  let stacking mask =
    match changes.stacking with
    | Some (stack_mode, sibling) when value_mask land cwStackMode <> 0 ->
        setf c xwc_stack_mode stack_mode;
        mask lor cwStackMode |> set xwc_sibling cwSibling sibling
    | _ -> mask
  in
  let mask =
    0 |> set xwc_x cwX changes.x |> set xwc_y cwY changes.y
    |> set xwc_width cwWidth changes.width
    |> set xwc_height cwHeight changes.height
    |> set xwc_border_width cwBorderWidth changes.border_width
    |> stacking
  in
  (mask, c)
