#import "title-page.typ": title-page

#let sectioned-numbering(n) = context {
  let section = counter(heading.where(level: 1)).get().at(0, default: 0)
  numbering("1.1", section, n)
}

#let centered-caption(it) = align(center)[
  #set text(size: 12pt)
  #it.supplement #context it.counter.display(it.numbering)#it.separator #it.body
]

#let abstract-section(
  title,
  body,
  keywords,
  keywords-label,
) = [
  #set par(justify: true, spacing: 0pt)
  #text(size: 15pt, weight: "bold")[#title]
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
  author: "Jan Kowalski",
  album-number: "000000",
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
  outline-title: [Table of contents],
  abstract-pl-title: [Streszczenie],
  abstract-en-title: [Abstract],
  keywords-pl-label: [Słowa kluczowe:],
  keywords-en-label: [Keywords:],
) = {
  set document(
    title: title-en,
    author: author,
    keywords: keywords-en,
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
    lang: "en",
  )
  set par(
    justify: true,
    spacing: 0pt,
    leading: 0.5em,
    first-line-indent: (amount: 1.25em, all: true),
  )
  set heading(numbering: "1.1")
  set figure(numbering: sectioned-numbering)
  set table(
    stroke: 0.5pt,
    inset: (x: 5pt, y: 4pt),
    align: left,
  )

  show heading.where(level: 1): it => [
    #let section-number = counter(heading.where(level: 1)).get().at(0, default: 0)
    #if section-number > 1 [
      #pagebreak()
    ]
    #counter(figure.where(kind: image)).update(0)
    #counter(figure.where(kind: table)).update(0)
    #counter(figure.where(kind: "listing")).update(0)
    #set text(size: 15pt, weight: "bold")
    #set block(above: 0pt, below: 1.2em)
    #it
  ]

  show heading.where(level: 2): it => [
    #set text(size: 12pt, weight: "bold")
    #set block(above: 1.2em, below: 0.8em)
    #it
  ]

  show outline.entry.where(level: 1): set text(weight: "bold")
  show figure: set block(above: 1em, below: 1em)
  show figure.caption: centered-caption
  show figure.where(kind: table): it => block(width: 100%)[
    #if it.caption != none [
      #it.caption
      #v(0.9em)
    ]
    #it.body
  ]
  show figure.where(kind: "listing"): it => block(width: 100%)[
    #if it.caption != none [
      #it.caption
      #v(0.9em)
    ]
    #it.body
  ]
  show raw.where(block: true): it => block(width: 100%)[
    #set text(size: 10pt)
    #it
  ]
  show table.cell.where(y: 0): strong

  [
    #set page(numbering: none)
    #title-page(
      university,
      faculty-short,
      faculty,
      title-pl,
      title-en,
      author,
      album-number,
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
    )

    #v(1.5em)

    #abstract-section(
      abstract-en-title,
      abstract-en,
      keywords-en,
      keywords-en-label,
    )

    #pagebreak()

    #outline(title: outline-title, depth: 2)

    #pagebreak()
    #body
  ]
}
