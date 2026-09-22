#include "utils.h"
#include <X11/Xlib.h>
#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

value Val_xwindowattributes(XWindowAttributes *attrs) {
  CAMLparam0();
  CAMLlocal3(v_record, v_pos, v_dim);
  v_record = caml_alloc(19, 0); // 19 fields

  v_pos = caml_alloc(2, 0); // tuple
  Store_field(v_pos, 0, Val_int(attrs->x));
  Store_field(v_pos, 1, Val_int(attrs->y));

  v_dim = caml_alloc(2, 0); // tuple
  Store_field(v_dim, 0, Val_int(attrs->width));
  Store_field(v_dim, 1, Val_int(attrs->height));

  v_pos = caml_tuple2(Val_int(attrs->x), Val_int(attrs->y));
  Store_field(v_record, 0, v_pos);
  Store_field(v_record, 1, v_dim);
  Store_field(v_record, 2, Val_int(attrs->border_width));
  Store_field(v_record, 3, Val_int(attrs->depth));
  Store_field(v_record, 4, Val_ptr(attrs->visual));
  Store_field(v_record, 5, Val_xid(attrs->root));
  Store_field(v_record, 6, Val_int(attrs->class));
  Store_field(v_record, 7, Val_int(attrs->bit_gravity));
  Store_field(v_record, 8, Val_int(attrs->win_gravity));
  Store_field(v_record, 9, Val_int(attrs->backing_store));
  Store_field(v_record, 10, Val_int(attrs->backing_planes));
  Store_field(v_record, 11, Val_int(attrs->backing_pixel));
  Store_field(v_record, 12, Val_bool(attrs->save_under));
  Store_field(v_record, 13, Val_int(attrs->map_state));
  Store_field(v_record, 14, Val_int(attrs->all_event_masks));
  Store_field(v_record, 15, Val_int(attrs->your_event_mask));
  Store_field(v_record, 16, Val_int(attrs->do_not_propagate_mask));
  Store_field(v_record, 17, Val_bool(attrs->override_redirect));
  Store_field(v_record, 18, Val_ptr(attrs->screen));
  CAMLreturn(v_record);
}
