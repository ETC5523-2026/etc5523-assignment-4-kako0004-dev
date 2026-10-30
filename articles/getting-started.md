# Getting started with haiburden

## What will this package help you investigate?

`haiburden` helps public-health analysts compare published estimates of
healthcare-associated infection burden in Germany and the European
Union/European Economic Area (EU/EEA).

The central question is: **How do infection burden and rankings differ
between Germany and the EU/EEA across infections, attributable deaths
and healthy years lost?**

These estimates use historical survey data from 2011–2012. They do not
describe current hospital conditions.

## Install the package

Run the following commands in your R Console:

``` r

install.packages("remotes")

remotes::install_github(
  "ETC5523-2026/etc5523-assignment-4-kako0004-dev"
)
```

If the Classroom repository is private, you need permission to access it
and GitHub authentication.

## Launch the app

``` r

library(haiburden)
run_app()
```

The app opens in a browser or RStudio window. Keep R running while using
it. To finish, stop the app from RStudio.

## Explore a comparison

1.  Start with **Healthy years lost (DALYs)** and the **Representative
    sample**.
2.  Keep all five infection types selected to compare their burden.
3.  Read the short finding and examine the graph in **Explore burden**.
4.  Change the measure to **Infections**. Examine whether the infection
    ranking changes.
5.  Switch to the **Convenience sample** to investigate how the findings
    depend on sample choice.
6.  Open **Exact values** to inspect the estimates or download the
    selected comparison as a CSV.
7.  Use **Reset comparison** to restore the initial selections.

Unticking every infection displays an informative message. Select an
infection or use Reset to restore the outputs.

## Interpret the graph

Symbols show published median estimates. Lines show 95% uncertainty
intervals. Every estimate is an annual rate per 100,000 population.

- **Infections** measures estimated new infection episodes.
- **Attributable deaths** measures deaths estimated to result from those
  infections.
- **DALYs**, or disability-adjusted life years, measures healthy years
  lost through premature death and disability.

The most frequent infection need not cause the greatest health loss.

The graph orders infections by the selected German point estimate. The
highlighted finding refers to the infection with the highest German
estimate among your selections.

## Reproduce a comparison in R

The same exported function used by the app can be used directly:

``` r

library(haiburden)

comparison <- compare_burden(
  measure = "dalys",
  sample_id = "DE_repr"
)

comparison[c(
  "infection",
  "germany_estimate",
  "eu_estimate",
  "difference",
  "ratio"
)]
#>   infection germany_estimate eu_estimate difference     ratio
#> 1       HAP             86.1       109.8      -23.7 0.7841530
#> 2       UTI             82.6        57.1       25.5 1.4465849
#> 3       BSI             72.2        76.2       -4.0 0.9475066
#> 4       SSI             35.7        35.1        0.6 1.0170940
#> 5       CDI             25.9        10.0       15.9 2.5900000
```

For urinary tract infection, the published DALY estimates are 82.6 for
Germany and 57.1 for the EU/EEA per 100,000 population. The difference
is 25.5 DALYs per 100,000, and the ratio is approximately 1.45.

This describes a German point estimate approximately 45% higher. It is
not a test of statistical significance.

## Interpret differences and uncertainty

**Difference** is Germany minus EU/EEA, expressed in the selected
measure per 100,000 population.

**Ratio** is Germany divided by EU/EEA:

- 1 indicates equal point estimates.
- 2 indicates a German estimate twice as high.
- 0.5 indicates a German estimate half as high.

Uncertainty limits refer to each original estimate. They are not
uncertainty intervals for the calculated difference or ratio. Neither
rankings nor percentage differences establish conclusive differences
between populations.

## Understand the samples

The representative German sample included 46 hospitals selected by
hospital size. The convenience sample included 132 hospitals and was not
representative by hospital size.

Use the representative sample as the starting point. The convenience
sample allows a sensitivity comparison: does the interpretation change
when the underlying sample changes?

A larger sample is not automatically more representative. The two German
samples must not be combined.

## Find the data and documentation

The package contains:

- `hai_germany`: annual German totals from Table 1.
- `hai_comparison`: population rates from Table 2, used by the app.

Open their help pages in R:

``` r

?hai_germany
?hai_comparison
?compare_burden
?run_app
```

The preparation script, `data-raw/hai-burden.R`, imports transcribed
published values, adds descriptive fields, checks the structure and
uncertainty limits, and saves the packaged datasets. It does not rerun
the original statistical model.

## Source and limitations

Source: Zacher et al. (2019), Tables 1 and 2.

<https://doi.org/10.2807/1560-7917.ES.2019.24.46.1900135>

The source article is licensed under [CC BY
4.0](https://creativecommons.org/licenses/by/4.0/). Published values
were transcribed and reformatted.

The five infection types do not cover every healthcare-associated
infection. The EU/EEA estimate is pooled, not individual-country data.
These historical, model-based estimates support exploration, rather than
current clinical decisions or funding recommendations.
