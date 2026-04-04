# pollub-thesis

`pollub-thesis` is a Typst thesis template for **WEII, Wydział Elektrotechniki i Informatyki, Politechnika Lubelska**.

The package provides:

- a thesis layout with mirrored margins for two-sided printing
- a title page styled for WEII
- bilingual front matter with `Streszczenie` and `Abstract`
- section-based numbering for figures, tables, and listings
- split bibliographies for scientific and online sources
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
- `render-bibliography`

Minimal example:

```typst
#import "@preview/pollub-thesis:0.1.0": thesis, listing, render-bibliography

#let references = yaml("references.yml")

#show: thesis.with(
  title-pl: [Polski tytuł pracy],
  title-en: [English thesis title],
  author: "Jan Kowalski",
  album-number: "123456",
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

= Introduction
Text with a citation @riffat-ma-2003.

#listing(
  "print('hello')",
  caption: [Sample listing],
)

#hide(bibliography("references.yml", title: none, style: "ieee"))
#pagebreak()
#render-bibliography(references)
```

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
- a sample figure, table, and listing
- one `references.yml` file rendered as split scientific and online references

## Local development

For local development, install the repository under the `preview` namespace so
local usage matches the future public package shape.

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
- `src/`: implementation files for the layout, title page, listings, and bibliography rendering
- `template/`: starter thesis project copied by `typst init`

## Publishing

If package name review requires a rename, update the manifest and starter
import together before release.

## License

The package is licensed under `MIT-0`.
