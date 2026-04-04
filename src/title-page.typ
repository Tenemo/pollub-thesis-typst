#let default-title-header-image = image(
  "../assets/weii-title-header.jpg",
  width: 7cm,
)

#let author-block(author) = [
  #set text(size: 16pt, weight: "regular")
  #author.at("name", default: "")
  #v(0.25cm)
  #set text(size: 12pt)
  numer albumu #author.at("album-number", default: "")
]

#let title-page(
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
) = [
  #set par(justify: false, spacing: 0pt)
  #set text(font: "Arial", size: 12pt, lang: "pl")

  #let author-count = calc.min(calc.max(authors.len(), 1), 3)
  #let rendered-authors = if authors.len() == 0 {
    ((name: "", album-number: ""),)
  } else {
    authors.slice(0, author-count)
  }
  #let leading-gap = if author-count == 1 {
    2.35cm
  } else if author-count == 2 {
    1.45cm
  } else {
    0.75cm
  }
  #let between-authors = if author-count == 3 { 0.6cm } else { 0.95cm }

  #pad(left: -0.3cm)[
    #if title-header-image != none [
      #move(dx: -0.25cm)[#title-header-image]
    ] else [
      #text(weight: "bold")[#university]
      #faculty-short \
      #faculty
    ]

    #v(4.05cm)

    #set text(size: 40pt, weight: "regular")
    #set par(leading: -0.04em, spacing: 0pt)
    #degree-label

    #v(0.45cm)

    #set text(size: 12pt)
    #set par(leading: 0.15em, spacing: 0pt)
    #field-of-study \
    #diploma-block

    #v(1.15cm)

    #set text(size: 16pt, weight: "regular")
    #title-pl

    #v(0.65cm)

    #title-en

    #v(leading-gap)

    #for (index, author) in rendered-authors.enumerate() [
      #author-block(author)
      #if index + 1 < author-count [
        #v(between-authors)
      ]
    ]

    #v(0.85cm)

    #set text(size: 12pt)
    Promotor #supervisor
  ]

  #place(bottom + left, dx: -0.3cm)[
    #text(font: "Arial", size: 9pt, lang: "pl")[#city #year]
  ]
]
