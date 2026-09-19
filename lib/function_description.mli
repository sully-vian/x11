module Functions (F : Ctypes.FOREIGN) : sig
  open F

  type display

  val open_display : (string option -> display option return) result
  val close_display : (display -> unit return) result
end
