#import "@preview/pollub-thesis:0.1.0": listing

#let chapter2 = [
= Measurement setup and sample results

The sample measurement series relates the cold-side temperature of the setup to
the drive current of the thermoelectric module. The curve shape is consistent
with the broader trade-offs between useful cooling power, Joule heating, and
heat leakage discussed in the thermoelectric literature @snyder-toberer-2008.

== Measurement points

#figure(
  table(
    columns: 3,
    [I_TEC [A]], [T_cold [°C]], [Expanded uncertainty [°C]],
    [1.0], [3.4], [1.5],
    [2.0], [-10.2], [1.7],
    [3.0], [-19.6], [1.9],
    [4.0], [-25.0], [1.9],
    [5.3], [-28.9], [1.3],
    [5.75], [-29.0], [1.2],
    [7.0], [-25.1], [1.8],
  ),
  supplement: [Table],
  caption: [Measured points used to draw the sample characteristic],
)

The selected points concentrate around the operating minimum so that the
example shows both the descending part of the curve and the region where
increasing the current no longer improves the temperature result. Practical
setup notes for thermoelectric modules are commonly discussed together with
thermal load and heat rejection limits @ferrotec-guide.

== Sample characteristic

#figure(
  image("../images/tcold_vs_current.png", width: 100%),
  caption: [Cold-side temperature as a function of thermoelectric current],
)

The minimum visible near 5.75 A is useful as a sample discussion point because
it illustrates a typical engineering conclusion: the best operating point is
not necessarily at the largest admissible current. Measurement quality and
repeatable uncertainty treatment remain essential when selecting that point
@nist-thermoelectric-measurements.

== Control routine

#listing(
  "setpoint = -29.0\ncurrent = 5.75\nerror = setpoint - read_cold_side_temperature()\n\nwhile abs(error) > 0.2:\n    current = clamp(current + k_p * error, 1.0, 7.0)\n    drive_module(current)\n    error = setpoint - read_cold_side_temperature()\n",
  caption: [Simplified control loop for setpoint tracking],
  lang: "python",
)

The listing is intentionally short. It exists to demonstrate caption placement,
monospace styling, and section-based numbering for listings without forcing a
specific software stack on the thesis author.
]
