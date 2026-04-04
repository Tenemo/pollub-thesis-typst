#import "i18n.typ": apply-polish-typography, localized-labels
#import "title-page.typ": default-title-header-image, title-page

#let current-chapter() = counter(heading.where(level: 1)).get().at(0, default: 0)

#let sectioned-numbering(n) = context {
  numbering("1.1", current-chapter(), n)
}

#let equation-numbering(n) = context {
  let section = current-chapter()
  "(" + str(section) + "." + str(n) + ")"
}

#let resolve-label(labels, key, override) = if override == none {
  labels.at(key)
} else {
  override
}

#let abstract-section(
  title,
  body,
  keywords,
  keywords-label,
  lang,
) = [
  #let resolved-body = if lang == "pl" {
    apply-polish-typography(body)
  } else {
    body
  }
  #let resolved-keywords-label = if lang == "pl" {
    apply-polish-typography(keywords-label)
  } else {
    keywords-label
  }
  #set text(lang: lang)
  #set par(justify: true, spacing: 0pt)
  #text(size: 14pt, weight: "bold")[#title]
  #parbreak()
  #resolved-body
  #if keywords.len() > 0 [
    #parbreak()
    #strong[#resolved-keywords-label] #keywords.join(", ")
  ]
]

#let thesis(
  body,
  main-lang: "pl",
  title-pl: [Polski tytuł pracy],
  title-en: [English thesis title],
  authors: ((name: "Jan Kowalski", album-number: "000000"),),
  supervisor: "Dr inż. Jan Nowak",
  degree-label: ([Praca dyplomowa], [magisterska]),
  field-of-study: [na kierunku Informatyka],
  diploma-block: [na bloku dyplomowania Aplikacje Internetowe],
  city: "Lublin",
  year: "2026",
  abstract-pl: [Krótki opis pracy po polsku.],
  keywords-pl: (),
  abstract-en: [A short English abstract.],
  keywords-en: (),
  title-header-image: default-title-header-image,
  outline-title: none,
  abstract-pl-title: [Streszczenie],
  abstract-en-title: [Abstract],
  keywords-pl-label: [Słowa kluczowe:],
  keywords-en-label: [Keywords:],
  figure-supplement: none,
  table-supplement: none,
  listing-supplement: none,
  symbols-list: none,
  symbols-list-title: none,
  polish-typography: none,
) = {
  let labels = localized-labels(main-lang)
  let resolved-outline-title = resolve-label(labels, "outline-title", outline-title)
  let resolved-figure-supplement = resolve-label(labels, "figure-supplement", figure-supplement)
  let resolved-table-supplement = resolve-label(labels, "table-supplement", table-supplement)
  let resolved-listing-supplement = resolve-label(labels, "listing-supplement", listing-supplement)
  let resolved-symbols-list-title = resolve-label(labels, "symbols-list-title", symbols-list-title)
  let enable-polish-typography = if polish-typography == none {
    main-lang == "pl"
  } else {
    polish-typography
  }
  let author-names = authors.map(author => author.at("name", default: "")).join(", ")
  let main-body = if enable-polish-typography {
    apply-polish-typography(body)
  } else {
    body
  }

  set document(
    title: title-pl,
    author: author-names,
    keywords: keywords-pl + keywords-en,
  )
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
    lang: main-lang,
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
    #let section-number = current-chapter()
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
  show figure.caption: it => align(center)[
    #set text(size: 10pt, lang: main-lang)
    #it
  ]
  show figure.where(kind: image): set figure(
    supplement: resolved-figure-supplement,
  )
  show figure.where(kind: image): set figure.caption(
    separator: [. ],
  )
  show figure.where(kind: image): it => block(width: 100%, above: 6pt, below: 6pt)[
    #align(center)[#it]
  ]
  show figure.where(kind: table): set figure(
    supplement: resolved-table-supplement,
  )
  show figure.where(kind: table): set figure.caption(
    position: top,
    separator: [. ],
  )
  show figure.where(kind: table): it => block(width: 100%, above: 6pt, below: 6pt)[
    #align(center)[#it]
  ]
  show figure.where(kind: "listing"): set figure(
    supplement: resolved-listing-supplement,
  )
  show figure.where(kind: "listing"): set figure.caption(
    position: top,
    separator: [. ],
  )
  show figure.where(kind: "listing"): set block(
    width: 100%,
    above: 6pt,
    below: 6pt,
  )
  show table: set text(size: 11pt)
  show raw.where(block: true): set text(size: 10pt)
  show table.cell.where(y: 0): strong
  show math.equation.where(block: true): set block(above: 6pt, below: 6pt)

  [
    #set page(numbering: none)
    #title-page(
      title-header-image,
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

    #outline(title: resolved-outline-title, depth: 2)

    #pagebreak()
    #if symbols-list != none [
      #set par(first-line-indent: (amount: 0cm, all: true))
      #text(size: 14pt, weight: "bold")[#resolved-symbols-list-title]
      #parbreak()
      #symbols-list
      #pagebreak()
    ]
    #main-body
  ]
}
