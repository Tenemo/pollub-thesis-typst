# Lublin University of Technology (pollub) thesis Typst template

Your thesis is in Polish? Jump to: [polski](#polski)

## English

`pollub-thesis` is a Typst thesis template for the Lublin University of Technology, specifically Wydział Elektrotechniki i Informatyki. It provides a WEII title page, bilingual abstract pages, chapter-based numbering for figures/tables/listings/equations, and thesis layout defaults aligned with the faculty guidelines.

Current rendered preview: [template-preview.pdf](./template-preview.pdf)

### Usage notes

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
- use the bundled `apa.csl` for bibliography formatting
- `apa.csl` is an unmodified copy of the official APA CSL from `https://github.com/citation-style-language/styles/blob/master/apa.csl`
- `symbols-list` is optional and is inserted between the table of contents and chapter 1
- separate lists of figures, tables, and formulas are intentionally omitted
- add the bibliography explicitly at the end of the document

### Minimal example

```typst
#import "../pollub-thesis-typst/lib.typ": thesis, listing

#show: thesis.with(
  main-lang: "en",
  title-primary: "English thesis title",
  title-secondary: "Polish thesis title",
  authors: ((name: "John Smith", album-number: "123456"),),
  supervisor: "Supervisor: dr Jan Nowak",
  degree-label-primary: "Master's thesis",
  degree-label-secondary: "Praca dyplomowa magisterska",
  field-of-study: "in the field of Computer Science",
  specialization: "Data science",
  screen-mode: true,
)

= Introduction
Thesis text.

#pagebreak()
#bibliography("references.bib", style: "apa.csl", title: [Bibliography])
```

## Polski

`pollub-thesis` to szablon pracy dyplomowej w Typst dla Politechniki Lubelskiej, a dokładniej dla Wydziału Elektrotechniki i Informatyki. Zapewnia stronę tytułową WEII, dwujęzyczne strony ze streszczeniami, numerację rysunków/tabel/listingów/równań w obrębie rozdziałów oraz domyślne ustawienia układu pracy zgodne z wytycznymi wydziału.

Aktualny podgląd wyrenderowanego szablonu: [template-preview.pdf](./template-preview.pdf)

### Uwagi dotyczące użycia

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

- `main-lang` steruje językiem głównej treści i lokalizowanymi etykietami
- `screen-mode` domyślnie ma wartość `true`, aby dać symetryczne marginesy boczne na ekranie; ustaw `false` dla końcowego układu do druku i oprawy
- `authors` oczekuje od 1 do 3 rekordów z polami `name` i `album-number`
- do formatowania bibliografii używaj dołączonego pliku `apa.csl`
- `apa.csl` to niezmodyfikowana kopia oficjalnego stylu APA CSL z `https://github.com/citation-style-language/styles/blob/master/apa.csl`
- `symbols-list` jest opcjonalny i trafia między spis treści a rozdział 1
- osobne spisy rysunków, tabel i wzorów są celowo pominięte
- bibliografię dodaj jawnie na końcu dokumentu

### Minimalny przykład

```typst
#import "../pollub-thesis-typst/lib.typ": thesis, listing

#show: thesis.with(
  main-lang: "pl",
  title-primary: "Polski tytuł pracy",
  title-secondary: "English thesis title",
  authors: ((name: "Jan Kowalski", album-number: "123456"),),
  supervisor: "Promotor: dr inż. Jan Nowak",
  degree-label-primary: "Praca dyplomowa magisterska",
  degree-label-secondary: "Master's thesis",
  field-of-study: "in the field of Computer Science",
  specialization: "Data science",
  screen-mode: true,
)

= Wstęp
Tekst pracy.

#pagebreak()
#bibliography("references.bib", style: "apa.csl", title: [Bibliografia])
```
