#' start wizard component
#'
#' This file contains the implementation of the wizard functionality in R.
#' The wizard module provides various functions and utilities for performing magical operations.
#' It includes functions for casting spells, brewing potions, and summoning mystical creatures.
#' Use this module to unleash your inner wizard and explore the world of R magic!
#'
#' @param ... wizard content
#' @param orientation wizard orientation (horizontal or vertical)
#' @param style wizard style (dots, tabs or progress)
#' @param show_buttons show buttons or not (TRUE or FALSE)
#' @return wizard html
#' @export
wizard <- function(
    ...,
    orientation = c("horizontal"),
    style = c("progress"),
    show_buttons = c(TRUE),
    id = NULL,
    options = list()
    ){
    
    orientation <- match.arg(orientation, c("horizontal", "vertical"))
    style <- match.arg(style, c("dots", "tabs", "progress"))
    
    if(!is.logical(show_buttons)){
        stop("show_buttons must be logical")
    } 
    
    show_buttons <- switch(show_buttons,
        "TRUE" = "true",
        "FALSE" = "false"
    )
    

    # handle wizard-JS options
    options <- modifyList(
        # default list
        list(
            "wz_ori" = orientation,
            "wz_nav_style" = style,
            "buttons" = show_buttons
        ),
        options
    )

    htmltools::div(
        id = id,
        class = "wizard",
        "data-configuration" = jsonlite::toJSON(options, auto_unbox = TRUE),
        htmltools::div(
            class = "wizard-content container",
            ...
        ), # end of wizard-content container
        load_Wizard_js(),
        load_Wizard_css(),
        load_main_js()
    ) # end of wizard
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
    htmltools::div(
        ...,
        class = "wizard-step",
        "data-title" = step_title,
        session = session
    )
}