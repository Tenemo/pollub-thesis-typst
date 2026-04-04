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
#let title-page-study-top = 9.54cm
#let title-page-titles-top = 12.07cm
#let title-page-author-top = 17.19cm
#let title-page-supervisor-top = 23.38cm
#let title-page-footer-top = 25.61cm
#let title-page-title-gap = 0.85cm
#let title-page-title-to-author-gap = 1.7cm
#let title-page-author-entry-gap = 0.8cm
#let title-page-author-to-supervisor-gap = 1.1cm
#let title-page-footer-gap = 0.8cm

#let title-frame(body, lang: "pl") = box(width: title-page-width)[
  #set text(font: title-page-font, size: 16pt, weight: 400, lang: lang)
  #set par(
    justify: false,
    spacing: 0pt,
    leading: 0.28em,
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
      #text(font: title-page-font, size: 40pt, weight: 400, lang: "pl")[
        #apply-polish-typography(degree-label.at(0, default: []))
      ]
      #v(0.4cm)
      #text(font: title-page-font, size: 40pt, weight: 400, lang: "pl")[
        #apply-polish-typography(degree-label.at(1, default: []))
      ]
    ]

    let study-frame = box(width: title-page-width)[
      #set text(font: title-page-font, size: 12pt, weight: 400, lang: "pl")
      #set par(
        justify: false,
        spacing: 0pt,
        leading: 0.24em,
        first-line-indent: (amount: 0pt, all: true),
      )
      #apply-polish-typography(field-of-study)
      #linebreak()
      #apply-polish-typography(diploma-block)
    ]

    let titles-frame = box(width: title-page-width)[
      #title-frame(apply-polish-typography(title-pl), lang: "pl")
      #if title-en != none and title-en != [] [
        #v(title-page-title-gap)
        #title-frame(title-en, lang: "en")
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
    let latest-supervisor-top = title-page-footer-top - title-page-footer-gap - measure(footer-frame).height - measure(supervisor-frame).height
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
