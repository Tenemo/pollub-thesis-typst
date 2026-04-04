#let listing(
  source,
  caption: none,
  lang: none,
) = figure(
  kind: "listing",
  caption: caption,
  raw(source, block: true, lang: lang),
)
