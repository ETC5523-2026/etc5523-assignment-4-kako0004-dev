# Compare healthcare-associated infection burden across populations

Published annual burden rates for five infection types, based on
representative and convenience samples from Germany and the European
Union/European Economic Area (EU/EEA) sample. Transcribed from Table 2
of Zacher et al. (2019).

## Usage

``` r
hai_comparison
```

## Format

A data frame with 54 rows and 12 columns:

- sample_id:

  Sample code: DE_repr, DE_conv or EU.

- infection:

  Infection code: HAP, UTI, BSI, SSI, CDI or All.

- measure:

  Outcome: infections, deaths or dalys.

- estimate:

  Published median annual rate per 100,000 population.

- lower:

  Lower limit of the 95 percent uncertainty interval.

- upper:

  Upper limit of the 95 percent uncertainty interval.

- infection_name:

  Full infection label.

- sample:

  Full survey sample label.

- population:

  Germany or EU/EEA.

- survey_period:

  Survey period: 2011 or 2011-2012.

- source_table:

  Table number in the source article.

- unit:

  Measure-specific unit per 100,000 population.

## Source

Zacher et al. (2019), Table 2, page 5.
[doi:10.2807/1560-7917.ES.2019.24.46.1900135](https://doi.org/10.2807/1560-7917.ES.2019.24.46.1900135)
. Article licensed under CC BY 4.0:
<https://creativecommons.org/licenses/by/4.0/>. Published values were
transcribed and rearranged into long format.

## Details

PPS means point prevalence survey. DALYs are disability-adjusted life
years.

All estimates are annual rates per 100,000 population. The German
samples are alternative estimates for the same country and must not be
combined. EU/EEA is a pooled comparison, not individual country data.

The All category covers only the five infection types studied. Keep it
separate from individual infections to avoid double counting. Published
overall medians need not equal sums of individual medians.

These historical, model-based estimates include uncertainty. Ranking
point estimates alone does not establish conclusive differences between
infection types or populations.

## Examples

``` r
head(hai_comparison)
#>   sample_id infection    measure estimate lower upper
#> 1   DE_repr       HAP infections    132.0 103.5 170.2
#> 2   DE_repr       UTI infections    265.1 216.8 313.9
#> 3   DE_repr       BSI infections     33.4  20.5  52.3
#> 4   DE_repr       SSI infections    115.4  93.3 141.4
#> 5   DE_repr       CDI infections     44.6  31.1  61.8
#> 6   DE_repr       All infections    592.1 521.7 665.8
#>                                             infection_name
#> 1                          Healthcare-associated pneumonia
#> 2            Healthcare-associated urinary tract infection
#> 3                            Primary bloodstream infection
#> 4                                  Surgical-site infection
#> 5 Healthcare-associated Clostridioides difficile infection
#> 6                                 All five infection types
#>                      sample population survey_period source_table
#> 1 German representative PPS    Germany          2011      Table 2
#> 2 German representative PPS    Germany          2011      Table 2
#> 3 German representative PPS    Germany          2011      Table 2
#> 4 German representative PPS    Germany          2011      Table 2
#> 5 German representative PPS    Germany          2011      Table 2
#> 6 German representative PPS    Germany          2011      Table 2
#>                                unit
#> 1 Infections per 100,000 population
#> 2 Infections per 100,000 population
#> 3 Infections per 100,000 population
#> 4 Infections per 100,000 population
#> 5 Infections per 100,000 population
#> 6 Infections per 100,000 population
subset(hai_comparison, measure == "dalys" & infection == "All")
#>    sample_id infection measure estimate lower upper           infection_name
#> 42   DE_repr       All   dalys    308.2 221.2 416.3 All five infection types
#> 48   DE_conv       All   dalys    359.3 266.6 461.5 All five infection types
#> 54        EU       All   dalys    290.0 214.9 376.9 All five infection types
#>                       sample population survey_period source_table
#> 42 German representative PPS    Germany          2011      Table 2
#> 48    German convenience PPS    Germany          2011      Table 2
#> 54         ECDC PPS (EU/EEA)     EU/EEA     2011-2012      Table 2
#>                            unit
#> 42 DALYs per 100,000 population
#> 48 DALYs per 100,000 population
#> 54 DALYs per 100,000 population
```
