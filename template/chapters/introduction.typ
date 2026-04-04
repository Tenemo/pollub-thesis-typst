#let introduction = [
= Introduction

This sample project shows the intended repository split:

- the template repository contains reusable layout logic
- the thesis repository contains only document content and assets
- new projects start from `typst init` instead of copying formatting by hand

The public package API is intentionally small. Right now it exports one
`thesis` function that applies page setup, a title page, and basic front matter.

== Why start this way

Even a tiny package is easier to evolve than a copy-pasted document skeleton.
You can keep improving the package repository while thesis repositories stay
focused on text, figures, and references.

This sample file also includes a bibliography so the initialized project
exercises more than just plain text @typst-packages.
]
