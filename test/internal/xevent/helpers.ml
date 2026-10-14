open X11_internal

(* The C stubs return the address of a static [XEvent]: read it through the
   same ctypes view as [next_event] *)
let xevent_of_raw_address address =
  Ctypes.(!@(from_voidp Xevent_ctypes.xevent_typ (ptr_of_raw_address address)))

let display_address display =
  Nativeint.to_int (Ctypes.raw_address_of_ptr display)
