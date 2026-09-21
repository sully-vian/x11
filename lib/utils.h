#include <caml/alloc.h>

#define WRAP_XID(x) caml_copy_nativeint(x)
#define WRAP_PTR(x) caml_copy_nativeint((intptr_t)x)
