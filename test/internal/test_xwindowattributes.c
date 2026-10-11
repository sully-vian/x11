#include <X11/Xlib.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

extern value Val_xwindowattributes(XWindowAttributes *attributes);

// 1. Basic: A typical mapped InputOutput window with standard attributes
CAMLprim value get_xwa_basic(value unit) {
  CAMLparam1(unit);
  XWindowAttributes attr = {.x = 100,
                            .y = 200,
                            .width = 800,
                            .height = 600,
                            .border_width = 2,
                            .depth = 24,
                            .visual = (Visual *)0x12345678,
                            .root = 1234,
                            .class = InputOutput,
                            .bit_gravity = NorthWestGravity,
                            .win_gravity = NorthWestGravity,
                            .backing_store = NotUseful,
                            .backing_planes = 0xFFFFFFFF,
                            .backing_pixel = 0,
                            .save_under = False,
                            .colormap = 5678,
                            .map_installed = True,
                            .map_state = IsViewable,
                            .all_event_masks =
                                StructureNotifyMask | ExposureMask,
                            .your_event_mask = StructureNotifyMask,
                            .do_not_propagate_mask = 0,
                            .override_redirect = False,
                            .screen = (Screen *)0x87654321};
  CAMLreturn(Val_xwindowattributes(&attr));
}

// 2. Zeroed: All fields zeroed out, pointers set to NULL (Testing null
// references)
CAMLprim value get_xwa_zeroed(value unit) {
  CAMLparam1(unit);
  XWindowAttributes attr = {.x = 0,
                            .y = 0,
                            .width = 0,
                            .height = 0,
                            .border_width = 0,
                            .depth = 0,
                            .visual = (Visual *)0,
                            .root = 0,
                            .class = 0,
                            .bit_gravity = ForgetGravity, // 0
                            .win_gravity = UnmapGravity,  // 0
                            .backing_store = NotUseful,   // 0
                            .backing_planes = 0,
                            .backing_pixel = 0,
                            .save_under = False,
                            .colormap = 0,
                            .map_installed = False,
                            .map_state = IsUnmapped, // 0
                            .all_event_masks = 0,
                            .your_event_mask = 0,
                            .do_not_propagate_mask = 0,
                            .override_redirect = False,
                            .screen = (Screen *)0};
  CAMLreturn(Val_xwindowattributes(&attr));
}

// 3. Negative Coordinates: Placed out-of-bounds (Testing signed ints for
// coordinates)
CAMLprim value get_xwa_negative_coords(value unit) {
  CAMLparam1(unit);
  XWindowAttributes attr = {.x = -1500,
                            .y = -2000,
                            .width = 1920,
                            .height = 1080,
                            .border_width = 0,
                            .depth = 24,
                            .visual = (Visual *)0x1234,
                            .root = 1234,
                            .class = InputOutput,
                            .bit_gravity = NorthWestGravity,
                            .win_gravity = NorthWestGravity,
                            .backing_store = NotUseful,
                            .backing_planes = ~0UL,
                            .backing_pixel = 0,
                            .save_under = False,
                            .colormap = 5678,
                            .map_installed = True,
                            .map_state = IsViewable,
                            .all_event_masks = 0,
                            .your_event_mask = 0,
                            .do_not_propagate_mask = 0,
                            .override_redirect = False,
                            .screen = (Screen *)0x1234};
  CAMLreturn(Val_xwindowattributes(&attr));
}

// 4. Large Dimensions: Extremely large dimensions (Testing signed int
// boundaries)
CAMLprim value get_xwa_huge_dimensions(value unit) {
  CAMLparam1(unit);
  XWindowAttributes attr = {.x = 0,
                            .y = 0,
                            .width = 2147483647,
                            .height = 2147483647, // INT_MAX
                            .border_width = 2147483647,
                            .depth = 32,
                            .visual = (Visual *)0x1234,
                            .root = 123,
                            .class = InputOutput,
                            .bit_gravity = NorthWestGravity,
                            .win_gravity = NorthWestGravity,
                            .backing_store = NotUseful,
                            .backing_planes = ~0UL,
                            .backing_pixel = 0,
                            .save_under = False,
                            .colormap = 567,
                            .map_installed = True,
                            .map_state = IsViewable,
                            .all_event_masks = 0,
                            .your_event_mask = 0,
                            .do_not_propagate_mask = 0,
                            .override_redirect = False,
                            .screen = (Screen *)0x1234};
  CAMLreturn(Val_xwindowattributes(&attr));
}

// 5. Input Only: Invisible windows used for catching events (Depth 0, No
// Visual)
CAMLprim value get_xwa_input_only(value unit) {
  CAMLparam1(unit);
  XWindowAttributes attr = {.x = 10,
                            .y = 10,
                            .width = 100,
                            .height = 100,
                            .border_width = 0,
                            .depth = 0, // InputOnly windows always have depth 0
                            .visual = NULL, // No visual associated
                            .root = 999,
                            .class = InputOnly,
                            .bit_gravity = ForgetGravity,
                            .win_gravity = NorthWestGravity,
                            .backing_store = NotUseful,
                            .backing_planes = 0,
                            .backing_pixel = 0,
                            .save_under = False,
                            .colormap = None,
                            .map_installed = False,
                            .map_state = IsUnmapped,
                            .all_event_masks =
                                EnterWindowMask | LeaveWindowMask,
                            .your_event_mask = EnterWindowMask,
                            .do_not_propagate_mask = 0,
                            .override_redirect = True,
                            .screen = (Screen *)0x8888};
  CAMLreturn(Val_xwindowattributes(&attr));
}

