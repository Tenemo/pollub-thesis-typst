#import "title-page.typ": title-page

#let thesis(
  body,
  title: [Sample master's thesis],
  author: "Jan Kowalski",
  degree: [Master's thesis],
  university: [Politechnika Lubelska],
  faculty: [Faculty of Electrical Engineering and Computer Science],
  field: [Computer Science],
  supervisor: "dr inz. Sample Supervisor",
  city: "Lublin",
  year: "2026",
  abstract: none,
  keywords: (),
  language: "en",
  abstract-title: [Abstract],
  outline-title: [Table of contents],
  keywords-label: [Keywords:],
) = {
  set document(title: title, author: author, keywords: keywords)
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2.5cm),
    number-align: center + bottom,
  )
  set text(lang: language, size: 11pt)
  set par(justify: true, leading: 0.7em)

  show heading.where(level: 1): set text(size: 15pt, weight: "bold")
  show heading.where(level: 2): set text(size: 12pt, weight: "bold")

  [
    #set page(numbering: none)
    #title-page(
      title,
      author,
      degree,
      university,
      faculty,
      field,
      supervisor,
      city,
      year,
    )

    #pagebreak()
    #counter(page).update(1)
    #set page(numbering: "1")

    #if abstract != none [
      = #abstract-title
      #abstract

      #if keywords.len() > 0 [
        #v(1em)
        *#keywords-label* #keywords.join(", ")
      ]

      #pagebreak()
    ]

    #outline(title: outline-title)
    #pagebreak()

    #body
  ]
}
