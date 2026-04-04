#let bibliography-entry(number, body) = grid(
  columns: (auto, 1fr),
  gutter: 0.6em,
  align: (left, top),
  [#("[" + str(number) + "]")],
  body,
)

#let format-scientific-entry(entry) = {
  let author = entry.at("author", default: "Unknown author")
  let title = entry.at("title", default: "Untitled")
  let date = entry.at("date", default: none)
  let parent = entry.at("parent", default: (:))
  let journal = parent.at("title", default: none)

  [
    #author
    #if title != none [
      #(". \"" + title + "\"")
    ]
    #if journal != none [
      #(". In: ")
      #emph[#journal]
    ]
    #if date != none [
      #(" (" + str(date) + ").")
    ] else [
      #(".")
    ]
  ]
}

#let format-online-entry(entry) = {
  let author = entry.at("author", default: none)
  let title = entry.at("title", default: "Untitled")
  let url = entry.at("url", default: none)

  [
    #if author != none [
      #(author + ". ")
    ]
    #(title + ".")
    #if url != none [
      #(" url: ")
      #link(url)
    ]
  ]
}

#let render-bibliography(
  references,
  scientific-title: [Scientific sources],
  online-title: [Online sources],
) = context {
  let seen = (:)
  let scientific = ()
  let online = ()
  let number = 0

  for citation in query(cite) {
    let key = str(citation.key)

    if seen.at(key, default: false) {
      continue
    }

    seen.insert(key, true)
    number += 1

    let entry = references.at(key, default: none)
    if entry == none {
      continue
    }

    let row = (number: number, entry: entry)
    if entry.at("url", default: none) != none {
      online.push(row)
    } else {
      scientific.push(row)
    }
  }

  [
    #if scientific.len() > 0 [
      #text(size: 15pt, weight: "bold")[#scientific-title]
      #parbreak()
      #for row in scientific [
        #bibliography-entry(row.number, format-scientific-entry(row.entry))
        #parbreak()
      ]
    ]

    #if online.len() > 0 [
      #if scientific.len() > 0 [
        #v(1.5em)
      ]
      #text(size: 15pt, weight: "bold")[#online-title]
      #parbreak()
      #for row in online [
        #bibliography-entry(row.number, format-online-entry(row.entry))
        #parbreak()
      ]
    ]
  ]
}
