#import "i18n.typ": apply-polish-typography

// Overall page
#let title-page-font = "Times New Roman"
#let title-page-language = "pl"
#let title-page-text-weight = 400
#let title-page-default-size = 12pt
#let title-page-content-left = -0.3cm
#let title-page-content-width = 15.2cm
#let title-page-par-spacing = 0pt
#let title-page-first-line-indent = (amount: 0pt, all: true)

// Header image
#let default-title-header-image = image(
  "../assets/weii_logo.jpg",
  width: 7.45cm,
)
#let title-page-header-image-top = -0.5cm

// Degree label
#let title-page-degree-top = 7cm
#let title-page-degree-primary-size = 40pt
#let title-page-degree-secondary-size = 20pt
#let title-page-degree-primary-to-secondary-gap = 0.4cm

// Study details
#let title-page-study-top = 9.2cm
#let title-page-study-size = 12pt
#let title-page-study-field-to-specialization-gap = 0.3cm
#let title-page-study-leading = 0.42em

// Thesis title
#let title-page-title-top = 12.5cm
#let title-page-title-primary-size = 20pt
#let title-page-title-secondary-size = 12pt
#let title-page-title-primary-to-secondary-gap = 0.35cm
#let title-page-title-primary-leading = 0.5em
#let title-page-title-secondary-leading = 0.45em
#let title-page-title-to-author-gap = 1.7cm

// Authors
#let title-page-author-top = 17cm
#let title-page-author-name-size = 16pt
#let title-page-author-album-size = 12pt
#let title-page-author-entry-gap = 0.5cm
#let title-page-author-to-supervisor-gap = 1.1cm
#let title-page-author-slot-authors = (
  (name: "Author", album-number: "00000"),
  (name: "Author", album-number: "00000"),
  (name: "Author", album-number: "00000"),
)
#let title-page-author-slot-count = title-page-author-slot-authors.len()

// Supervisor
#let title-page-supervisor-top = 23cm
#let title-page-supervisor-size = 12pt

// Footer
#let title-page-footer-top = 25cm
#let title-page-footer-size = 9pt
#let title-page-supervisor-to-footer-gap = 0.5cm

#let has-title-page-content(value) = value != none and value != [] and value != ""

#let title-page-text(value) = if has-title-page-content(value) {
  value
} else {
  ""
}

#let title-frame(body, size, leading) = box(width: title-page-content-width)[
  #set text(font: title-page-font, size: size, weight: title-page-text-weight)
  #set par(
    justify: false,
    spacing: title-page-par-spacing,
    leading: leading,
    first-line-indent: title-page-first-line-indent,
  )
  #body
]

