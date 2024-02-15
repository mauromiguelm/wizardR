#' Load the Wizard-JS scripts necessary for the package.
#'
#' @description This function loads the necessary Wizard-JS js and css scripts for the package.
#' @return A list of scripts.
#' @keywords internal
load_wizard_js <- function(){
  shiny::addResourcePath(
    prefix = 'wizard-css', directoryPath = system.file('Wizard-JS', package='wizardR')
  )
  shiny::tags$head(
    shiny::tags$link(rel="stylesheet", type="text/css", href="wizard-css/main.css"),
    htmltools::htmlDependency(
      name = "Wizard-js",
      version = "1.9.9",
      package = "wizardR",
      src = "Wizard-JS",
      script = "wizard.min.js"
      )
  )
}

#' Load util wizard scripts necessary for the package.
#'
#' @description This function loads the necessary utils scripts for the package.
#' @return A list of scripts.
#' @keywords internal
load_wizard_utils <- function(){
    shiny::addResourcePath(
    prefix = 'wizard-css', directoryPath = system.file('Wizard-JS', package='wizardR')
  )
  shiny::tags$head(
    htmltools::htmlDependency(
      name = "wizard",
      version = utils::packageVersion("wizardR"),
      package = "wizardR",
      src = "",
      script = "main.js"
    ),
    htmltools::htmlDependency(
      name = "wizard-utils",
      version = utils::packageVersion("wizardR"),
      package = "wizardR",
      src = "",
      script = "utils.js"
    )
  )
}