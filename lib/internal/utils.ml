open Ctypes

let read_int c_int = if c_int = 0 then None else Some c_int
let write_int = function None -> 0 | Some i -> i
let int_opt = view ~read:read_int ~write:write_int int
let read c_ulong = if c_ulong = Unsigned.ULong.zero then None else Some c_ulong
let write = function None -> Unsigned.ULong.zero | Some l -> l
let ulong_opt = view ~read ~write ulong
