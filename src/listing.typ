#let listing(
  source,
  caption: none,
  lang: none,
) = {
  if lang == none {
    figure(
      kind: "listing",
      supplement: [Listing],
      caption: caption,
      raw(source, block: true),
    )
  } else {
    figure(
      kind: "listing",
      supplement: [Listing],
      caption: caption,
      raw(source, block: true, lang: lang),
    )
  }
}
