# pollub-thesis

`pollub-thesis` is a Typst thesis template for **WEII, Wydział Elektrotechniki i Informatyki, Politechnika Lubelska**. The template is tuned for the current written faculty guidelines and the official master title page distributed as a Word document.

The package provides:

- mirrored A4 margins for duplex printing
- a WEII master title page with the bundled faculty header image
- bilingual front matter with `Streszczenie` and `Abstract`
- chapter-based numbering for figures, tables, listings, and equations
- language-aware defaults for headings, captions, and table of contents
- Polish typography helpers that stay scoped to Polish content
- a single APA 7 bibliography with numeric bracket citations
- an optional localized symbols-list front-matter block
- a starter project compatible with `typst init`

## Requirements

- Typst `0.14.0` or newer
- `Times New Roman` available on the system

The package expects the Windows font above and is optimized for that setup.

## Public API

The package exports:

- `thesis`
- `listing`

Minimal example:

```typst
#import "@preview/pollub-thesis:0.1.0": thesis, listing

#show: thesis.with(
  main-lang: "pl",
  title-pl: [Polski tytuł pracy],
  title-en: [English thesis title],
  authors: (
    (name: "Jan Kowalski", album-number: "123456"),
  ),
  supervisor: "dr inż. Jan Nowak",
  degree-label: ([Praca dyplomowa], [magisterska]),
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

Set `main-lang: "en"` if the thesis body is in English. In that case, also switch the bibliography title to `[Bibliography]`.

## Notes

- Pass `authors` as a sequence of 1 to 3 records, each with `name` and `album-number`.
- `main-lang` controls the body language and the automatic labels used for figures, tables, listings, the table of contents, and the optional symbols list. The default is `"pl"`.
- Set `screen-mode: true` if you want a screen-reading PDF with symmetric left and right margins. Leave it `false` for the final print-ready layout required for binding.
- Polish single-letter word protection is enabled automatically when `main-lang: "pl"` and is still applied in the Polish abstract and official Polish title-page sections even when `main-lang: "en"`.
- The title page uses the bundled WEII header image by default. Override it with `title-header-image` if you want to supply another asset.
- The optional `symbols-list` parameter inserts an unnumbered symbols-list section between the table of contents and chapter 1. Its title follows `main-lang` unless you override `symbols-list-title`.
- The template intentionally does not generate separate lists of tables, figures, or formulas, because the WEII guidelines forbid them.

## Getting started

Create a new thesis project from the template:

```sh
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

For real thesis work before publication, import the local package entrypoint
directly from your thesis repository:

```typst
#import "../pollub-thesis-typst/lib.typ": thesis, listing
```

That is the supported local workflow for this repository. The `@preview/...`
imports remain in `template/` only for the published package shape used by
`typst init`.

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
