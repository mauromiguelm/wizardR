#' @export
lock <- function(
    id,
    session = shiny::getDefaultReactiveDomain()
    ){
    session$sendInputMessage(id, "lock")
}


#' @export
unlock <- function(
    id,
    session = shiny::getDefaultReactiveDomain()
    ){
    session$sendInputMessage(id, "unlock")
}
