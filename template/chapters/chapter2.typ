#import "@preview/pollub-thesis:0.1.0": listing

#let chapter2 = [
= Stanowisko pomiarowe i wyniki przykładowe

Przykładowa seria pomiarowa wiąże temperaturę strony zimnej badanego układu z
prądem sterującym modułem termoelektrycznym. Kształt charakterystyki jest
zgodny z kompromisem pomiędzy mocą chłodzenia, stratami Joule'a#footnote[
  Straty Joule'a rosną wraz z prądem i w praktyce ograniczają dalszą poprawę
  temperatury po przekroczeniu obszaru optimum.
] oraz
przenikaniem ciepła opisywanym w literaturze @snyder-toberer-2008.

== Punkty pomiarowe

#figure(
  table(
    columns: 4,
    table.header(
      [I_TEC, A],
      [T_cold, °C],
      [Niepewność rozszerzona, °C],
      [Uwagi],
    ),
    [1.0], [3.4], [1.5], [Start serii],
    [2.0], [-10.2], [1.7], [Stabilizacja układu],
    [3.0], [-19.6], [1.9], [Malejąca temperatura],
    [4.0], [-25.0], [1.9], [Początek obszaru użytecznego],
    [5.3], [-28.9], [1.3], [Blisko minimum#footnote[
      W praktyce warto zagęścić punkty pomiarowe właśnie w pobliżu minimum
      charakterystyki.
    ]],
    [5.75], [-29.0], [1.2], [Najlepszy punkt pracy],
    [7.0], [-25.1], [1.8], [Wzrost strat cieplnych],
  ),
  caption: [Punkty pomiarowe wykorzystane do wyznaczenia charakterystyki],
)

Wybrane punkty skupiono w pobliżu minimum charakterystyki, tak aby przykład
pokazywał zarówno odcinek malejący, jak i obszar, w którym dalszy wzrost prądu
nie poprawia już wyniku temperaturowego. Zagadnienia związane z ograniczeniami
obciążenia cieplnego i odprowadzaniem ciepła są szeroko omawiane w dokumentacji
praktycznej modułów termoelektrycznych @ferrotec-guide. Niepewność
rozszerzona#footnote[
  W prezentacjach laboratoryjnych często podaje się niepewność rozszerzoną dla
  współczynnika rozszerzenia k = 2, odpowiadającą w przybliżeniu poziomowi
  ufności 95%.
] pomaga odróżnić rzeczywistą poprawę wyniku od wahań mieszczących się w
błędzie pomiarowym.

== Charakterystyka przykładowa

#figure(
  image("../images/tcold_vs_current.png", width: 100%),
  caption: [Temperatura strony zimnej w funkcji prądu modułu termoelektrycznego],
)

Minimum widoczne w pobliżu 5,75 A stanowi użyteczny punkt interpretacyjny,
ponieważ ilustruje typowy wniosek inżynierski: najlepszy punkt pracy nie musi
odpowiadać największemu dopuszczalnemu prądowi. Przy wyborze takiego punktu
istotne pozostają jakość pomiaru i powtarzalne traktowanie niepewności
@nist-thermoelectric-measurements.

== Pętla sterowania

#listing(
  "setpoint = -29.0\ncurrent = 5.75\nerror = setpoint - read_cold_side_temperature()\n\nwhile abs(error) > 0.2:\n    current = clamp(current + k_p * error, 1.0, 7.0)\n    drive_module(current)\n    error = setpoint - read_cold_side_temperature()\n",
  caption: [Uproszczona pętla regulacji dla śledzenia punktu pracy],
  lang: "python",
)

Listing jest celowo krótki. Służy wyłącznie do pokazania rozmieszczenia podpisu,
pisma maszynowego oraz numeracji w obrębie rozdziału bez narzucania autorowi
konkretnego stosu technologicznego. Współczynnik proporcjonalny `k_p`#footnote[
  To najprostsza postać regulatora proporcjonalnego; w rzeczywistej pracy można
  go zastąpić regulatorem PI, histerezą albo algorytmem wyszukiwania optimum.
] pełni tu jedynie rolę poglądową.
]
