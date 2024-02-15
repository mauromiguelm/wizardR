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
#' @param id wizard id
#' @param modal modal 
#' @param modal_size modal size (default, sm, lg, xl, fullscreen, fullscreen-sm-down, fullscreen-md-down, fullscreen-lg-down, fullscreen-xl-down, fullscreen-xxl-down)
#' @param options A list of options. See the documentation of
#'   'Wizard-JS' (<URL: https://github.com/AdrianVillamayor/Wizard-JS>) for
#'   possible options.
#' @return wizard html
#' @export
wizard <- function(
    ...,
    orientation = "horizontal",
    style = "progress",
    show_buttons = TRUE,
    id = NULL,
    modal = TRUE,
    options = list(),
    modal_size = "xl"
    ){
    
    # check inputs
    orientation <- match.arg(orientation, c("horizontal", "vertical"))
    style <- match.arg(style, c("dots", "tabs", "progress"))
    
    # check if show_buttons is logical
    if(!is.logical(show_buttons)){
        stop("show_buttons must be logical")
    }
    
    size = c(
        "default",
        "sm",
        "lg",
        "xl",
        "fullscreen",
        "fullscreen-sm-down",
        "fullscreen-md-down",
        "fullscreen-lg-down",
        "fullscreen-xl-down",
        "fullscreen-xxl-down"
    )

    modal_size <- match.arg(modal_size, size)
    
    show_buttons <- switch(show_buttons,
        "TRUE" = "true",
        "FALSE" = "false"
    )

    # handle wizard-JS options
    options <- utils::modifyList(
        # default list
        list(
            "wz_ori" = orientation,
            "wz_nav_style" = style,
            "buttons" = show_buttons
        ),
        options
    )

    ui <- htmltools::div(
        class = "wizard",
        "data-configuration" = jsonlite::toJSON(options, auto_unbox = TRUE),
        htmltools::div(
            class = "wizard-content container",
            ...
        ), # end of wizard-content container
        load_wizard_js(),
        load_wizard_utils()
    ) # end of wizard

    if(modal){
        # stop if id is null
        if (is.null(id)) {
            stop("id must be provided if modal is TRUE")
        }

        ui <- (
            bsutils::modal(
                id = id,
                ui,
                size = modal_size
            )
        )
    }

    return(ui)
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