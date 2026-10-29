#' Launch the healthcare-associated infection explorer
#'
#' Opens an interactive Shiny application for comparing published
#' infection burden estimates for Germany and the EU/EEA.
#'
#' @return Starts the Shiny application.
#' @export
#'
#' @examples
#' \dontrun{
#' run_app()
#' }
run_app <- function() {

  app_directory <- system.file(
    "shiny",
    "haiburden",
    package = "haiburden"
  )

  if (app_directory == "") {
    stop("Could not find the app. Reload or reinstall haiburden.")
  }

  shiny::runApp(appDir = app_directory)
}
