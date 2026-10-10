# Questions

## Comparing `window` values in tests

`window` (and `atom`, `time`, `display`) are abstract in `x11.mli`, so the
tests can't check the `event`, `window` and `parent` fields that are the main
payload of DestroyNotify, UnmapNotify, MapNotify and MapRequest.

For now `test/test_xevent.ml` has a test-only `window_to_int` helper that uses
`Obj.magic` to read the underlying `Unsigned.ULong.t`, like the existing
`keycode` checks. It works, but it depends on the representation.

Options:

1. Keep the `Obj.magic` helper (current state).
2. Add `val window_to_int : window -> int` (or `of_int`) to the hidden
   `Private` module in `x11.mli`.
3. Expose an equality or conversion publicly (e.g. `val equal_window`,
   `val window_of_int`), which a window manager will probably want anyway to
   key client tables by window.

Which do you prefer?
