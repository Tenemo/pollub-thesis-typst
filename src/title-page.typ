#let title-page(
  title,
  author,
  degree,
  university,
  faculty,
  field,
  supervisor,
  city,
  year,
) = [
  #set par(justify: false)

  #align(center)[
    #v(2.5cm)
    #text(size: 18pt, weight: "bold")[#university]
    #v(0.75em)
    #text(size: 11pt)[#faculty]
    #v(0.5em)
    #text(size: 11pt)[#field]
  ]

  #v(5cm)

  #align(center)[
    #text(size: 22pt, weight: "bold")[#title]
    #v(1em)
    #text(size: 14pt, weight: "semibold")[#degree]
  ]

  #v(4cm)

  #grid(
    columns: (1fr, 1fr),
    gutter: 1.5cm,
    [
      *Author:* \
      #author
    ],
    [
      *Supervisor:* \
      #supervisor
    ],
  )

  #v(5cm)

  #align(center)[#city, #year]
]