// 6. Max Masks: Unsigned long limits for planes and masks
CAMLprim value get_xwa_max_masks_planes(value unit) {
  CAMLparam1(unit);
  XWindowAttributes attr = {.x = 0,
                            .y = 0,
                            .width = 10,
                            .height = 10,
                            .border_width = 0,
                            .depth = 24,
                            .visual = (Visual *)0x1111,
                            .root = 111,
                            .class = InputOutput,
                            .bit_gravity = NorthWestGravity,
                            .win_gravity = NorthWestGravity,
                            .backing_store = NotUseful,
                            .backing_planes = ~0UL, // Max unsigned long
                            .backing_pixel = ~0UL,  // Max unsigned long
                            .save_under = False,
                            .colormap = 111,
                            .map_installed = True,
                            .map_state = IsViewable,
                            .all_event_masks = ~0L, // Max long
                            .your_event_mask = ~0L,
                            .do_not_propagate_mask = ~0L,
                            .override_redirect = False,
                            .screen = (Screen *)0x1111};
  CAMLreturn(Val_xwindowattributes(&attr));
}

// 7. Bools True: Testing OCaml Bool mapping for all boolean fields
CAMLprim value get_xwa_bools_true(value unit) {
  CAMLparam1(unit);
  XWindowAttributes attr = {.x = 5,
                            .y = 5,
                            .width = 50,
                            .height = 50,
                            .border_width = 1,
                            .depth = 8,
                            .visual = (Visual *)0x2222,
                            .root = 222,
                            .class = InputOutput,
                            .bit_gravity = NorthWestGravity,
                            .win_gravity = NorthWestGravity,
                            .backing_store = NotUseful,
                            .backing_planes = 0xFF,
                            .backing_pixel = 0xFF,
                            .save_under = True, // Bool #1
                            .colormap = 222,
                            .map_installed = True, // Bool #2
                            .map_state = IsViewable,
                            .all_event_masks = 0,
                            .your_event_mask = 0,
                            .do_not_propagate_mask = 0,
                            .override_redirect = True, // Bool #3
                            .screen = (Screen *)0x2222};
  CAMLreturn(Val_xwindowattributes(&attr));
}

// 8. Odd Gravities & Backing Store (Testing enum variants)
CAMLprim value get_xwa_gravities_store(value unit) {
  CAMLparam1(unit);
  XWindowAttributes attr = {.x = 20,
                            .y = 20,
                            .width = 200,
                            .height = 200,
                            .border_width = 5,
                            .depth = 32,
                            .visual = (Visual *)0x3333,
                            .root = 333,
                            .class = InputOutput,
                            .bit_gravity = CenterGravity,
                            .win_gravity = StaticGravity,
                            .backing_store = Always, // Testing Always variant
                            .backing_planes = 0xFFFFFF,
                            .backing_pixel = 0xABCDEF,
                            .save_under = False,
                            .colormap = 333,
                            .map_installed = False,
                            .map_state = IsViewable,
                            .all_event_masks = 0,
                            .your_event_mask = 0,
                            .do_not_propagate_mask = 0,
                            .override_redirect = False,
                            .screen = (Screen *)0x3333};
  CAMLreturn(Val_xwindowattributes(&attr));
}

// 9. Unviewable State: A mapped window obscured by others
CAMLprim value get_xwa_unviewable(value unit) {
  CAMLparam1(unit);
  XWindowAttributes attr = {.x = 0,
                            .y = 0,
                            .width = 1920,
                            .height = 1080,
                            .border_width = 0,
                            .depth = 24,
                            .visual = (Visual *)0x4444,
                            .root = 444,
                            .class = InputOutput,
                            .bit_gravity = NorthWestGravity,
                            .win_gravity = NorthWestGravity,
                            .backing_store = WhenMapped,
                            .backing_planes = ~0UL,
                            .backing_pixel = 0,
                            .save_under = False,
                            .colormap = 444,
                            .map_installed = True,
                            .map_state = IsUnviewable,
                            .all_event_masks = 0,
                            .your_event_mask = 0,
                            .do_not_propagate_mask = 0,
                            .override_redirect = False,
                            .screen = (Screen *)0x4444};
  CAMLreturn(Val_xwindowattributes(&attr));
}

// 10. Max Pointer Values: Testing memory address upper limits
CAMLprim value get_xwa_max_pointers(value unit) {
  CAMLparam1(unit);
  XWindowAttributes attr = {
      .x = 0,
      .y = 0,
      .width = 1,
      .height = 1,
      .border_width = 0,
      .depth = 1,
      .visual = (Visual *)~0UL, // Max pointer bounds
      .root = ~0UL,
      .class = InputOutput,
      .bit_gravity = NorthWestGravity,
      .win_gravity = NorthWestGravity,
      .backing_store = NotUseful,
      .backing_planes = 0,
      .backing_pixel = 0,
      .save_under = False,
      .colormap = ~0UL, // Max XID
      .map_installed = False,
      .map_state = IsUnmapped,
      .all_event_masks = 0,
      .your_event_mask = 0,
      .do_not_propagate_mask = 0,
      .override_redirect = False,
      .screen = (Screen *)~0UL // Max pointer bounds
  };
  CAMLreturn(Val_xwindowattributes(&attr));
}
