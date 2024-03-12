#' @title Lock wizard
#' 
#' Server-side function to lock the wizard.
#' 
#' @param id wizard id
#' @param session shiny session
#' @export
lock <- function(
    id, 
    session = shiny::getDefaultReactiveDomain()
    ){
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
    session = shiny::getDefaultReactiveDomain()
    ){
    session$sendInputMessage(id, list(type = "unlock"))
}
