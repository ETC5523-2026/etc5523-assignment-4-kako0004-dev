# haiburden

`haiburden` helps public-health analysts explore published estimates of
healthcare-associated infection burden in Germany and compare them with
estimates for the EU/EEA.

The Shiny app answers: How do estimated infection burden and
infection-type rankings differ between Germany and the EU/EEA when
comparing infections, attributable deaths and healthy years lost?

## Installation

Install the package from GitHub:

``` r

# Run once if remotes is not installed:
install.packages("remotes")

remotes::install_github(
  "ETC5523-2026/etc5523-assignment-4-kako0004-dev"
)
```

Access to the Classroom repository is required if it is private.

## Launch the app

``` r

library(haiburden)
run_app()
```

Choose a burden measure and either the representative or convenience
German sample. The table updates to show the German and EU/EEA
estimates, their uncertainty limits, differences, ratios and rankings.

All displayed estimates are annual rates per 100,000 population. A ratio
above 1 indicates a higher German point estimate. Rank 1 indicates the
highest point estimate within that population.

## Use the comparison function

``` r

library(haiburden)

compare_burden(measure = "dalys")

compare_burden(
  measure = "infections",
  sample_id = "DE_conv"
)
```

`difference` is the German estimate minus the EU/EEA estimate. `ratio`
is the German estimate divided by the EU/EEA estimate. Uncertainty
limits describe the original estimates, not the calculated differences
or ratios.

## Included data

- `hai_germany`: 30 records from Table 1 containing German annual totals
  for infections, attributable deaths, disability-adjusted life years
  (DALYs), years of life lost (YLLs), and years lived with disability
  (YLDs).
- `hai_comparison`: 54 records from Table 2 containing annual rates per
  100,000 population for infections, attributable deaths and DALYs
  across three survey samples.

The five infection types are healthcare-associated pneumonia, urinary
tract infection, primary bloodstream infection, surgical-site infection
and Clostridioides difficile infection.

Access the dataset and function documentation with:

``` r

?hai_germany
?hai_comparison
?compare_burden
?run_app
```

## Data source and preparation

Source: Zacher et al. (2019), *Application of a new methodology and R
package reveals a high burden of healthcare-associated infections (HAI)
in Germany compared to the average in the European Union/European
Economic Area, 2011 to 2012*.

<https://doi.org/10.2807/1560-7917.ES.2019.24.46.1900135>

Values and 95% uncertainty intervals were manually transcribed from
Tables 1 and 2, rearranged into long format, and supplemented with
descriptive labels and source information.

The preparation script downloads a reference copy of the article,
imports the transcribed values, checks the data structure and
uncertainty limits, and saves the packaged datasets.

To recreate the datasets, run this from the repository root with usethis
installed:

``` r

source("data-raw/hai-burden.R")
```

This reproduces preparation of the published estimates; it does not
rerun the authors’ statistical model.

## Interpretation and limitations

- These are historical, model-based estimates, based on German survey
  data from 2011 and EU/EEA survey data from 2011–2012.
- They do not describe current hospital conditions.
- The German representative and convenience samples are alternative
  estimates and must not be combined.
- The EU/EEA comparison is pooled, rather than individual-country data.
- Differences and rankings of point estimates do not establish
  statistical significance.
- The “All” category covers only the five infection types studied. It
  must not be added to the individual infection estimates.
- Sums of individual medians need not equal published overall medians.

## Licences

Package code is licensed under the MIT licence; see LICENSE.md.

The source article is licensed under [CC BY
4.0](https://creativecommons.org/licenses/by/4.0/). The transcribed
table data retain this attribution and licence. The data have been
reformatted as described above.

## AI-use declaration

I used ChatGPT to help diagnose and resolve errors during package
development, including dependency conflicts, function masking and
package-check notes.

## Documentation website

Visit the [haiburden documentation
website](https://etc5523-2026.github.io/etc5523-assignment-4-kako0004-dev/)
for installation instructions, function and dataset documentation, and a
guide to using and interpreting the app.
