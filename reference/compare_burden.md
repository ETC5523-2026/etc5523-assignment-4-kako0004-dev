# Compare German infection burden with the EU/EEA

Compares published annual rates per 100,000 population for individual
infection types. Excludes the aggregate All category.

## Usage

``` r
compare_burden(
  measure = "dalys",
  sample_id = "DE_repr",
  data = haiburden::hai_comparison
)
```

## Arguments

- measure:

  Outcome to compare: "infections", "deaths" or "dalys".

- sample_id:

  German sample: "DE_repr" for the representative sample or "DE_conv"
  for the convenience sample.

- data:

  A data frame with the structure of
  [hai_comparison](https://etc5523-2026.github.io/etc5523-assignment-4-kako0004-dev/reference/hai_comparison.md).

## Value

A data frame ordered by decreasing German estimate. Includes infection
labels, both populations' estimates and uncertainty limits, the
difference (Germany minus EU/EEA), the ratio (Germany divided by
EU/EEA), and population rankings. Rank 1 indicates the highest point
estimate; ties share a rank.

## Details

Differences, ratios and rankings describe published point estimates.
They are not tests of statistical significance. Uncertainty limits refer
to each original estimate, not to the calculated difference or ratio.

## Examples

``` r
compare_burden()
#>   infection                                           infection_name
#> 1       HAP                          Healthcare-associated pneumonia
#> 2       UTI            Healthcare-associated urinary tract infection
#> 3       BSI                            Primary bloodstream infection
#> 4       SSI                                  Surgical-site infection
#> 5       CDI Healthcare-associated Clostridioides difficile infection
#>   germany_estimate germany_lower germany_upper eu_estimate eu_lower eu_upper
#> 1             86.1          42.1         145.1       109.8     55.3    170.5
#> 2             82.6          34.5         159.2        57.1     24.3    102.9
#> 3             72.2          38.3         129.0        76.2     52.6    104.8
#> 4             35.7          28.9          43.7        35.1     33.3     36.8
#> 5             25.9           2.5          61.2        10.0      0.9     19.2
#>   measure german_sample difference     ratio germany_rank eu_rank
#> 1   dalys       DE_repr      -23.7 0.7841530            1       1
#> 2   dalys       DE_repr       25.5 1.4465849            2       3
#> 3   dalys       DE_repr       -4.0 0.9475066            3       2
#> 4   dalys       DE_repr        0.6 1.0170940            4       4
#> 5   dalys       DE_repr       15.9 2.5900000            5       5
compare_burden(measure = "infections")
#>   infection                                           infection_name
#> 1       UTI            Healthcare-associated urinary tract infection
#> 2       HAP                          Healthcare-associated pneumonia
#> 3       SSI                                  Surgical-site infection
#> 4       CDI Healthcare-associated Clostridioides difficile infection
#> 5       BSI                            Primary bloodstream infection
#>   germany_estimate germany_lower germany_upper eu_estimate eu_lower eu_upper
#> 1            265.1         216.8         313.9       174.7    166.3    182.4
#> 2            132.0         103.5         170.2       143.7    136.9    150.8
#> 3            115.4          93.3         141.4       111.3    105.4    116.6
#> 4             44.6          31.1          61.8        16.0     14.2     18.3
#> 5             33.4          20.5          52.3        22.2     20.0     25.1
#>      measure german_sample difference     ratio germany_rank eu_rank
#> 1 infections       DE_repr       90.4 1.5174585            1       1
#> 2 infections       DE_repr      -11.7 0.9185804            2       2
#> 3 infections       DE_repr        4.1 1.0368374            3       3
#> 4 infections       DE_repr       28.6 2.7875000            4       5
#> 5 infections       DE_repr       11.2 1.5045045            5       4
compare_burden(measure = "deaths", sample_id = "DE_conv")
#>   infection                                           infection_name
#> 1       BSI                            Primary bloodstream infection
#> 2       HAP                          Healthcare-associated pneumonia
#> 3       UTI            Healthcare-associated urinary tract infection
#> 4       SSI                                  Surgical-site infection
#> 5       CDI Healthcare-associated Clostridioides difficile infection
#>   germany_estimate germany_lower germany_upper eu_estimate eu_lower eu_upper
#> 1              7.9           4.7          11.8         3.3      2.1      4.6
#> 2              6.1           1.4          11.7         5.3      1.3     10.2
#> 3              3.9           1.6           8.0         3.0      1.2      5.9
#> 4              3.7           3.2           4.2         2.6      2.4      2.7
#> 5              2.5           0.1           5.3         0.9      0.0      1.8
#>   measure german_sample difference    ratio germany_rank eu_rank
#> 1  deaths       DE_conv        4.6 2.393939            1       2
#> 2  deaths       DE_conv        0.8 1.150943            2       1
#> 3  deaths       DE_conv        0.9 1.300000            3       3
#> 4  deaths       DE_conv        1.1 1.423077            4       4
#> 5  deaths       DE_conv        1.6 2.777778            5       5
```
