# Lublin University of Technology (pollub) thesis Typst template

Your thesis is in Polish? Jump to: [polski](#polski)

## English

`pollub-thesis` is a Typst thesis template for the Lublin University of Technology, specifically Wydział Elektrotechniki i Informatyki. It provides a WEII title page, a bilingual abstract page, chapter-based numbering for figures/tables/listings/equations, and thesis layout defaults aligned with the faculty guidelines.

Current rendered preview: [template-preview.pdf](./template-preview.pdf). Regenerate it and the thumbnail from the repository root after template changes:

```text
typst compile --root . --input local-template-preview=true template/main.typ template-preview.pdf
typst compile --root . --input local-template-preview=true --pages 1 --ppi 144 template/main.typ thumbnail.png
```

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
- `screen-mode` defaults to `false`, the mirrored print and binding margins the faculty requires; set it to `true` for symmetric side margins on screen
- `field-of-study` and `specialization` are printed as given, so include the faculty wording, for example `na kierunku …` and `na bloku dyplomowania …` (master's) or `w specjalności …` (engineering)
- the title page follows the faculty model (Załącznik 5): the degree label, the field of study and diploma block lines, the Polish title, then the English title in the same size, the authors, the supervisor, and the city and year; `title-primary` is the title in `main-lang` and `title-secondary` the title in the other language, and the Polish one is always printed first
- the faculty model has a single degree label, for example `Praca dyplomowa magisterska`, and a supervisor line `Promotor` followed by the title, degree and name; the rules give no English wording, so an English thesis supplies its own labels, and `degree-label-secondary` is an optional second degree label in the other language
- a degree label or field of study that wraps pushes the blocks below it down instead of overlapping them
- `authors` expects 1 to 3 records with `name` and `album-number`
- use the bundled `apa.csl` for bibliography formatting
- `apa.csl` is an APA 7 style adapted to the WEII diploma guidelines: it keeps APA 7 reference-entry formatting, except that author lists have no ampersand and other name lists use the localized word for "and" as in the faculty examples, but uses numbered `[n]` in-text citations and a numbered, alphabetically ordered reference list (adapted from the official APA CSL at `https://github.com/citation-style-language/styles/blob/master/apa.csl`)
- the abstract page puts the Polish abstract and keywords before the English ones, in the order the faculty rules list them, whatever `main-lang` is
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
  specialization: "specialization: Data science",
  screen-mode: true,
)

= Introduction
Thesis text.

#pagebreak()
#bibliography("references.bib", style: "apa.csl", title: [Bibliography])
```

### Licence

The package is licensed under MIT-0 (see [LICENSE](./LICENSE)), except `template/apa.csl`, which is licensed under the [Creative Commons Attribution-ShareAlike 3.0 Unported licence](https://creativecommons.org/licenses/by-sa/3.0/) (CC BY-SA 3.0), so the manifest declares `MIT-0 AND CC-BY-SA-3.0`. Copies and adaptations of that file must keep its licence.

`template/apa.csl` is adapted from "APA Style 7th edition" of the [Citation Style Language styles repository](https://github.com/citation-style-language/styles/blob/master/apa.csl), by Brenton M. Wiernik and Andrew Dunning. Its own header keeps the original authors and licence. It was changed as follows:

- the title and identifier name it as the Lublin University of Technology numeric variant, and its citation format is numeric;
- in-text citations are numbered `[n]`, in citation-number order, instead of author and date;
- reference list entries start with their `[n]` number, aligned flush instead of with a hanging indent, and stay in alphabetical order;
- author lists have no ampersand before the last name, and other name lists use the localized word for "and" instead of an ampersand;
- the comma before a month and day is attached to the month and day instead of separating the parts of the date group.

## Polski

`pollub-thesis` to szablon pracy dyplomowej w Typst dla Politechniki Lubelskiej, a dokładniej dla Wydziału Elektrotechniki i Informatyki. Zapewnia stronę tytułową WEII, dwujęzyczną stronę ze streszczeniami, numerację rysunków/tabel/listingów/równań w obrębie rozdziałów oraz domyślne ustawienia układu pracy zgodne z wytycznymi wydziału.

Aktualny podgląd wyrenderowanego szablonu: [template-preview.pdf](./template-preview.pdf). Po zmianach w szablonie wygeneruj go wraz z miniaturą poleceniami z sekcji angielskiej, uruchamianymi w katalogu głównym repozytorium.

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
- `screen-mode` domyślnie ma wartość `false`, czyli lustrzane marginesy do druku i oprawy wymagane przez wydział; ustaw `true`, aby uzyskać symetryczne marginesy boczne na ekranie
- `field-of-study` i `specialization` są drukowane bez zmian, więc podaj pełne sformułowanie z wzoru wydziału, np. `na kierunku …` i `na bloku dyplomowania …` (praca magisterska) albo `w specjalności …` (praca inżynierska)
- strona tytułowa odpowiada wzorowi wydziału (Załącznik 5): rodzaj pracy, wiersze kierunku i bloku dyplomowania, tytuł polski, a pod nim tytuł angielski tej samej wielkości, autorzy, promotor oraz miejscowość i rok; `title-primary` to tytuł w języku `main-lang`, a `title-secondary` w drugim języku, przy czym tytuł polski zawsze jest pierwszy
- wzór wydziału ma jeden napis z rodzajem pracy, np. `Praca dyplomowa magisterska`, oraz wiersz `Promotor` z tytułem, stopniem, imieniem i nazwiskiem; zasady nie podają brzmienia angielskiego, więc praca w języku angielskim podaje własne etykiety, a `degree-label-secondary` to opcjonalny drugi napis w drugim języku
- zawijający się rodzaj pracy lub kierunek przesuwa niższe bloki w dół zamiast na nie nachodzić
- `authors` oczekuje od 1 do 3 rekordów z polami `name` i `album-number`
- do formatowania bibliografii używaj dołączonego pliku `apa.csl`
- `apa.csl` to styl APA 7 dostosowany do wytycznych dyplomowych WEII: zachowuje formatowanie opisów bibliograficznych APA 7, poza tym że listy autorów nie zawierają znaku „&”, a pozostałe listy nazwisk łączy zlokalizowany spójnik, jak w przykładach wydziału, ale stosuje numerowane odsyłacze `[n]` w tekście oraz numerowaną, uporządkowaną alfabetycznie listę literatury (zaadaptowany z oficjalnego stylu APA CSL z `https://github.com/citation-style-language/styles/blob/master/apa.csl`)
- strona ze streszczeniami zawiera najpierw polskie streszczenie i słowa kluczowe, a potem angielskie, w kolejności z zasad dyplomowania, niezależnie od `main-lang`
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
  supervisor: "Promotor dr inż. Jan Nowak",
  degree-label-primary: "Praca dyplomowa magisterska",
  field-of-study: "na kierunku informatyka",
  specialization: "na bloku dyplomowania Data science",
  screen-mode: true,
)

