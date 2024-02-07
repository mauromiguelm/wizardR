#' start wizard
#'
#' @description start wizard
#'
#' @return wizard html
#' @export
wizard <- function(
    orientation = c("horizontal", "vertical"),
    style = c("dots", "tabs", "progress"),
    show_buttons = c(TRUE, FALSE),
    ...
    ){
    
    orientation <- match.arg(orientation)
    style <- match.arg(style)
    
    if(!is.logical(show_buttons)){
        stop("show_buttons must be logical")
    } 
    
    show_buttons <- switch(show_buttons,
        "TRUE" = "true",
        "FALSE" = "false"
    )

    shiny::tagList(
        load_Wizard_js(),
        load_Wizard_css(),
        load_wizard_utils(),
        htmltools::div(
            class = "wizard",
            "data-orientation" = orientation,
            "data-style" = style,
            "data-show-buttons" = show_buttons,
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