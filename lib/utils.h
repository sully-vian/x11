#include <caml/alloc.h>
#include <caml/memory.h>

#define Val_xid(x) caml_copy_nativeint(x)

void caml_failwith_fmt(const char *fmt, ...);
static inline value caml_tuple2(value v1, value v2) {
  CAMLparam2(v1, v2);
  value v_pair = caml_alloc(2, 0);
  Store_field(v_pair, 0, v1);
  Store_field(v_pair, 1, v2);
  CAMLreturn(v_pair);
}
