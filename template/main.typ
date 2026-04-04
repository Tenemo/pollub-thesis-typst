#import "@preview/pollub-thesis:0.1.0": thesis

#import "chapters/chapter1.typ": chapter1
#import "chapters/chapter2.typ": chapter2

#show: thesis.with(
  main-lang: "pl",
  title-pl: [Charakterystyka układu chłodzenia termoelektrycznego w funkcji prądu sterującego],
  title-en: [Characterisation of a thermoelectric cooling setup as a function of drive current],
  authors: ((name: "inż. Jan Kowalski", album-number: "123456"),),
  supervisor: "Dr inż. Jan Nowak",
  degree-label: ([Praca dyplomowa], [magisterska]),
  field-of-study: [na kierunku Informatyka],
  diploma-block: [na bloku dyplomowania Aplikacje Internetowe],
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
)

#chapter1
#chapter2

#pagebreak()
#bibliography("references.bib", style: "apa", title: [Bibliografia])
