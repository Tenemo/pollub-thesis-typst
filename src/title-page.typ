#let default-title-header-image = image(
  "../assets/weii_logo.jpg",
  width: 155.9pt,
)

#let title-page-origin-x = 3.5cm
#let title-page-origin-y = 2.5cm
#let official-note-line-1-x = 254.93pt - title-page-origin-x
#let official-note-line-1-y = 36.34pt - title-page-origin-y
#let official-note-line-2-x = 281.11pt - title-page-origin-x
#let official-note-line-2-y = 47.86pt - title-page-origin-y
#let official-x-left = 90.86pt - title-page-origin-x
#let official-logo-x = 83.9pt - title-page-origin-x
#let official-logo-y = 58.6pt - title-page-origin-y
#let official-footer-x = 90.98pt - title-page-origin-x
#let official-degree-y-1 = 237.11pt - title-page-origin-y
#let official-degree-y-2 = 281.51pt - title-page-origin-y
#let official-study-y = 341.26pt - title-page-origin-y
#let official-block-y = 359.26pt - title-page-origin-y
#let official-title-pl-y = 413.06pt - title-page-origin-y
#let official-title-en-y = 459.38pt - title-page-origin-y
#let official-author-y = 557.81pt - title-page-origin-y
#let official-author-slot = 54.72pt
#let official-author-album-offset = 29.5pt
#let official-supervisor-y = 733.73pt - title-page-origin-y
#let official-footer-y = 797.23pt - title-page-origin-y
#let official-title-width = 430pt
#let minimum-title-language-gap = 12pt
#let minimum-title-to-author-gap = 6pt
#let minimum-author-to-supervisor-gap = 12pt
#let minimum-footer-gap = 8pt

#let title-block(body, lang: "pl") = box(width: official-title-width)[
  #set text(font: "Arial", size: 15.96pt, weight: 400, lang: lang)
  #set par(justify: false, spacing: 0pt, leading: 1.11em)
  #body
]

#let title-page(
  title-header-image,
  title-note,
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
  #context {
    set par(justify: false, spacing: 0pt)
    set text(font: "Arial", size: 12pt, lang: "pl", weight: 400)

    let author-count = calc.min(calc.max(authors.len(), 1), 3)
    let rendered-authors = if authors.len() == 0 {
      ((name: "", album-number: ""),)
    } else {
      authors.slice(0, author-count)
    }
    let degree-line-1 = if type(degree-label) == array {
      degree-label.at(0, default: [])
    } else {
      [Praca dyplomowa]
    }
    let degree-line-2 = if type(degree-label) == array {
      degree-label.at(1, default: [])
    } else {
      degree-label
    }
    let pl-title-frame = title-block(title-pl, lang: "pl")
    let en-title-frame = title-block(title-en, lang: "en")
    let pl-title-height = measure(pl-title-frame).height
    let en-title-height = measure(en-title-frame).height
    let title-en-y = calc.max(
      official-title-en-y,
      official-title-pl-y + pl-title-height + minimum-title-language-gap,
    )
    let title-bottom-y = title-en-y + en-title-height
    let author-block-height = (author-count - 1) * official-author-slot + official-author-album-offset
    let supervisor-frame = box[
      #text(font: "Arial", size: 12pt, lang: "pl", weight: 400)[Promotor #supervisor]
    ]
    let footer-frame = box[
      #text(font: "Arial", size: 9pt, lang: "pl", weight: 400)[#city #year]
    ]
    let author-start-y = calc.min(
      calc.max(official-author-y, title-bottom-y + minimum-title-to-author-gap),
      official-footer-y
        - minimum-footer-gap
        - measure(footer-frame).height
        - measure(supervisor-frame).height
        - minimum-author-to-supervisor-gap
        - author-block-height,
    )
    let supervisor-y = calc.max(
      official-supervisor-y,
      author-start-y + author-block-height + minimum-author-to-supervisor-gap,
    )

    [
      #if title-header-image != none [
        #place(top + left, dx: official-logo-x, dy: official-logo-y)[
          #title-header-image
        ]
      ] else [
        #place(top + left, dx: official-logo-x, dy: official-logo-y)[
          #set text(size: 12pt, weight: 700)
          #align(left)[
            #university \
            #faculty-short \
            #faculty
          ]
        ]
      ]

      #if title-note != none [
        #let note-lines = if type(title-note) == array {
          title-note
        } else {
          (title-note,)
        }
        #place(top + left, dx: official-note-line-1-x, dy: official-note-line-1-y)[
          #set text(font: "Arial", size: 9.96pt, lang: "pl", weight: 400)
          #note-lines.at(0, default: [])
        ]
        #if note-lines.len() > 1 [
          #place(top + left, dx: official-note-line-2-x, dy: official-note-line-2-y)[
            #set text(font: "Arial", size: 9.96pt, lang: "pl", weight: 400)
            #note-lines.at(1, default: [])
          ]
        ]
      ]

      #place(top + left, dx: official-x-left, dy: official-degree-y-1)[
        #set text(font: "Arial", size: 39.96pt, weight: 400, lang: "pl")
        #degree-line-1
      ]
      #place(top + left, dx: official-x-left, dy: official-degree-y-2)[
        #set text(font: "Arial", size: 39.96pt, weight: 400, lang: "pl")
        #degree-line-2
      ]

      #place(top + left, dx: official-x-left, dy: official-study-y)[
        #set text(font: "Arial", size: 12pt, weight: 400, lang: "pl")
        #field-of-study
      ]
      #place(top + left, dx: official-x-left, dy: official-block-y)[
        #set text(font: "Arial", size: 12pt, weight: 400, lang: "pl")
        #diploma-block
      ]

      #place(top + left, dx: official-x-left, dy: official-title-pl-y)[
        #pl-title-frame
      ]
      #place(top + left, dx: official-x-left, dy: title-en-y)[
        #en-title-frame
      ]

      #for (index, author) in rendered-authors.enumerate() [
        #let y = author-start-y + index * official-author-slot
        #place(top + left, dx: official-x-left, dy: y)[
          #set text(font: "Arial", size: 15.96pt, weight: 400, lang: "pl")
          #author.at("name", default: "")
        ]
        #place(top + left, dx: official-x-left, dy: y + official-author-album-offset)[
          #set text(font: "Arial", size: 12pt, weight: 400, lang: "pl")
          numer albumu #author.at("album-number", default: "")
        ]
      ]

      #place(top + left, dx: official-x-left, dy: supervisor-y)[
        #set text(font: "Arial", size: 12pt, weight: 400, lang: "pl")
        Promotor #supervisor
      ]

      #place(top + left, dx: official-footer-x, dy: official-footer-y)[
        #text(font: "Arial", size: 9pt, lang: "pl", weight: 400)[#city #year]
      ]
    ]
  }
]
