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
  int off = 0;
  v_record = caml_alloc(21, 0); // 19 fields

  v_pos = caml_tuple2(Val_int(attrs->x), Val_int(attrs->y));
  Store_field(v_record, off++, v_pos);
  v_dim = caml_tuple2(Val_int(attrs->width), Val_int(attrs->height));
  Store_field(v_record, off++, v_dim);
  Store_field(v_record, off++, Val_int(attrs->border_width));
  Store_field(v_record, off++, Val_int(attrs->depth));
  Store_field(v_record, off++, Val_ptr(attrs->visual));
  Store_field(v_record, off++, Val_xid(attrs->root));
  Store_field(v_record, off++, Val_int(attrs->class));
  Store_field(v_record, off++, Val_int(attrs->bit_gravity));
  Store_field(v_record, off++, Val_int(attrs->win_gravity));
  Store_field(v_record, off++, Val_int(attrs->backing_store));
  Store_field(v_record, off++, Val_int(attrs->backing_planes));
  Store_field(v_record, off++, Val_int(attrs->backing_pixel));
  Store_field(v_record, off++, Val_bool(attrs->save_under));
  Store_field(v_record, off++, Val_xid(attrs->colormap));
  Store_field(v_record, off++, Val_bool(attrs->map_installed));
  Store_field(v_record, off++, Val_int(attrs->map_state));
  Store_field(v_record, off++, Val_int(attrs->all_event_masks));
  Store_field(v_record, off++, Val_int(attrs->your_event_mask));
  Store_field(v_record, off++, Val_int(attrs->do_not_propagate_mask));
  Store_field(v_record, off++, Val_bool(attrs->override_redirect));
  Store_field(v_record, off++, Val_ptr(attrs->screen));
  CAMLreturn(v_record);
}
