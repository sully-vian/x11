# x11

X11 bindings for OCaml

The goal is to provide a clean and type-safe OCaml interface to X11.

## Testing internals

`window`, `atom`, `time` and `display` are abstract in `x11.mli`, so tests
written against the public API can't check the XIDs that make up most of an
event (`event`, `window`, `parent`, ...). For now, `test/test_xevent.ml` reads
them through `window_to_int`, a test-only `Obj.magic` helper, like the existing
`keycode` checks. It works but silently breaks if the representation changes.

Planned fix: expose the internal modules, with their true types, through the
hidden `Private` module of `x11.mli`, using module aliases so nothing has to be
kept in sync:

```ocaml
(**/**)
module Private : sig
  module Xevent = Xevent
  module Xevent_ctypes = Xevent_ctypes
  (* ... *)
end
(**/**)
```

Conversion tests then use `Private.Xevent_ctypes.xevent_of_c` and see `window`
as `Unsigned.ULong.t`, while integration tests keep using the public API.
`Private` carries no stability guarantee. If it becomes a liability, the
stricter option is a separate internal library that the tests depend on.

Comparing windows in user code needs no helper: polymorphic `=`, `compare`
and `Hashtbl` work on `window`, because `Unsigned.ULong.t` provides its own
compare and hash functions.
