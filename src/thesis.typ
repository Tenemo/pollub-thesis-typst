#import "title-page.typ": default-title-header-image, title-page

#let sectioned-numbering(n) = context {
  let section = counter(heading.where(level: 1)).get().at(0, default: 0)
  numbering("1.1", section, n)
}

#let equation-numbering(n) = context {
  let section = counter(heading.where(level: 1)).get().at(0, default: 0)
  "(" + str(section) + "." + str(n) + ")"
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

#let caption-block(caption, supplement) = [
  #align(center)[
    #set text(size: 10pt, lang: "pl")
    #supplement #h(0.35em)#context caption.counter.display(caption.numbering). #caption.body
  ]
]

#let abstract-section(
  title,
  body,
  keywords,
  keywords-label,
  lang,
) = [
  #set text(lang: lang)
  #set par(justify: true, spacing: 0pt)
  #text(size: 14pt, weight: "bold")[#title]
  #parbreak()
  #body
  #if keywords.len() > 0 [
    #parbreak()
    #strong[#keywords-label] #keywords.join(", ")
  ]
]

#let thesis(
  body,
  title-pl: [Polski tytuł pracy],
  title-en: [English thesis title],
  authors: ((name: "Jan Kowalski", album-number: "000000"),),
  supervisor: "Dr inż. Jan Nowak",
  degree-label: [Praca dyplomowa \ magisterska],
  field-of-study: [na kierunku Informatyka],
  diploma-block: [na bloku dyplomowania Aplikacje Internetowe],
  city: "Lublin",
  year: "2026",
  abstract-pl: [Krótki opis pracy po polsku.],
  keywords-pl: (),
  abstract-en: [A short English abstract.],
  keywords-en: (),
  university: [Politechnika Lubelska],
  faculty-short: [WEII],
  faculty: [Wydział Elektrotechniki i Informatyki],
  title-header-image: default-title-header-image,
  outline-title: [Spis treści],
  abstract-pl-title: [Streszczenie],
  abstract-en-title: [Abstract],
  keywords-pl-label: [Słowa kluczowe:],
  keywords-en-label: [Keywords:],
  symbols-list: none,
) = {
  let author-names = authors.map(author => author.at("name", default: "")).join(", ")

  set document(
    title: title-pl,
    author: author-names,
    keywords: keywords-pl + keywords-en,
  )
  show regex("(?i) [aiouwz] [" + polish-letters + "]"): protect-internal-single-letter-word
  show regex("(?i)[aiouwz] [" + polish-letters + "]"): protect-leading-single-letter-word
  set page(
    paper: "a4",
    binding: left,
    margin: (
      top: 2.5cm,
      bottom: 2cm,
      inside: 3.5cm,
      outside: 2cm,
    ),
    number-align: center + bottom,
  )
  set text(
    font: "Times New Roman",
    size: 12pt,
    lang: "pl",
  )
  set par(
    justify: true,
    spacing: 0pt,
    leading: 0.5em,
    first-line-indent: (amount: 0.85cm, all: true),
  )
  set heading(numbering: "1.1.1.")
  set cite(style: "ieee")
  set figure(numbering: sectioned-numbering)
  set math.equation(numbering: equation-numbering)
  set table(
    stroke: 0.5pt,
    inset: (x: 5pt, y: 4pt),
    align: left,
  )

  show heading.where(level: 1): it => [
    #let section-number = counter(heading.where(level: 1)).get().at(0, default: 0)
    #let numbered-heading = it.numbering != none
    #if numbered-heading and section-number > 1 [
      #pagebreak()
    ]
    #if numbered-heading [
      #counter(figure.where(kind: image)).update(0)
      #counter(figure.where(kind: table)).update(0)
      #counter(figure.where(kind: "listing")).update(0)
      #counter(math.equation.where(block: true)).update(0)
    ]
    #set text(size: 14pt, weight: "bold")
    #set block(above: 0pt, below: 1.2em)
    #it
  ]

  show heading.where(level: 2): it => [
    #set text(size: 12pt, weight: "bold")
    #set block(above: 1.2em, below: 0.8em)
    #it
  ]

  show heading.where(level: 3): it => [
    #set text(size: 12pt, style: "italic")
    #set block(above: 1em, below: 0.6em)
    #it
  ]

  show outline.entry.where(level: 1): set text(weight: "bold")
  show figure.where(kind: image): it => block(width: 100%, above: 6pt, below: 6pt)[
    #align(center)[#it.body]
    #if it.caption != none [
      #v(6pt)
      #caption-block(it.caption, [Rys.])
    ]
  ]
  show figure.where(kind: table): it => block(width: 100%, above: 6pt, below: 6pt)[
    #if it.caption != none [
      #caption-block(it.caption, [Tabela])
      #v(6pt)
    ]
    #align(center)[
      #set text(size: 11pt)
      #it.body
    ]
  ]
  show figure.where(kind: "listing"): it => block(width: 100%, above: 6pt, below: 6pt)[
    #if it.caption != none [
      #caption-block(it.caption, [Listing])
      #v(6pt)
    ]
    #it.body
  ]
  show raw.where(block: true): it => block(width: 100%)[
    #set text(size: 10pt)
    #it
  ]
  show table.cell.where(y: 0): strong
  show math.equation.where(block: true): set block(above: 6pt, below: 6pt)

  [
    #set page(numbering: none)
    #title-page(
      title-header-image,
      university,
      faculty-short,
      faculty,
      title-pl,
      title-en,
      authors,
      supervisor,
      degree-label,
      field-of-study,
      diploma-block,
      city,
      year,
    )

    #pagebreak(to: "odd")
    #counter(page).update(3)
    #set page(numbering: "1")

    #abstract-section(
      abstract-pl-title,
      abstract-pl,
      keywords-pl,
      keywords-pl-label,
      "pl",
    )

    #v(1.5em)

    #abstract-section(
      abstract-en-title,
      abstract-en,
      keywords-en,
      keywords-en-label,
      "en",
    )

    #pagebreak()

    #outline(title: outline-title, depth: 2)

    #pagebreak()
    #if symbols-list != none [
      #set par(first-line-indent: (amount: 0cm, all: true))
      #text(size: 14pt, weight: "bold")[Alfabetyczny wykaz oznaczeń]
      #parbreak()
      #symbols-list
      #pagebreak()
    ]
    #body
  ]
}
