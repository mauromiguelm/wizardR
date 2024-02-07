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
                class = "wizard-content container",
                ...
            ) # end of wizard-content container
        ) # end of wizard
    ) # end of tagList
}


# add wizard step
wizard_step <- function(...){
    shiny::tagList(
        htmltools::div(
            class = "wizard-step",
            ...
        )
    )
}

