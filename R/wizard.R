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
#' @param flex Convert the wizard to a flex container (TRUE or FALSE). flex will convert display: block to display: flex and add the htmltools::bindFillRole attribute to the wizard content.
#' @param lock_start lock the wizard at the start (TRUE or FALSE)
#' @param header show header or not (TRUE or FALSE)
#' @param header_title header title
#' @param static_backdrop static backdrop or not (TRUE or FALSE)
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
    height = 50,
    width = 90,
    flex = TRUE,
    lock_start = FALSE,
    header = TRUE,
    header_title = "Wizard",
    static_backdrop = TRUE,
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

  # check if flex is logical
  if (!is.logical(flex)) {
    stop("flex must be logical")
  }

  # check if lock_start is logical
  if (!is.logical(lock_start)) {
    stop("lock_start must be logical")
  }

  
  # check if static_backdrop is logical
  if(!is.logical(static_backdrop)){
      stop("static_backdrop must be logical")
  }

  # check if header is logical
  if (!is.logical(header)) {
    stop("header must be logical")
  }

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
      "buttons" = show_buttons,
      "lock_start" = lock_start
    ),
    options
  )

  steps <- list(...)

  first_step_title <- "Step 0"

  if (length(steps) > 0) {
    # get data-title with htmltools::htmlAttributes

    first_step_title <- htmltools::tagGetAttribute(steps[[1]], "data-title")

    first_step_title <- ifelse(is.null(first_step_title), "Step 0", first_step_title)
  }

  if (length(steps) > 0 && flex) {
    # iterate over steps and apply flex
    for (i in 1:length(steps)) {
      steps[[i]] <- htmltools::bindFillRole(steps[[i]], item = TRUE, container = TRUE)
    }
  }

  # max-width fit-content if flex is TRUE
  container_style <- ifelse(flex, "max-width: fit-content;", "")

  # add height to container style
  container_style <- sprintf("%sheight: %svh;", container_style, height)

  content <- htmltools::div(
    class = "wizard-content container",
    # add height style
    style = container_style,
    steps
  )

  if (flex) {
    content <- htmltools::bindFillRole(content, container = TRUE)
  }

  ui <- htmltools::div(
    class = "wizard",
    id = wiz_id,
    "data-configuration" = jsonlite::toJSON(options, auto_unbox = TRUE),
    "data-active-step" = "0",
    # set data title to the title of the first step
    "data-title" = first_step_title,
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
        static_backdrop = static_backdrop,
        if(header){
          bsutils::modalHeader(
            title = header_title,
            close_button = TRUE
          )
        },
        bsutils::modalBody(ui),
        size = bs_size,
        htmltools::tags$head(
          htmltools::tags$style(
            htmltools::HTML(modal_width)
          )
        )
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
  htmltools::div(
    ...,
    class = "wizard-step",
    "data-title" = step_title,
    session = session
  )
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

  session$sendInputMessage(id, list(type = "show"))
}