= Wstęp
Tekst pracy.

#pagebreak()
#bibliography("references.bib", style: "apa.csl", title: [Bibliografia])
```

### Licencja

Pakiet jest udostępniany na licencji MIT-0 (zob. [LICENSE](./LICENSE)), z wyjątkiem pliku `template/apa.csl`, który jest udostępniany na licencji [Creative Commons Uznanie autorstwa – Na tych samych warunkach 3.0 Unported](https://creativecommons.org/licenses/by-sa/3.0/) (CC BY-SA 3.0), dlatego manifest deklaruje `MIT-0 AND CC-BY-SA-3.0`. Kopie i adaptacje tego pliku muszą zachować jego licencję.

`template/apa.csl` jest adaptacją stylu „APA Style 7th edition” z [repozytorium stylów Citation Style Language](https://github.com/citation-style-language/styles/blob/master/apa.csl), autorstwa Brentona M. Wiernika i Andrew Dunninga. Nagłówek pliku zachowuje pierwotnych autorów i licencję. Wprowadzone zmiany:

- tytuł i identyfikator wskazują wariant numeryczny dla Politechniki Lubelskiej, a format cytowań jest numeryczny;
- odsyłacze w tekście mają postać numerów `[n]` w kolejności numerów zamiast autora i roku;
- pozycje listy literatury zaczynają się od numeru `[n]`, są wyrównane bez wysunięcia i pozostają w porządku alfabetycznym;
- listy autorów nie mają znaku „&” przed ostatnim nazwiskiem, a pozostałe listy nazwisk łączy zlokalizowany spójnik zamiast znaku „&”;
- przecinek przed miesiącem i dniem jest dołączony do miesiąca i dnia zamiast rozdzielać części grupy daty.
