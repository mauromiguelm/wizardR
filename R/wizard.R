#' start wizard
#'
#' @description start wizard
#'
#' @return wizard html
#' @export
wizard <- function(...){
    shiny::tagList(
        load_Wizard_js(),
        load_Wizard_css(),
        load_wizard_utils(),
        htmltools::div(
            class = "wizard",
            htmltools::div(
                class = "wizard-step",
                htmltools::h2("hello")
            ),
            htmltools::div(
                class = "wizard-step",
                htmltools::h2("world")
            )
        )
    )
}