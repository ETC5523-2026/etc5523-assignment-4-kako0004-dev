#' Annual healthcare-associated infection burden in Germany
#'
#' Published estimates for five healthcare-associated infection types
#' in Germany in 2011, based on the representative German point
#' prevalence survey (PPS). Transcribed from Table 1 of
#' Zacher et al. (2019).
#'
#' @format A data frame with 30 rows and 11 columns:
#' \describe{
#'   \item{infection}{Infection code: HAP, SSI, BSI, UTI, CDI or All.}
#'   \item{measure}{Outcome: infections, deaths, dalys, yll or yld.}
#'   \item{estimate}{Published median estimate of annual burden.}
#'   \item{lower}{Lower limit of the 95 percent uncertainty interval.}
#'   \item{upper}{Upper limit of the 95 percent uncertainty interval.}
#'   \item{infection_name}{Full infection label.}
#'   \item{country}{Country represented by the estimate: Germany.}
#'   \item{year}{Reference year: 2011.}
#'   \item{sample}{Survey sample used for estimation.}
#'   \item{source_table}{Table number in the source article.}
#'   \item{unit}{Infections, attributable deaths or years.}
#' }
#'
#' @details
#' DALYs are disability-adjusted life years; YLLs are years of life
#' lost; YLDs are years lived with disability.
#'
#' Values are annual totals, not rates per 100,000 population.
#' The All category covers only the five infection types studied.
#' Keep it separate from individual infections to avoid double counting.
#'
#' Estimates are model-based and historical. Sums of individual
#' medians need not equal the published overall median.
#' These data do not describe current hospital conditions.
#'
#' @source
#' Zacher et al. (2019), Table 1, page 3.
#' \doi{10.2807/1560-7917.ES.2019.24.46.1900135}.
#' Article licensed under CC BY 4.0:
#' \url{https://creativecommons.org/licenses/by/4.0/}.
#' Published values were transcribed and rearranged into long format.
#'
#' @examples
#' head(hai_germany)
#' subset(hai_germany, measure == "dalys" & infection != "All")
"hai_germany"


#' Compare healthcare-associated infection burden across populations
#'
#' Published annual burden rates for five infection types, based on
#' representative and convenience samples from Germany and the
#' European Union/European Economic Area (EU/EEA) sample.
#' Transcribed from Table 2 of Zacher et al. (2019).
#'
#' @format A data frame with 54 rows and 12 columns:
#' \describe{
#'   \item{sample_id}{Sample code: DE_repr, DE_conv or EU.}
#'   \item{infection}{Infection code: HAP, UTI, BSI, SSI, CDI or All.}
#'   \item{measure}{Outcome: infections, deaths or dalys.}
#'   \item{estimate}{Published median annual rate per 100,000 population.}
#'   \item{lower}{Lower limit of the 95 percent uncertainty interval.}
#'   \item{upper}{Upper limit of the 95 percent uncertainty interval.}
#'   \item{infection_name}{Full infection label.}
#'   \item{sample}{Full survey sample label.}
#'   \item{population}{Germany or EU/EEA.}
#'   \item{survey_period}{Survey period: 2011 or 2011-2012.}
#'   \item{source_table}{Table number in the source article.}
#'   \item{unit}{Measure-specific unit per 100,000 population.}
#' }
#'
#' @details
#' PPS means point prevalence survey. DALYs are disability-adjusted
#' life years.
#'
#' All estimates are annual rates per 100,000 population.
#' The German samples are alternative estimates for the same country
#' and must not be combined. EU/EEA is a pooled comparison, not
#' individual country data.
#'
#' The All category covers only the five infection types studied.
#' Keep it separate from individual infections to avoid double counting.
#' Published overall medians need not equal sums of individual medians.
#'
#' These historical, model-based estimates include uncertainty.
#' Ranking point estimates alone does not establish conclusive
#' differences between infection types or populations.
#'
#' @source
#' Zacher et al. (2019), Table 2, page 5.
#' \doi{10.2807/1560-7917.ES.2019.24.46.1900135}.
#' Article licensed under CC BY 4.0:
#' \url{https://creativecommons.org/licenses/by/4.0/}.
#' Published values were transcribed and rearranged into long format.
#'
#' @examples
#' head(hai_comparison)
#' subset(hai_comparison, measure == "dalys" & infection == "All")
"hai_comparison"