#let authors-frame(authors) = box(width: title-page-content-width)[
  #set par(
    justify: false,
    spacing: title-page-par-spacing,
    first-line-indent: title-page-first-line-indent,
  )
  #for (index, author) in authors.enumerate() [
    #set text(font: title-page-font, size: title-page-author-name-size, weight: title-page-text-weight, lang: title-page-language)
    #author.at("name", default: "")
    #linebreak()
    #set text(font: title-page-font, size: title-page-author-album-size, weight: title-page-text-weight, lang: title-page-language)
    #author.at("album-number", default: "")
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
      spacing: title-page-par-spacing,
      first-line-indent: title-page-first-line-indent,
    )
    set text(font: title-page-font, size: title-page-default-size, lang: title-page-language, weight: title-page-text-weight)

    let author-count = calc.min(authors.len(), title-page-author-slot-count)
    let rendered-authors = authors.slice(0, author-count)

    let degree-frame = box(width: title-page-content-width)[
      #set par(
        justify: false,
        spacing: title-page-par-spacing,
        first-line-indent: title-page-first-line-indent,
      )
      #let has-degree-label-primary = has-title-page-content(degree-label-primary)
      #let has-degree-label-secondary = has-title-page-content(degree-label-secondary)
      #if has-degree-label-primary [
        #text(font: title-page-font, size: title-page-degree-primary-size, weight: title-page-text-weight)[
          #degree-label-primary
        ]
      ]
      #if has-degree-label-primary and has-degree-label-secondary [
        #v(title-page-degree-primary-to-secondary-gap)
      ]
      #if has-degree-label-secondary [
        #text(font: title-page-font, size: title-page-degree-secondary-size, weight: title-page-text-weight)[
          #degree-label-secondary
        ]
      ]
    ]

    let study-frame = box(width: title-page-content-width)[
      #set text(font: title-page-font, size: title-page-study-size, weight: title-page-text-weight)
      #set par(
        justify: false,
        spacing: title-page-par-spacing,
        leading: title-page-study-leading,
        first-line-indent: title-page-first-line-indent,
      )
      #let has-field-of-study = has-title-page-content(field-of-study)
      #let has-specialization = has-title-page-content(specialization)
      #if has-field-of-study [
        #block[#field-of-study]
      ]
      #if has-field-of-study and has-specialization [
        #v(title-page-study-field-to-specialization-gap)
      ]
      #if has-specialization [
        #block[specialization: #specialization]
      ]
    ]

    let titles-frame = box(width: title-page-content-width)[
      #let has-title-primary = has-title-page-content(title-primary)
      #let has-title-secondary = has-title-page-content(title-secondary)
      #if has-title-primary [
        #title-frame(title-primary, title-page-title-primary-size, title-page-title-primary-leading)
      ]
      #if has-title-primary and has-title-secondary [
        #v(title-page-title-primary-to-secondary-gap)
      ]
      #if has-title-secondary [
        #title-frame(title-secondary, title-page-title-secondary-size, title-page-title-secondary-leading)
      ]
    ]

    let author-frame = authors-frame(rendered-authors)
    let author-slot-frame = authors-frame(title-page-author-slot-authors)
    let supervisor-frame = box(width: title-page-content-width)[
      #set text(font: title-page-font, size: title-page-supervisor-size, weight: title-page-text-weight, lang: title-page-language)
      #if has-title-page-content(supervisor) [
        #apply-polish-typography([Promotor #supervisor])
      ]
    ]
    let footer-frame = box(width: title-page-content-width)[
      #set text(font: title-page-font, size: title-page-footer-size, weight: title-page-text-weight, lang: title-page-language)
      #let has-city = has-title-page-content(city)
      #let has-year = has-title-page-content(year)
      #if has-city or has-year [
        #apply-polish-typography([#title-page-text(city) #title-page-text(year)])
      ]
    ]

    let author-frame-height = measure(author-frame).height
    let author-slot-frame-height = measure(author-slot-frame).height
    let title-bottom = title-page-title-top + measure(titles-frame).height
    let author-layout-top = if rendered-authors.len() > 0 {
      title-page-author-top + author-slot-frame-height - author-frame-height
    } else {
      title-page-author-top
    }
    let ideal-author-top = calc.max(
      author-layout-top,
      title-bottom + title-page-title-to-author-gap,
    )
    let latest-supervisor-top = (
      title-page-footer-top - title-page-supervisor-to-footer-gap - measure(footer-frame).height - measure(supervisor-frame).height
    )
    let author-top = calc.min(
      ideal-author-top,
      latest-supervisor-top - title-page-author-to-supervisor-gap - author-frame-height,
    )
    let supervisor-top = if rendered-authors.len() > 0 {
      calc.max(
        title-page-supervisor-top,
        author-top + author-frame-height + title-page-author-to-supervisor-gap,
      )
    } else {
      title-page-supervisor-top
    }

    [
      #if title-header-image != none [
        #place(top + left, dx: title-page-content-left, dy: title-page-header-image-top)[
          #title-header-image
        ]
      ]

      #place(top + left, dx: title-page-content-left, dy: title-page-degree-top)[
        #degree-frame
      ]

      #place(top + left, dx: title-page-content-left, dy: title-page-study-top)[
        #study-frame
      ]

      #place(top + left, dx: title-page-content-left, dy: title-page-title-top)[
        #titles-frame
      ]

      #place(top + left, dx: title-page-content-left, dy: author-top)[
        #author-frame
      ]

      #place(top + left, dx: title-page-content-left, dy: supervisor-top)[
        #supervisor-frame
      ]

      #place(top + left, dx: title-page-content-left, dy: title-page-footer-top)[
        #footer-frame
      ]
    ]
  }
]
