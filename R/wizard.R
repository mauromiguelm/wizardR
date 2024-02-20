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
#' @param height height in vh
#' @param width width in vw or bootstrap size for modals (default, sm, lg, xl, fullscreen, fullscreen-sm-down, fullscreen-md-down, fullscreen-lg-down, fullscreen-xl-down, fullscreen-xxl-down)
#' @param options A list of options. See the documentation of 'Wizard-JS' (
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
    height = 60,
    width = 90,
    options = list()) {
  # check inputs
  orientation <- match.arg(orientation, c("horizontal", "vertical"))
  style <- match.arg(style, c("dots", "tabs", "progress"))

  # if ID is null, add a random id
  if (is.null(id)) {
    wiz_id <- sprintf("wizard-%s", paste(sample(c(letters, 1:10), 20), collapse = ""))
  } else {
    wiz_id <- id
  }

  # check if show_buttons is logical
  if (!is.logical(show_buttons)) {
    stop("show_buttons must be logical")
  }

  # TODO fix static_backdrop
  # check if static_backdrop is logical
  # if(!is.logical(static_backdrop)){
  #     stop("static_backdrop must be logical")
  # }

  if (is.numeric(width)) {
    bs_size <- "default"
    modal_width <- sprintf(".modal-default {--bs-modal-width: %svw;}", width)
  } else {
    bs_size <- width
    modal_width <- NULL
    size <- c(
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

    bs_size <- match.arg(bs_size, size)
  }

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

  content <- htmltools::div(
    class = "wizard-content container",
    # add height style
    style = sprintf("height: %svh;", height),
    ...
  )

  content <- htmltools::bindFillRole(content, container = TRUE)

  ui <- htmltools::div(
    class = "wizard",
    id = wiz_id,
    "data-configuration" = jsonlite::toJSON(options, auto_unbox = TRUE),
    "data-active-step" = "0",
    content,
    wizard_dependencies()
  ) # end of wizard

  if (modal) {
    if (is.null(id)) {
      stop("id must be provided if modal is TRUE")
    }

    ui <- (
      bsutils::modal(
        id = sprintf("wizard-modal-%s", id),
        bsutils::modalBody(ui),
        size = bs_size,
        tags$head(
          tags$style(
            HTML(modal_width)
          )
        )

        # static_backdrop = FALSE #TODO file a github issue on static_backdrop
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
    session = shiny::getDefaultReactiveDomain()) {
  step <- htmltools::div(
    ...,
    class = "wizard-step",
    "data-title" = step_title,
    session = session
  )
  htmltools::bindFillRole(step, item = TRUE, container = TRUE)
}

#' @name wizard_show
#' @title Show wizard
#' @description Show wizard
#' @param id wizard id
#' @param session shiny session
#' @export
wizard_show <- function(
    id,
    session = shiny::getDefaultReactiveDomain()) {
  if (missing(id)) stop("Missing `id`")

  id <- sprintf("wizard-modal-%s", id)

  session$sendCustomMessage(
    "wizard-modal",
    list(
      id = id
    )
  )
}
