#' Load scripts necessary for the package.
#'
#' @description This function loads the necessary scripts for the package.
#'
#' @return A list of scripts.
load_script <- function(){
  htmltools::htmlDependency(
    name = "bootstrap",
    version = "v5.0.2",
    src = "assets",
    script = "/bootstrap.min.js"
  )
  htmltools::htmlDependency(
    name = "Wizard-JS",
    version = "v1.9.9",
    src = "assets",
    script = "/bootstrap.min.js"
  )
}