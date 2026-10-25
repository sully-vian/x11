(lang dune 3.24)
(using ctypes 0.3)

(name x11)

(generate_opam_files true)

(source
 (github sully-vian/x11))

(authors "Vianney HERVY <vian.hervy@gmail.com>")

(license MIT)

(documentation https://sully-vian.github.io/x11/)

(package
 (name x11)
 (synopsis "X11 bindings for OCaml")
 (description
  "Type-safe OCaml bindings to Xlib, built with ctypes. X's integer constants become variants and typed masks, so that values X would reject don't type-check. The bindings are incomplete and grow toward what a simple window manager needs.")
 (depends ocaml ctypes (alcotest :with-test) (odoc :with-doc))
 (tags
  (x11 xlib bindings ctypes "window manager")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
