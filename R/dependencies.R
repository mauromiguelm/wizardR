#' Load util wizard scripts necessary for the package.
#'
#' @description This function loads the necessary utils scripts for the package.
#' @return A list of scripts.
#' @keywords internal
wizard_dependencies <- function(){
  htmltools::htmlDependency(
    name = "wizard",
    version = utils::packageVersion("wizardR"),
    package = "wizardR",
    src = "",
    stylesheet = c("Wizard-JS/main.css", "fill.css"),
    script = c("Wizard-JS/wizard.min.js", "utils.js", "main.js")
  )
}