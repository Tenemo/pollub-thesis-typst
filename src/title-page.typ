#import "i18n.typ": apply-polish-typography

#let default-title-header-image = image(
  "../assets/weii_logo.jpg",
  width: 7.45cm,
)

#let title-page-font = "Times New Roman"

#let title-page-left = -0.3cm
#let title-page-width = 15.2cm
#let title-page-logo-top = -0.45cm
#let title-page-degree-top = 5.87cm
#let title-page-study-top = 8.5cm
#let title-page-titles-top = 12.07cm
#let title-page-author-top = 17.19cm
#let title-page-supervisor-top = 23.38cm
#let title-page-footer-top = 25.61cm
#let title-page-title-to-author-gap = 1.7cm
#let title-page-author-entry-gap = 0.8cm
#let title-page-author-to-supervisor-gap = 1.1cm
#let title-page-footer-gap = 0.8cm
#let title-page-degree-primary-size = 40pt
#let title-page-degree-secondary-size = 20pt
#let title-page-degree-secondary-gap = 0.5cm
#let title-page-title-primary-size = 16pt
#let title-page-title-secondary-size = 11pt
#let title-page-study-size = 11pt
#let title-page-study-line-gap = 0.25cm
#let title-page-title-leading = 0.5em
#let title-page-title-secondary-leading = 0.45em
#let title-page-study-leading = 0.42em

#let has-title-page-content(value) = value != none and value != [] and value != ""

#let title-frame(body, size, leading) = box(width: title-page-width)[
  #set text(font: title-page-font, size: size, weight: 400)
  #set par(
    justify: false,
    spacing: 0pt,
    leading: leading,
    first-line-indent: (amount: 0pt, all: true),
  )
  #body
]

#let authors-frame(authors) = box(width: title-page-width)[
  #set par(
    justify: false,
    spacing: 0pt,
    first-line-indent: (amount: 0pt, all: true),
  )
  #for (index, author) in authors.enumerate() [
    #set text(font: title-page-font, size: 16pt, weight: 400, lang: "pl")
    #author.at("name", default: "")
    #linebreak()
    #set text(font: title-page-font, size: 12pt, weight: 400, lang: "pl")
    numer albumu #author.at("album-number", default: "")
    #if index + 1 < authors.len() [
      #v(title-page-author-entry-gap)
    ]
  ]
]

#let title-page(
  title-header-image,
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
) = [
  #context {
    set par(
      justify: false,
      spacing: 0pt,
      first-line-indent: (amount: 0pt, all: true),
    )
    set text(font: title-page-font, size: 12pt, lang: "pl", weight: 400)

    let author-count = calc.min(calc.max(authors.len(), 1), 3)
    let rendered-authors = if authors.len() == 0 {
      ((name: "", album-number: ""),)
    } else {
      authors.slice(0, author-count)
    }

    let degree-frame = box(width: title-page-width)[
      #set par(
        justify: false,
        spacing: 0pt,
        first-line-indent: (amount: 0pt, all: true),
      )
      #let has-degree-label-primary = has-title-page-content(degree-label-primary)
      #let has-degree-label-secondary = has-title-page-content(degree-label-secondary)
      #if has-degree-label-primary [
        #text(font: title-page-font, size: title-page-degree-primary-size, weight: 400)[
          #degree-label-primary
        ]
      ]
      #if has-degree-label-primary and has-degree-label-secondary [
        #v(title-page-degree-secondary-gap)
      ]
      #if has-degree-label-secondary [
        #text(font: title-page-font, size: title-page-degree-secondary-size, weight: 400)[
          #degree-label-secondary
        ]
      ]
    ]

    let study-frame = box(width: title-page-width)[
      #set text(font: title-page-font, size: title-page-study-size, weight: 400)
      #set par(
        justify: false,
        spacing: 0pt,
        leading: title-page-study-leading,
        first-line-indent: (amount: 0pt, all: true),
      )
      #let has-field-of-study = has-title-page-content(field-of-study)
      #let has-specialization = has-title-page-content(specialization)
      #if has-field-of-study [
        #block[#field-of-study]
      ]
      #if has-field-of-study and has-specialization [
        #v(title-page-study-line-gap)
      ]
      #if has-specialization [
        #block[specialization: #specialization]
      ]
    ]

    let titles-frame = box(width: title-page-width)[
      #let has-title-primary = has-title-page-content(title-primary)
      #let has-title-secondary = has-title-page-content(title-secondary)
      #if has-title-primary [
        #title-frame(title-primary, title-page-title-primary-size, title-page-title-leading)
      ]
      #if has-title-primary and has-title-secondary [
        #v(0.35cm)
      ]
      #if has-title-secondary [
        #title-frame(title-secondary, title-page-title-secondary-size, title-page-title-secondary-leading)
      ]
    ]

    let author-frame = authors-frame(rendered-authors)
    let supervisor-frame = box(width: title-page-width)[
      #set text(font: title-page-font, size: 12pt, weight: 400, lang: "pl")
      #apply-polish-typography([Promotor #supervisor])
    ]
    let footer-frame = box(width: title-page-width)[
      #set text(font: title-page-font, size: 9pt, weight: 400, lang: "pl")
      #apply-polish-typography([#city #year])
    ]

    let title-bottom = title-page-titles-top + measure(titles-frame).height
    let ideal-author-top = calc.max(
      title-page-author-top,
      title-bottom + title-page-title-to-author-gap,
    )
    let latest-supervisor-top = (
      title-page-footer-top - title-page-footer-gap - measure(footer-frame).height - measure(supervisor-frame).height
    )
    let author-top = calc.min(
      ideal-author-top,
      latest-supervisor-top - title-page-author-to-supervisor-gap - measure(author-frame).height,
    )
    let supervisor-top = calc.max(
      title-page-supervisor-top,
      author-top + measure(author-frame).height + title-page-author-to-supervisor-gap,
    )

    [
      #if title-header-image != none [
        #place(top + left, dx: title-page-left, dy: title-page-logo-top)[
          #title-header-image
        ]
      ]

      #place(top + left, dx: title-page-left, dy: title-page-degree-top)[
        #degree-frame
      ]

      #place(top + left, dx: title-page-left, dy: title-page-study-top)[
        #study-frame
      ]

      #place(top + left, dx: title-page-left, dy: title-page-titles-top)[
        #titles-frame
      ]

      #place(top + left, dx: title-page-left, dy: author-top)[
        #author-frame
      ]

      #place(top + left, dx: title-page-left, dy: supervisor-top)[
        #supervisor-frame
      ]

      #place(top + left, dx: title-page-left, dy: title-page-footer-top)[
        #footer-frame
      ]
    ]
  }
]
