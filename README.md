# pollub-thesis

jump to: [english](#english) | [polski](#polski)

## english

`pollub-thesis` is a Typst thesis template for WEII, Wydział Elektrotechniki i Informatyki, Politechnika Lubelska. It provides a WEII title page, bilingual abstract pages, chapter-based numbering for figures/tables/listings/equations, and thesis layout defaults aligned with the faculty guidelines.

### usage notes

- exports `thesis` and `listing`
- requires Typst `0.14.0+` and `Times New Roman`
- use local import during development:

```typst
#import "../pollub-thesis-typst/lib.typ": thesis, listing
```

- use package import after publishing:

```typst
#import "@preview/pollub-thesis:0.1.0": thesis, listing
```

- `main-lang` controls the body language and localized labels
- `screen-mode` defaults to `true` for symmetric side margins on screen; set it to `false` for the final print and binding layout
- `authors` expects 1 to 3 records with `name` and `album-number`
- `symbols-list` is optional and is inserted between the table of contents and chapter 1
- separate lists of figures, tables, and formulas are intentionally omitted
- add the bibliography explicitly at the end of the document

### minimal example

```typst
#import "../pollub-thesis-typst/lib.typ": thesis, listing

#show: thesis.with(
  main-lang: "pl",
  title-pl: [Polski tytuł pracy],
  title-en: [English thesis title],
  authors: ((name: "Jan Kowalski", album-number: "123456"),),
  supervisor: "dr inż. Jan Nowak",
  field-of-study: [na kierunku Informatyka],
  diploma-block: [na bloku dyplomowania Aplikacje Internetowe],
  screen-mode: true,
)

= Wstęp
Tekst pracy.

#pagebreak()
#bibliography("references.bib", style: "apa", title: [Bibliografia])
```

## polski

`pollub-thesis` to szablon pracy dyplomowej w Typst dla WEII, Wydziału Elektrotechniki i Informatyki, Politechniki Lubelskiej. Zapewnia stronę tytułową WEII, dwujęzyczne strony ze streszczeniami, numerację rysunków/tabel/listingów/równań w obrębie rozdziałów oraz domyślny układ pracy zgodny z wytycznymi wydziału.

### uwagi dotyczące użycia

- eksportuje `thesis` i `listing`
- wymaga Typst `0.14.0+` oraz `Times New Roman`
- w trakcie lokalnej pracy używaj importu:

```typst
#import "../pollub-thesis-typst/lib.typ": thesis, listing
```

- po publikacji używaj importu pakietu:

```typst
#import "@preview/pollub-thesis:0.1.0": thesis, listing
```

- `main-lang` steruje językiem treści i lokalizowanymi etykietami
- `screen-mode` domyślnie ma wartość `true`, aby dać symetryczne marginesy boczne do czytania na ekranie; ustaw `false` dla końcowego układu do druku i oprawy
- `authors` oczekuje od 1 do 3 rekordów z polami `name` i `album-number`
- `symbols-list` jest opcjonalny i trafia między spis treści a rozdział 1
- osobne spisy rysunków, tabel i wzorów są celowo pominięte
- bibliografię dodaj jawnie na końcu dokumentu

### minimalny przykład

```typst
#import "../pollub-thesis-typst/lib.typ": thesis, listing

#show: thesis.with(
  main-lang: "pl",
  title-pl: [Polski tytuł pracy],
  title-en: [English thesis title],
  authors: ((name: "Jan Kowalski", album-number: "123456"),),
  supervisor: "dr inż. Jan Nowak",
  field-of-study: [na kierunku Informatyka],
  diploma-block: [na bloku dyplomowania Aplikacje Internetowe],
  screen-mode: true,
)

= Wstęp
Tekst pracy.

#pagebreak()
#bibliography("references.bib", style: "apa", title: [Bibliografia])
```
