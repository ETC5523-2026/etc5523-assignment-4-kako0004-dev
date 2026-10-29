#' Compare German infection burden with the EU/EEA
#'
#' Compares published annual rates per 100,000 population for
#' individual infection types. Excludes the aggregate All category.
#'
#' @param measure Outcome to compare: "infections", "deaths" or "dalys".
#' @param sample_id German sample: "DE_repr" for the representative
#'   sample or "DE_conv" for the convenience sample.
#' @param data A data frame with the structure of [hai_comparison].
#'
#' @return A data frame ordered by decreasing German estimate.
#'   Includes infection labels, both populations' estimates and
#'   uncertainty limits, the difference (Germany minus EU/EEA),
#'   the ratio (Germany divided by EU/EEA), and population rankings.
#'   Rank 1 indicates the highest point estimate; ties share a rank.
#'
#' @details
#' Differences, ratios and rankings describe published point estimates.
#' They are not tests of statistical significance.
#' Uncertainty limits refer to each original estimate, not to
#' the calculated difference or ratio.
#'
#' @export
#'
#' @examples
#' compare_burden()
#' compare_burden(measure = "infections")
#' compare_burden(measure = "deaths", sample_id = "DE_conv")
compare_burden <- function(
    measure = "dalys",
    sample_id = "DE_repr",
    data = haiburden::hai_comparison) {

  measure <- match.arg(measure, c("dalys", "infections", "deaths"))
  sample_id <- match.arg(sample_id, c("DE_repr", "DE_conv"))

  required <- c(
    "sample_id", "infection", "infection_name",
    "measure", "estimate", "lower", "upper"
  )

  if (!is.data.frame(data) || !all(required %in% names(data))) {
    stop("data must contain the required hai_comparison columns.")
  }

  selected <- data[
    data$measure == measure &
      data$infection != "All" &
      data$sample_id %in% c(sample_id, "EU"),
    required,
    drop = FALSE
  ]

  if (anyNA(selected)) {
    stop("Selected records must not contain missing values.")
  }

  if (anyDuplicated(selected[c("sample_id", "infection")])) {
    stop("Each sample must have one record per infection.")
  }

  german <- selected[
    selected$sample_id == sample_id,
    c("infection", "infection_name", "estimate", "lower", "upper"),
    drop = FALSE
  ]

  european <- selected[
    selected$sample_id == "EU",
    c("infection", "estimate", "lower", "upper"),
    drop = FALSE
  ]

  if (
    nrow(german) == 0L ||
    !setequal(german$infection, european$infection)
  ) {
    stop("Both samples must contain the same non-empty infection set.")
  }

  names(german)[3:5] <- c(
    "germany_estimate", "germany_lower", "germany_upper"
  )

  names(european)[2:4] <- c(
    "eu_estimate", "eu_lower", "eu_upper"
  )

  result <- merge(german, european, by = "infection")

  result$measure <- measure
  result$german_sample <- sample_id
  result$difference <- result$germany_estimate - result$eu_estimate

  # A ratio is undefined when the reference estimate is zero.
  result$ratio <- ifelse(
    result$eu_estimate == 0,
    NA_real_,
    result$germany_estimate / result$eu_estimate
  )

  result$germany_rank <- rank(
    -result$germany_estimate,
    ties.method = "min"
  )

  result$eu_rank <- rank(
    -result$eu_estimate,
    ties.method = "min"
  )

  result <- result[
    order(result$germany_rank, result$infection),
    ,
    drop = FALSE
  ]

  rownames(result) <- NULL
  result
}
