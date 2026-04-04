# pollub-thesis

`pollub-thesis` is a Typst thesis template for **WEII, Wydział Elektrotechniki i Informatyki, Politechnika Lubelska**. The template is tuned for the current written faculty guidelines and the official master title page distributed as a Word document.

The package provides:

- mirrored A4 margins for duplex printing
- a WEII master title page with the bundled faculty header image
- bilingual front matter with `Streszczenie` and `Abstract`
- chapter-based numbering for figures, tables, listings, and equations
- Polish-first defaults for headings, captions, and table of contents
- a single APA 7 bibliography with numeric bracket citations
- an optional `Alfabetyczny wykaz oznaczeń` front-matter block
- a starter project compatible with `typst init`

## Requirements

- Typst `0.14.0` or newer
- `Times New Roman` available on the system for the thesis body
- `Arial` available on the system for the title page

The package expects the Windows fonts above and is optimized for that setup.

## Public API

The package exports:

- `thesis`
- `listing`

Minimal example:

```typst
#import "@preview/pollub-thesis:0.1.0": thesis, listing

#show: thesis.with(
  title-pl: [Polski tytuł pracy],
  title-en: [English thesis title],
  authors: (
    (name: "Jan Kowalski", album-number: "123456"),
  ),
  supervisor: "Dr inż. Jan Nowak",
  degree-label: [Praca dyplomowa \ magisterska],
  field-of-study: [na kierunku Informatyka],
  diploma-block: [na bloku dyplomowania Aplikacje Internetowe],
  city: "Lublin",
  year: "2026",
  abstract-pl: [Krótki opis pracy po polsku.],
  keywords-pl: ("typst", "weii", "pollub"),
  abstract-en: [A short English abstract.],
  keywords-en: ("typst", "weii", "pollub"),
)

= Wstęp
Tekst z odwołaniem do literatury @riffat-ma-2003.

#listing(
  "print('hello')",
  caption: [Przykładowy listing],
)

#pagebreak()
#bibliography("references.bib", style: "apa", title: [Bibliografia])
```

## Notes

- Pass `authors` as a sequence of 1 to 3 records, each with `name` and `album-number`.
- The title page uses the bundled WEII header image by default. Override it with `title-header-image` if you want to supply another asset.
- The optional `symbols-list` parameter inserts an unnumbered `Alfabetyczny wykaz oznaczeń` section between the table of contents and chapter 1.
- The template intentionally does not generate separate lists of tables, figures, or formulas, because the WEII guidelines forbid them.

## Getting started

Create a new thesis project from the template:

```powershell
typst init @preview/pollub-thesis:0.1.0 my-thesis
cd my-thesis
typst watch main.typ
```

The generated project already contains:

- a WEII title page setup
- two sample chapters
- a sample figure, table, listing, and equation
- one `references.bib` file rendered as a single APA 7 bibliography

## Local development

For local development, install the repository under the `preview` namespace so local usage matches the future public package shape.

### Windows package directory

```powershell
New-Item -ItemType Directory -Force -Path "$env:APPDATA\typst\packages\preview\pollub-thesis"
New-Item -ItemType Junction -Path "$env:APPDATA\typst\packages\preview\pollub-thesis\0.1.0" -Target "C:\path\to\pollub-thesis"
```

Then initialize or compile with:

```powershell
typst init @preview/pollub-thesis:0.1.0 my-thesis
typst watch main.typ
```

### Custom package root

```powershell
typst init @preview/pollub-thesis:0.1.0 my-thesis --package-path C:\path\to\typst-packages
typst watch main.typ --package-path C:\path\to\typst-packages
```

The custom root must contain:

```text
typst-packages/
  preview/
    pollub-thesis/
      0.1.0/
```

## Package layout

- `typst.toml`: package and template manifest
- `lib.typ`: public entrypoint
- `assets/`: bundled title-page image assets
- `src/`: implementation files for the layout, title page, and listings
- `template/`: starter thesis project copied by `typst init`

## Publishing

If package name review requires a rename, update the manifest and starter import together before release.

## License

The package is licensed under `MIT-0`.
