#' Load scripts necessary for the package.
#'
#' @description This function loads the necessary scripts for the package.
#' @return A list of scripts.
#' @keywords internal
load_wizard <- function(){
  htmltools::htmlDependency(
    name = "wizard",
    version = "5.0.2",
    src = "assets",
    script = "wizard.min.js"
  )
}