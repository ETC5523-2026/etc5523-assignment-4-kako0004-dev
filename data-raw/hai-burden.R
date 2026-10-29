# Prepare published healthcare-associated infection estimates
#
# Source: Zacher et al. (2019), Tables 1 and 2.
# DOI: 10.2807/1560-7917.ES.2019.24.46.1900135
# Article licence: CC BY 4.0
# https://creativecommons.org/licenses/by/4.0/
#
# This script will reproduce our preparation of published estimates.
# It does not rerun the authors' statistical model.

source_url <- paste0(
  "https://cwd.numbat.space/assignments/",
  "assignment-2-papers/Zacher2019.pdf"
)

source_file <- "data-raw/Zacher2019.pdf"

# Keep a local reference copy for checking the transcribed values.
if (!file.exists(source_file)) {
  download.file(
    url = source_url,
    destfile = source_file,
    mode = "wb"
  )
}


# Table 1: Germany's annual burden estimates, 2011.
# Values transcribed from Zacher et al. (2019), page 3.
# Estimates are medians; lower and upper are 95% uncertainty limits.
# "All" means all five infection types considered in the study.

hai_germany <- read.table(
  text = "
infection measure estimate lower upper
HAP infections 106586 83618 137476
HAP deaths 3968 1107 8164
HAP dalys 69508 34042 117232
HAP yll 41306 11475 84483
HAP yld 27539 16528 42824
SSI infections 93222 75369 114241
SSI deaths 2328 1888 2882
SSI dalys 28842 23313 35303
SSI yll 28376 22983 34714
SSI yld 452 352 580
BSI infections 26976 16520 42252
BSI deaths 3905 2004 6987
BSI dalys 58350 30940 104227
BSI yll 49578 25499 90816
BSI yld 8787 4463 16609
UTI infections 214150 175086 253524
UTI deaths 3664 1462 7533
UTI dalys 66701 27890 128543
UTI yll 44871 18043 92915
UTI yld 20243 8095 40522
CDI infections 36002 25108 49934
CDI deaths 1917 112 4547
CDI dalys 20890 2023 49443
CDI yll 19937 1166 47973
CDI yld 977 172 2125
All infections 478222 421350 537787
All deaths 16245 10863 22756
All dalys 248920 178693 336239
All yll 190245 131301 264573
All yld 59076 40263 84578
",
  header = TRUE,
  stringsAsFactors = FALSE
)

# Add readable infection names.
infection_names <- c(
  HAP = "Healthcare-associated pneumonia",
  SSI = "Surgical-site infection",
  BSI = "Primary bloodstream infection",
  UTI = "Healthcare-associated urinary tract infection",
  CDI = "Healthcare-associated Clostridioides difficile infection",
  All = "All five infection types"
)

hai_germany$infection_name <- unname(
  infection_names[hai_germany$infection]
)

# Record the context of these estimates.
hai_germany$country <- "Germany"
hai_germany$year <- 2011L
hai_germany$sample <- "German representative PPS"
hai_germany$source_table <- "Table 1"

# These are annual totals, not rates per 100,000 population.
hai_germany$unit <- ifelse(
  hai_germany$measure == "infections",
  "Infections",
  ifelse(
    hai_germany$measure == "deaths",
    "Attributable deaths",
    "Years"
  )
)

# Check the structure and uncertainty limits before saving.
stopifnot(
  nrow(hai_germany) == 30L,
  !anyNA(hai_germany),
  !anyDuplicated(hai_germany[c("infection", "measure")]),
  all(hai_germany$lower >= 0),
  all(hai_germany$lower <= hai_germany$estimate),
  all(hai_germany$estimate <= hai_germany$upper)
)

# Preserve the published "All" estimates.
# Sums of individual medians need not equal an overall median.

# Save the prepared dataset inside the package.
usethis::use_data(hai_germany, overwrite = TRUE)

# Table 2: Annual burden per 100,000 population.
# Values transcribed from Zacher et al. (2019), page 5.
# Samples must remain separate: the German convenience sample
# is an alternative sample, not an additional country.

