# formal-pollub-thesis

Minimal, unofficial master's thesis template for Politechnika Lubelska.

This repository is structured as a real Typst package and a real Typst template:

- The reusable formatting logic lives in the package root.
- The starter thesis files live in `template/`.
- New thesis projects can be created with `typst init`.

## Package name

The Typst package name is `formal-pollub-thesis` at version `0.1.0`.

The starter template imports the package as:

```typst
#import "@preview/formal-pollub-thesis:0.1.0": thesis
```

That makes the repository ready for a future Typst Universe submission. For local
development before publication, install it locally under the same namespace.

## Local use

### Windows

Create a junction so Typst can see this repository as a local package:

```powershell
New-Item -ItemType Directory -Force -Path "$env:APPDATA\typst\packages\preview\formal-pollub-thesis"
New-Item -ItemType Junction -Path "$env:APPDATA\typst\packages\preview\formal-pollub-thesis\0.1.0" -Target "C:\path\to\typst-template-pollub"
```

Then initialize a thesis project:

```powershell
typst init @preview/formal-pollub-thesis:0.1.0 my-thesis
cd my-thesis
typst watch main.typ
```

### Custom package path

You can also keep the package outside of `%APPDATA%` and point Typst at a custom
package root:

```powershell
typst init @preview/formal-pollub-thesis:0.1.0 my-thesis --package-path C:\path\to\typst-packages
typst watch main.typ --package-path C:\path\to\typst-packages
```

The custom package root must contain:

```text
typst-packages/
  preview/
    formal-pollub-thesis/
      0.1.0/
```

## Files

- `typst.toml`: package metadata and template metadata
- `lib.typ`: public package entrypoint
- `src/`: internal implementation files
- `template/`: files copied into new thesis projects by `typst init`
- `thumbnail.png`: preview image for future Typst Universe submission

## Publishing later

This repository is set up so it can later be submitted to the public Typst
package repository with only normal release work:

- keep the package name and version in sync
- update the import in `template/main.typ` when bumping versions
- compile the initialized template
- regenerate `thumbnail.png`
- submit the release to `typst/packages`

## License

The sample package source in this repository is licensed under `MIT-0`.
