# Annual healthcare-associated infection burden in Germany

Published estimates for five healthcare-associated infection types in
Germany in 2011, based on the representative German point prevalence
survey (PPS). Transcribed from Table 1 of Zacher et al. (2019).

## Usage

``` r
hai_germany
```

## Format

A data frame with 30 rows and 11 columns:

- infection:

  Infection code: HAP, SSI, BSI, UTI, CDI or All.

- measure:

  Outcome: infections, deaths, dalys, yll or yld.

- estimate:

  Published median estimate of annual burden.

- lower:

  Lower limit of the 95 percent uncertainty interval.

- upper:

  Upper limit of the 95 percent uncertainty interval.

- infection_name:

  Full infection label.

- country:

  Country represented by the estimate: Germany.

- year:

  Reference year: 2011.

- sample:

  Survey sample used for estimation.

- source_table:

  Table number in the source article.

- unit:

  Infections, attributable deaths or years.

## Source

Zacher et al. (2019), Table 1, page 3.
[doi:10.2807/1560-7917.ES.2019.24.46.1900135](https://doi.org/10.2807/1560-7917.ES.2019.24.46.1900135)
. Article licensed under CC BY 4.0:
<https://creativecommons.org/licenses/by/4.0/>. Published values were
transcribed and rearranged into long format.

## Details

DALYs are disability-adjusted life years; YLLs are years of life lost;
YLDs are years lived with disability.

Values are annual totals, not rates per 100,000 population. The All
category covers only the five infection types studied. Keep it separate
from individual infections to avoid double counting.

Estimates are model-based and historical. Sums of individual medians
need not equal the published overall median. These data do not describe
current hospital conditions.

## Examples

``` r
head(hai_germany)
#>   infection    measure estimate lower  upper                  infection_name
#> 1       HAP infections   106586 83618 137476 Healthcare-associated pneumonia
#> 2       HAP     deaths     3968  1107   8164 Healthcare-associated pneumonia
#> 3       HAP      dalys    69508 34042 117232 Healthcare-associated pneumonia
#> 4       HAP        yll    41306 11475  84483 Healthcare-associated pneumonia
#> 5       HAP        yld    27539 16528  42824 Healthcare-associated pneumonia
#> 6       SSI infections    93222 75369 114241         Surgical-site infection
#>   country year                    sample source_table                unit
#> 1 Germany 2011 German representative PPS      Table 1          Infections
#> 2 Germany 2011 German representative PPS      Table 1 Attributable deaths
#> 3 Germany 2011 German representative PPS      Table 1               Years
#> 4 Germany 2011 German representative PPS      Table 1               Years
#> 5 Germany 2011 German representative PPS      Table 1               Years
#> 6 Germany 2011 German representative PPS      Table 1          Infections
subset(hai_germany, measure == "dalys" & infection != "All")
#>    infection measure estimate lower  upper
#> 3        HAP   dalys    69508 34042 117232
#> 8        SSI   dalys    28842 23313  35303
#> 13       BSI   dalys    58350 30940 104227
#> 18       UTI   dalys    66701 27890 128543
#> 23       CDI   dalys    20890  2023  49443
#>                                              infection_name country year
#> 3                           Healthcare-associated pneumonia Germany 2011
#> 8                                   Surgical-site infection Germany 2011
#> 13                            Primary bloodstream infection Germany 2011
#> 18            Healthcare-associated urinary tract infection Germany 2011
#> 23 Healthcare-associated Clostridioides difficile infection Germany 2011
#>                       sample source_table  unit
#> 3  German representative PPS      Table 1 Years
#> 8  German representative PPS      Table 1 Years
#> 13 German representative PPS      Table 1 Years
#> 18 German representative PPS      Table 1 Years
#> 23 German representative PPS      Table 1 Years
```
