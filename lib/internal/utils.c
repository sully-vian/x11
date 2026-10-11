#include <caml/fail.h>

void caml_failwith_fmt(const char *fmt, ...) {
  char buffer[256];
  va_list args;
  va_start(args, fmt);
  vsnprintf(buffer, sizeof(buffer), fmt, args);
  va_end(args);
  caml_failwith(buffer);
}
