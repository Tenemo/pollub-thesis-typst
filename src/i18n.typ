#let localized-labels(main-lang) = if main-lang == "pl" {
  (
    outline-title: [Spis treści],
    figure-supplement: [Rys.],
    table-supplement: [Tabela],
    listing-supplement: [Listing],
    symbols-list-title: [Alfabetyczny wykaz oznaczeń],
  )
} else {
  (
    outline-title: [Table of Contents],
    figure-supplement: [Fig.],
    table-supplement: [Table],
    listing-supplement: [Listing],
    symbols-list-title: [List of Symbols],
  )
}

#let polish-letters = "A-Za-zĄąĆćĘęŁłŃńÓóŚśŹźŻż"

#let protect-internal-single-letter-word(it) = {
  let chars = it.text.clusters()
  [#chars.at(0)#chars.at(1)#sym.space.nobreak#chars.at(3)]
}

#let protect-leading-single-letter-word(it) = {
  let chars = it.text.clusters()
  [#chars.at(0)#sym.space.nobreak#chars.at(2)]
}

#let apply-polish-typography(body) = {
  show regex("(?i) [aiouwz] [" + polish-letters + "]"): protect-internal-single-letter-word
  show regex("(?i)[aiouwz] [" + polish-letters + "]"): protect-leading-single-letter-word
  body
}
