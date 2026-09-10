(lang dune 3.24)

(name x11)

(generate_opam_files true)

(source
 (github sully-vian/x11))

(authors "Vianney HERVY <vian.hervy@gmail.com>")

(license MIT)

(documentation https://url/to/documentation)

(package
 (name x11)
 (synopsis "X11 bindings for OCaml")
 (description "A longer description")
 (depends ocaml (alcotest :with-test))
 (tags
  ("add topics" "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
