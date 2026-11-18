#import "i18n.typ": apply-polish-typography

// Overall page
#let title-page-font = "Times New Roman"
#let title-page-text-weight = 400
#let title-page-default-size = 12pt
#let title-page-content-left = -0.3cm
#let title-page-content-width = 15.2cm
#let title-page-paragraph-spacing = 0pt
#let title-page-first-line-indent = (amount: 0pt, all: true)

// Header image
#let default-title-header-image = image(
  "../assets/weii-logo.jpg",
  width: 7.45cm,
)
#let title-page-header-image-top = -0.5cm

// Times New Roman metrics, in units of 2048 per em. Single line spacing puts
// baselines (ascender + descender + line gap) apart, and Typst's leading runs
// from one baseline to the cap height of the next line.
#let title-page-single-leading = (1825 + 443 + 87 - 1356) / 2048 * 1em
#let title-page-descender = 443 / 2048

// The degree label, the study details and the titles follow each other: each
// starts at its usual position, or lower when the block above it is taller, so
// a label that wraps never runs into the next block.

// Degree label
#let title-page-degree-top = 7cm
#let title-page-degree-primary-size = 40pt
#let title-page-degree-secondary-size = 20pt
#let title-page-degree-primary-to-secondary-gap = 0.4cm
#let title-page-degree-to-study-gap = 0.25cm

// Study details
#let title-page-study-top = 9.2cm
#let title-page-study-size = 12pt
#let title-page-study-field-to-specialization-gap = 0.3cm
#let title-page-study-leading = 0.42em
#let title-page-study-to-title-gap = 1cm

// Thesis titles: the faculty model gives the Polish title, then the English
// title, in the same size.
#let title-page-title-top = 12.5cm
#let title-page-title-size = 16pt
#let title-page-title-gap = 0.8cm
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
    spacing: title-page-paragraph-spacing,
    leading: leading,
    first-line-indent: title-page-first-line-indent,
  )
  #body
]

#let authors-frame(authors, lang) = box(width: title-page-content-width)[
  #set par(
    justify: false,
    spacing: title-page-paragraph-spacing,
    first-line-indent: title-page-first-line-indent,
  )
  #for (index, author) in authors.enumerate() [
    #set text(font: title-page-font, size: title-page-author-name-size, weight: title-page-text-weight, lang: lang)
    #author.at("name", default: "")
    #linebreak()
    #set text(font: title-page-font, size: title-page-author-album-size, weight: title-page-text-weight, lang: lang)
    #author.at("album-number", default: "")
    #if index + 1 < authors.len() [
      #v(title-page-author-entry-gap)
    ]
  ]
]

#let title-page(
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
) = [
  #let typeset-page-text(value) = if enable-polish-typography {
    apply-polish-typography(value)
  } else {
    value
  }
  #context {
    set par(
      justify: false,
      spacing: title-page-paragraph-spacing,
      first-line-indent: title-page-first-line-indent,
    )
    set text(font: title-page-font, size: title-page-default-size, lang: main-lang, weight: title-page-text-weight)

    // The faculty rules allow a thesis in Polish or in English, and the
    // secondary labels and title are in the other of the two languages.
    let other-lang = if main-lang == "pl" { "en" } else { "pl" }
    let author-count = calc.min(authors.len(), title-page-author-slot-count)
    let rendered-authors = authors.slice(0, author-count)
    let resolved-title-header-image-left = if title-header-image-left == none {
      title-page-content-left
    } else {
      title-header-image-left
    }

    let has-degree-label-primary = has-title-page-content(degree-label-primary)
    let has-degree-label-secondary = has-title-page-content(degree-label-secondary)
    let degree-frame = box(width: title-page-content-width)[
      #set text(font: title-page-font, weight: title-page-text-weight)
      #set par(
        justify: false,
        spacing: title-page-paragraph-spacing,
        leading: title-page-single-leading,
        first-line-indent: title-page-first-line-indent,
      )
      #if has-degree-label-primary [
        #text(size: title-page-degree-primary-size, lang: main-lang)[#degree-label-primary]
      ]
      #if has-degree-label-primary and has-degree-label-secondary [
        #v(title-page-degree-primary-to-secondary-gap)
      ]
      #if has-degree-label-secondary [
        #text(size: title-page-degree-secondary-size, lang: other-lang)[#degree-label-secondary]
      ]
    ]
    // The frame ends at the last baseline, so the gap below it also clears the
    // descenders of the last degree label line.
    let degree-last-line-size = if has-degree-label-secondary {
      title-page-degree-secondary-size
    } else {
      title-page-degree-primary-size
    }

    let study-frame = box(width: title-page-content-width)[
      #set text(font: title-page-font, size: title-page-study-size, weight: title-page-text-weight)
      #set par(
        justify: false,
        spacing: title-page-paragraph-spacing,
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
        #block[#specialization]
      ]
    ]

    let (title-polish, title-english) = if main-lang == "pl" {
      (title-primary, title-secondary)
    } else {
      (title-secondary, title-primary)
    }
    let titles-frame = box(width: title-page-content-width)[
      #let has-title-polish = has-title-page-content(title-polish)
      #let has-title-english = has-title-page-content(title-english)
      #if has-title-polish [
        #title-frame(text(lang: "pl", apply-polish-typography(title-polish)), title-page-title-size, title-page-single-leading)
      ]
      #if has-title-polish and has-title-english [
        #v(title-page-title-gap)
      ]
      #if has-title-english [
        #title-frame(text(lang: "en", title-english), title-page-title-size, title-page-single-leading)
      ]
    ]

    let author-frame = authors-frame(rendered-authors, main-lang)
    let author-slot-frame = authors-frame(title-page-author-slot-authors, main-lang)
    let supervisor-frame = box(width: title-page-content-width)[
      #set text(font: title-page-font, size: title-page-supervisor-size, weight: title-page-text-weight, lang: main-lang)
      #if has-title-page-content(supervisor) [
        #typeset-page-text([#supervisor])
      ]
    ]
    let footer-frame = box(width: title-page-content-width)[
      #set text(font: title-page-font, size: title-page-footer-size, weight: title-page-text-weight, lang: main-lang)
      #let has-city = has-title-page-content(city)
      #let has-year = has-title-page-content(year)
      #if has-city or has-year [
        #typeset-page-text([#title-page-text(city) #title-page-text(year)])
      ]
    ]

    let degree-bottom = title-page-degree-top + measure(degree-frame).height
    let study-top = calc.max(
      title-page-study-top,
      degree-bottom + title-page-descender * degree-last-line-size + title-page-degree-to-study-gap,
    )
    let study-bottom = study-top + measure(study-frame).height
    let title-top = calc.max(
      title-page-title-top,
      study-bottom + title-page-descender * title-page-study-size + title-page-study-to-title-gap,
    )

    let author-frame-height = measure(author-frame).height
    let author-slot-frame-height = measure(author-slot-frame).height
    let title-bottom = title-top + measure(titles-frame).height
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
        #place(top + left, dx: resolved-title-header-image-left, dy: title-page-header-image-top)[
          #title-header-image
        ]
      ]

      #place(top + left, dx: title-page-content-left, dy: title-page-degree-top)[
        #degree-frame
      ]

      #place(top + left, dx: title-page-content-left, dy: study-top)[
        #study-frame
      ]

      #place(top + left, dx: title-page-content-left, dy: title-top)[
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
