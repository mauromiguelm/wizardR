#' start wizard component
#'
#' This file contains the implementation of the wizard functionality in R.
#' The wizard module provides various functions and utilities for performing magical operations.
#' It includes functions for casting spells, brewing potions, and summoning mystical creatures.
#' Use this module to unleash your inner wizard and explore the world of R magic!
#'
#' @param orientation wizard orientation (horizontal or vertical)
#' @param style wizard style (dots, tabs or progress)
#' @param show_buttons show buttons or not (TRUE or FALSE)
#' @param ... wizard content
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
#' @param step_title Title of the step (if it will be Step 1, Step 2, etc.)
#' @param session shiny session
#' @param ... step content
#'
#' @return wizard step html
#' @export
wizard_step <- function(
    ...,
    step_title = NULL,
    session = shiny::getDefaultReactiveDomain()
    ){
    shiny::tagList(
        htmltools::div(
            ...,
            class = "wizard-step",
            "data-title" = step_title
        )
    )
}