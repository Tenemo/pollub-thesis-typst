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

#let body-leading = 0.7em
#let body-par-spacing = body-leading
#let screen-side-margin = 2.75cm
#let object-block-spacing = 18pt
#let caption-block-spacing = 6pt
#let table-header-fill = luma(232)
#let table-row-fill = luma(245)
#let listing-block-fill = luma(246)
#let listing-block-radius = 3pt
#let listing-block-inset = 8pt
#let listing-font-size = 9pt

#let resolve-label(labels, key, override) = if override == none {
  labels.at(key)
} else {
  override
}

#let centered-object-block(it) = block(
  width: 100%,
  above: object-block-spacing,
  below: object-block-spacing,
  breakable: false,
)[
  #align(center)[#it]
]

#let full-width-object-block(it) = block(
  width: 100%,
  above: object-block-spacing,
  below: object-block-spacing,
  breakable: false,
)[
  #it
]

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
  #set par(
    justify: true,
    spacing: body-par-spacing,
    leading: body-leading,
    first-line-indent: (amount: 0.85cm, all: true),
  )
  #heading(level: 1, numbering: none, outlined: true)[#title]
  #set par(
    justify: true,
    spacing: body-par-spacing,
    leading: body-leading,
    first-line-indent: (amount: 0.85cm, all: true),
  )
  #resolved-body
  #if keywords.len() > 0 [
    #v(1.4em)
    #set par(first-line-indent: (amount: 0cm, all: true))
    #strong[#resolved-keywords-label] #keywords.join(", ")
  ]
]

#let thesis(
  body,
  main-lang: "pl",
  title-primary: none,
  title-secondary: none,
  authors: (),
  supervisor: none,
  degree-label-primary: none,
  degree-label-secondary: none,
  field-of-study: none,
  specialization: none,
  city: none,
  year: none,
  abstract-pl: [],
  keywords-pl: (),
  abstract-en: [],
  keywords-en: (),
  title-header-image: default-title-header-image,
  title-header-image-left: none,
  outline-title: none,
  abstract-pl-title: "Streszczenie",
  abstract-en-title: "Abstract",
  keywords-pl-label: "Słowa kluczowe:",
  keywords-en-label: "Keywords:",
  figure-supplement: none,
  table-supplement: none,
  listing-supplement: none,
  symbols-list: none,
  symbols-list-title: none,
  polish-typography: none,
  screen-mode: true,
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
  let author-names = if authors.len() > 0 {
    authors.map(author => author.at("name", default: "")).join(", ")
  } else {
    ""
  }
  let main-body = if enable-polish-typography {
    apply-polish-typography(body)
  } else {
    body
  }

  let document-title = if title-primary != none and title-primary != [] {
    title-primary
  } else if title-secondary != none and title-secondary != [] {
    title-secondary
  } else {
    ""
  }

  set document(
    title: document-title,
    author: author-names,
    keywords: keywords-pl + keywords-en,
  )
  // `screen-mode` keeps the same text width, but switches to symmetric
  // left/right margins so the PDF is more comfortable to read on screen.
  if screen-mode {
    set page(
      paper: "a4",
      margin: (
        top: 2.5cm,
        bottom: 2cm,
        left: screen-side-margin,
        right: screen-side-margin,
      ),
      number-align: center + bottom,
    )
  } else {
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
  }
  set text(
    font: "Times New Roman",
    size: 12pt,
    lang: main-lang,
  )
  set par(
    justify: true,
    spacing: body-par-spacing,
    leading: body-leading,
    first-line-indent: (amount: 0.85cm, all: true),
  )
  set heading(numbering: "1.1.1.")
  set figure(numbering: sectioned-numbering)
  set math.equation(numbering: equation-numbering)
  set table(
    stroke: 0.5pt,
    inset: (x: 6pt, y: 4pt),
    align: left,
    fill: (x, y) => if y == 0 {
      table-header-fill
    } else if y > 0 and calc.rem(y, 2) == 0 {
      table-row-fill
    } else {
      none
    },
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
    #set par(first-line-indent: (amount: 0pt, all: true))
    #set block(above: 0pt, below: 1.2em)
    #it
  ]

  show heading.where(level: 2): it => [
    #set text(size: 12pt, weight: "bold")
    #set par(first-line-indent: (amount: 0pt, all: true))
    #set block(above: 1.2em, below: 0.8em)
    #it
  ]

  show heading.where(level: 3): it => [
    #set text(size: 12pt, style: "italic")
    #set par(first-line-indent: (amount: 0pt, all: true))
    #set block(above: 1em, below: 0.6em)
    #it
  ]

  show outline.entry.where(level: 1): set text(weight: "bold")
  show figure.caption: it => block(
    width: 100%,
    above: caption-block-spacing,
    below: caption-block-spacing,
  )[
    #align(center)[
      #set text(size: 10pt, lang: main-lang)
      #it
    ]
  ]
  show figure.where(kind: image): set figure(
    supplement: resolved-figure-supplement,
  )
  show figure.where(kind: image): set figure.caption(
    separator: [. ],
  )
  show figure.where(kind: image): it => centered-object-block(it)
  show figure.where(kind: table): set figure(
    supplement: resolved-table-supplement,
  )
  show figure.where(kind: table): set figure.caption(
    position: top,
    separator: [. ],
  )
  show figure.where(kind: table): it => centered-object-block(it)
  show figure.where(kind: "listing"): set figure(
    supplement: resolved-listing-supplement,
  )
  show figure.where(kind: "listing"): set figure.caption(
    position: top,
    separator: [. ],
  )
  show figure.where(kind: "listing"): it => full-width-object-block(it)
  show table: set text(size: 11pt)
  show table.cell: it => {
    set text(size: 10.5pt, hyphenate: false)
    set par(justify: false, first-line-indent: (amount: 0pt, all: true))
    it
  }
  show raw.where(block: true): it => block(
    fill: listing-block-fill,
    inset: listing-block-inset,
    radius: listing-block-radius,
    width: 100%,
  )[
    #set text(size: listing-font-size)
    #set par(justify: false, first-line-indent: (amount: 0pt, all: true))
    #it
  ]
  show table.cell.where(y: 0): strong
  show math.equation.where(block: true): set block(above: 6pt, below: 6pt)

  [
    #set page(numbering: none)
    #title-page(
      title-header-image,
      title-header-image-left,
      title-primary,
      title-secondary,
      authors,
      supervisor,
      degree-label-primary,
      degree-label-secondary,
      field-of-study,
      specialization,
      city,
      year,
    )

    #pagebreak(to: "odd")
    #counter(page).update(3)
    #set page(numbering: "1")

    #abstract-section(
      abstract-en-title,
      abstract-en,
      keywords-en,
      keywords-en-label,
      "en",
    )

    #pagebreak()

    #abstract-section(
      abstract-pl-title,
      abstract-pl,
      keywords-pl,
      keywords-pl-label,
      "pl",
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
