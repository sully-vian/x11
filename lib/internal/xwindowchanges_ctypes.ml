open Ctypes
open C.Types
open Xwindowchanges

(* The XWindowChanges struct and value_mask that XConfigureWindow takes for
   [changes]. Fields outside the mask are left at zero: X ignores them. *)
let window_changes_to_c : windowChanges -> int * xwindowchanges structure =
 fun changes ->
  let c = make xwindowchanges in
  (* Sets [field] and adds its [flag] to [mask] when there is a [value] *)
  let set field flag value mask =
    match value with
    | None -> mask
    | Some value ->
        setf c field value;
        mask lor flag
  in
  let stacking mask =
    match changes.stacking with
    | None -> mask
    | Some (stack_mode, sibling) ->
        setf c xwc_stack_mode stack_mode;
        mask lor cwStackMode |> set xwc_sibling cwSibling sibling
  in
  let mask =
    0 |> set xwc_x cwX changes.x |> set xwc_y cwY changes.y
    |> set xwc_width cwWidth changes.width
    |> set xwc_height cwHeight changes.height
    |> set xwc_border_width cwBorderWidth changes.border_width
    |> stacking
  in
  (mask, c)
