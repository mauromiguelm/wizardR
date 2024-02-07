#' start wizard
#'
#' @description start wizard
#'
#' @return wizard html
#' @export
wizard <- function(
    orientation = c("horizontal", "vertical"),
    ...
    ){
    
    orientation <- match.arg(orientation)
    
    shiny::tagList(
        load_Wizard_js(),
        load_Wizard_css(),
        load_wizard_utils(),
        htmltools::div(
            class = "wizard",
            "data-orientation" = orientation,
            htmltools::div(
                class = "wizard-content container",
                ...
            ) # end of wizard-content container
        ) # end of wizard
    ) # end of tagList
}

#' Add a step to the wizard
#'
#' @description Add a step to the wizard
#'
#' @return wizard step html
#' @export
wizard_step <- function(...){
    shiny::tagList(
        htmltools::div(
            class = "wizard-step",
            ...
        )
    )
}