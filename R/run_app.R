#' Run a demo app for the wizardR package
#'
#' @description Run a demo app for the wizardR package
#'
#' @export
run_app <- function() {
  shiny::runApp(
    system.file("app/app.R", package = "wizardR")
  )
}
