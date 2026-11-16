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

// The faculty rules require 1.5 line spacing for the 12 pt body text. In a
// word processor, single spacing of Times New Roman is its ascender plus
// descender plus line gap, (1825 + 443 + 87) / 2048 em, so 1.5 spacing puts
// the baselines 1.5 times that apart, about 20.7 pt at 12 pt. Typst's leading
// is measured from the baseline of one line to the cap height of the next
// (default `top-edge` and `bottom-edge`), and the cap height of Times New Roman
// is 1356 / 2048 em, so the leading is the baseline distance minus the cap
// height.
#let body-leading = (1.5 * (1825 + 443 + 87) - 1356) / 2048 * 1em
#let body-par-spacing = body-leading
// Captions, table cells, listings and footnotes are not body text and keep the
// tighter spacing they had before the body text moved to 1.5 spacing.
#let compact-leading = 0.7em
#let abstract-gap = 2em
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
  screen-mode: false,
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
  // A set rule inside an `if` block would end with that block, so the mode
  // selects the margins inside one set rule that applies to the whole document.
  set page(
    paper: "a4",
    binding: left,
    margin: if screen-mode {
      (
        top: 2.5cm,
        bottom: 2cm,
        left: screen-side-margin,
        right: screen-side-margin,
      )
    } else {
      (
        top: 2.5cm,
        bottom: 2cm,
        inside: 3.5cm,
        outside: 2cm,
      )
    },
    number-align: center + bottom,
  )
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
  set list(indent: 0.85cm)
  set enum(indent: 0.85cm)
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
      #counter(math.equation).update(0)
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
      #set par(leading: compact-leading)
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
    set text(hyphenate: false)
    set par(justify: false, leading: compact-leading, first-line-indent: (amount: 0pt, all: true))
    it
  }
  show raw.where(block: true): it => block(
    fill: listing-block-fill,
    inset: listing-block-inset,
    radius: listing-block-radius,
    width: 100%,
  )[
    #set text(size: listing-font-size)
    #set par(justify: false, leading: compact-leading, first-line-indent: (amount: 0pt, all: true))
    #it
  ]
  show table.cell.where(y: 0): strong
  show footnote.entry: set par(leading: compact-leading)
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
      main-lang,
      enable-polish-typography,
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

    // The faculty rules limit both abstracts and keyword lists to one page.
    #v(abstract-gap)

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
