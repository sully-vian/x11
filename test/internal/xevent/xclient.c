#include "raw_xevent.h"

CAMLprim value get_raw_client_message_ev_b(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xclient = {
                      .type = ClientMessage,
                      .serial = 330,
                      .send_event = True,
                      .display = (Display *)0x4444,
                      .window = 3301,
                      .message_type = 3302,
                      .format = 8,
                  }};
  // populate message data with dummy string for b case
  for (int i = 0; i < 20; i++) {
    event.xclient.data.b[i] = i + 65;
  }
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_client_message_ev_s(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xclient = {
                      .type = ClientMessage,
                      .format = 16,
                  }};
  // populate message data with dummy int array for s case
  for (int i = 0; i < 10; i++) {
    event.xclient.data.s[i] = i;
  }
  CAMLreturn(raw_xevent(&event));
}

CAMLprim value get_raw_client_message_ev_l(value unit) {
  CAMLparam1(unit);
  XEvent event = {.xclient = {
                      .type = ClientMessage,
                      .format = 32,
                  }};
  // populate message data with dummy long array for l case
  for (long i = 0; i < 5; i++) {
    event.xclient.data.l[i] = i;
  }
  CAMLreturn(raw_xevent(&event));
}
