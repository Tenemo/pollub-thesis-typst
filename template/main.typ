#import "@preview/formal-pollub-thesis:0.1.0": thesis

#import "chapters/introduction.typ": introduction
#import "chapters/sample-chapter.typ": sample-chapter

#show: thesis.with(
  title: [Sample master's thesis],
  author: "Jan Kowalski",
  degree: [Master's thesis],
  university: [Politechnika Lubelska],
  faculty: [Faculty of Electrical Engineering and Computer Science],
  field: [Computer Science],
  supervisor: "dr inz. Sample Supervisor",
  city: "Lublin",
  year: "2026",
  abstract: [
    This sample document demonstrates a small reusable Typst thesis package.
    The package is intentionally minimal, but it already separates formatting
    logic from thesis content and is structured for future publication.
  ],
  keywords: ("typst", "thesis", "pollub"),
  language: "en",
)

#introduction

#sample-chapter

#bibliography("references.bib", title: [Bibliography], style: "ieee")
