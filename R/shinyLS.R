useLocalStorage <- function() {

  attachDependencies("", shinyLocalStorageDep)

}

setLocalStorage <- function(session, ...) {

  vals <- list(...)
  vals <- vals[names(vals) != ""]

  session$sendCustomMessage("setLocalStorage", vals)

}

storeInput <- function(tag) {
  tag$attribs$class <- paste(tag$attribs$class, "shiny-stored-input")
}
