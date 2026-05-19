#import "chapters/chapter1.typ": chapter1
#import "chapters/chapter2.typ": chapter2

#let local-template-preview = sys.inputs.at("local-template-preview", default: "false") == "true"

#let template-document(thesis) = [
  #show: thesis.with(
    main-lang: "pl",
    title-primary: "Characterisation of a thermoelectric cooling setup as a function of drive current",
    title-secondary: "Charakterystyka układu chłodzenia termoelektrycznego w funkcji prądu sterującego",
    authors: (
      (name: "inż. Jan Kowalski", album-number: "123456"),
      (name: "inż. Anna Nowak", album-number: "123457"),
      (name: "inż. Piotr Zieliński", album-number: "123458"),
    ),
    supervisor: "dr inż. Jan Nowak",
    degree-label-primary: "Master's thesis",
    degree-label-secondary: "Praca dyplomowa magisterska",
    field-of-study: "in the field of computer science",
    specialization: "data science",
    city: "Lublin",
    year: "2026",
    abstract-pl: [
      Praca przedstawia przykładowy układ pracy dyplomowej dla WEII, Wydziału
      Elektrotechniki i Informatyki, Politechniki Lubelskiej. Dokument pokazuje
      stronę tytułową, dwujęzyczne streszczenia, numerację rozdziałów, rysunki,
      tabele, listingi oraz bibliografię zgodną z APA 7.
    ],
    keywords-pl: ("typst", "WEII", "POLLUB", "układ termoelektryczny"),
    abstract-en: [
      This document demonstrates a Typst thesis template for WEII, Wydział
      Elektrotechniki i Informatyki, Politechnika Lubelska. The sample shows the
      title page, bilingual abstracts, chapter numbering, figures, tables,
      listings, and a single APA 7 bibliography on a compact two-chapter example.
    ],
    keywords-en: ("typst", "WEII", "POLLUB", "thermoelectric cooling"),
    // defaults to true for a screen-reading PDF with symmetric side margins.
    // set to false for the final print and binding layout.
    screen-mode: true,
  )

  #chapter1
  #chapter2

  #pagebreak()
  #bibliography("references.bib", style: "apa.csl", title: [Bibliografia])
]

#if local-template-preview {
  import "../lib.typ": thesis
  template-document(thesis)
} else {
  import "@preview/pollub-thesis:0.1.0": thesis
  template-document(thesis)
}
