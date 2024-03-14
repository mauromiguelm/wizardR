#' @title Lock wizard
#'
#' Server-side function to lock the wizard.
#'
#' @param id wizard id
#' @param session shiny session
#' @export
lock <- function(
    id,
    session = shiny::getDefaultReactiveDomain()) {
  if (missing(id)) stop("Missing `id`")
  session$sendInputMessage(id, list(type = "lock"))
}

#' @title Unlock wizard
#'
#' Server-side function to unlock the wizard.
#'
#' @param id wizard id
#' @param session shiny session
#' @export
unlock <- function(
    id,
    session = shiny::getDefaultReactiveDomain()) {
  if (missing(id)) stop("Missing `id`")
  session$sendInputMessage(id, list(type = "unlock"))
}

#' @title Show wizard
#'
#' @name wizard_show
#'
#' @description Show wizard
#'
#' @param id wizard id
#' @param session shiny session
#' @export
wizard_show <- function(
    id,
    session = shiny::getDefaultReactiveDomain()) {
  if (missing(id)) stop("Missing `id`")

  # session$sendInputMessage(id, list(type = "show"))
  # id <- sprintf("wizard-modal-%s", id)
   id <- sprintf("wizard-modal-%s", id)

  session$sendCustomMessage(
    "wizard-modal",
    list(
      id = id
    )
  )
}