hai_comparison <- read.table(
  text = "
sample_id infection measure estimate lower upper
DE_repr HAP infections 132.0 103.5 170.2
DE_repr UTI infections 265.1 216.8 313.9
DE_repr BSI infections 33.4 20.5 52.3
DE_repr SSI infections 115.4 93.3 141.4
DE_repr CDI infections 44.6 31.1 61.8
DE_repr All infections 592.1 521.7 665.8
DE_conv HAP infections 162.3 137.5 190.7
DE_conv UTI infections 228.7 200.0 260.7
DE_conv BSI infections 52.7 42.0 66.9
DE_conv SSI infections 146.9 126.5 167.8
DE_conv CDI infections 44.5 35.6 55.4
DE_conv All infections 636.1 586.7 689.2
EU HAP infections 143.7 136.9 150.8
EU UTI infections 174.7 166.3 182.4
EU BSI infections 22.2 20.0 25.1
EU SSI infections 111.3 105.4 116.6
EU CDI infections 16.0 14.2 18.3
EU All infections 467.9 456.2 480.2
DE_repr HAP deaths 4.9 1.4 10.1
DE_repr UTI deaths 4.5 1.8 9.3
DE_repr BSI deaths 4.8 2.5 8.7
DE_repr SSI deaths 2.9 2.3 3.6
DE_repr CDI deaths 2.4 0.1 5.6
DE_repr All deaths 20.1 13.4 28.2
DE_conv HAP deaths 6.1 1.4 11.7
DE_conv UTI deaths 3.9 1.6 8.0
DE_conv BSI deaths 7.9 4.7 11.8
DE_conv SSI deaths 3.7 3.2 4.2
DE_conv CDI deaths 2.5 0.1 5.3
DE_conv All deaths 24.4 17.2 32.6
EU HAP deaths 5.3 1.3 10.2
EU UTI deaths 3.0 1.2 5.9
EU BSI deaths 3.3 2.1 4.6
EU SSI deaths 2.6 2.4 2.7
EU CDI deaths 0.9 0.0 1.8
EU All deaths 15.3 10.2 21.2
DE_repr HAP dalys 86.1 42.1 145.1
DE_repr UTI dalys 82.6 34.5 159.2
DE_repr BSI dalys 72.2 38.3 129.0
DE_repr SSI dalys 35.7 28.9 43.7
DE_repr CDI dalys 25.9 2.5 61.2
DE_repr All dalys 308.2 221.2 416.3
DE_conv HAP dalys 103.4 51.5 166.5
DE_conv UTI dalys 69.5 29.9 127.7
DE_conv BSI dalys 113.5 72.2 166.0
DE_conv SSI dalys 45.0 38.8 51.3
DE_conv CDI dalys 26.5 2.5 55.6
DE_conv All dalys 359.3 266.6 461.5
EU HAP dalys 109.8 55.3 170.5
EU UTI dalys 57.1 24.3 102.9
EU BSI dalys 76.2 52.6 104.8
EU SSI dalys 35.1 33.3 36.8
EU CDI dalys 10.0 0.9 19.2
EU All dalys 290.0 214.9 376.9
",
  header = TRUE,
  stringsAsFactors = FALSE
)

# Reuse the infection-name lookup created above for Table 1.
hai_comparison$infection_name <- unname(
  infection_names[hai_comparison$infection]
)

sample_names <- c(
  DE_repr = "German representative PPS",
  DE_conv = "German convenience PPS",
  EU = "ECDC PPS (EU/EEA)"
)

hai_comparison$sample <- unname(
  sample_names[hai_comparison$sample_id]
)

hai_comparison$population <- ifelse(
  hai_comparison$sample_id == "EU",
  "EU/EEA",
  "Germany"
)

# Record each sample's survey period explicitly.
hai_comparison$survey_period <- ifelse(
  hai_comparison$sample_id == "EU",
  "2011-2012",
  "2011"
)

hai_comparison$source_table <- "Table 2"

measure_units <- c(
  infections = "Infections per 100,000 population",
  deaths = "Attributable deaths per 100,000 population",
  dalys = "DALYs per 100,000 population"
)

hai_comparison$unit <- unname(
  measure_units[hai_comparison$measure]
)

# Check completeness, unique records and uncertainty limits.
stopifnot(
  nrow(hai_comparison) == 54L,
  !anyNA(hai_comparison),
  !anyDuplicated(
    hai_comparison[c("sample_id", "infection", "measure")]
  ),
  all(hai_comparison$lower >= 0),
  all(hai_comparison$lower <= hai_comparison$estimate),
  all(hai_comparison$estimate <= hai_comparison$upper)
)

usethis::use_data(hai_comparison, overwrite = TRUE)
