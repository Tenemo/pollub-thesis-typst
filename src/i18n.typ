#let localized-labels(main-lang) = if main-lang == "pl" {
  (
    outline-title: "Spis treści",
    figure-supplement: "Rys.",
    table-supplement: "Tabela",
    listing-supplement: "Listing",
    symbols-list-title: "Alfabetyczny wykaz oznaczeń",
  )
} else {
  (
    outline-title: "Table of contents",
    figure-supplement: "Fig.",
    table-supplement: "Table",
    listing-supplement: "Listing",
    symbols-list-title: "List of symbols",
  )
}

// Polish typography keeps a one-letter word (a, i, o, u, w, z) on the same
// line as the word after it. The word boundary before the letter limits the
// match to one-letter words, so the last letter of a longer word is not bound.
#let bind-single-letter-word(it) = [#it.text.clusters().at(0)#sym.space.nobreak]

#let apply-polish-typography(body) = {
  show regex("(?i)\b[aiouwz] "): bind-single-letter-word
  body
}
