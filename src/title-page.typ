#let title-page(
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
) = [
  #set par(justify: false, spacing: 0pt)
  #set text(font: "Arial", size: 12pt)

  #text(weight: "bold")[#university]
  #faculty-short \
  #faculty

  #v(4.2cm)

  #set text(size: 32pt)
  #degree-label

  #v(0.7cm)

  #set text(size: 12pt)
  #field-of-study \
  #diploma-block

  #v(1.2cm)

  #set text(size: 18pt, weight: "bold")
  #title-pl

  #v(0.4cm)

  #set text(size: 16pt, weight: "regular")
  #title-en

  #v(1.8cm)

  #set text(size: 12pt)
  #author \
  numer albumu #album-number

  #v(1.5cm)

  Promotor #supervisor

  #place(bottom + left)[#city #year]
]
