#' Load scripts necessary for the package.
#'
#' @description This function loads the necessary scripts for the package.
#' @return A list of scripts.
#' @keywords internal
load_Wizard_js <- function(){
  htmltools::htmlDependency(
    name = "Wizard-js",
    version = "1.9.9",
    package = "wizardR",
    src = "assets",
    script = "wizard.min.js"
  )
}

#' Load util wizard scripts necessary for the package.
#'
#' @description This function loads the necessary utils scripts for the package.
#' @return A list of scripts.
#' @keywords internal
load_wizard_utils <- function(){
  htmltools::htmlDependency(
    name = "wizard",
    version = "5.0.2",
    package = "wizardR",
    src = "assets",
    script = "wizard.js"
  )
}