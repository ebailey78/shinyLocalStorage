#'useLocalStorage
#'
#'Adds dependencies to shiny app necessary to access local storage from the
#'server function.
#'
#'This function should be included somewhere in your shiny app's ui. It will
#'attach the dependencies needed to make \code{shinyLocalStorage} work. If you
#'use any other \code{shinyLocalStorage} functions in your ui, such as
#'\code{\link{storeInput}}, this function isn't needed.
#'
#'@export
useLocalStorage <- function() {

  attachDependencies("", shinyLocalStorageDep)

}

#'setLocalStorage
#'
#'Set localStorage values in the user's browser what will be accessible by the
#'app the next time the user accesses the page.
#'
#'Each value passed to \code{setLocalStorage} should be named. Any unnamed value
#'will be silently dropped. Values set with \code{setLocalStorage} can be accessed
#'in the server from \code{input$localStorage}. For example, if you set \code{x = 5}
#'with \code{setLocalStorage} you can access that value from \code{input$localStorage$x}.
#'
#'@param session The session object passed to function given to shinyServer
#'@param \dots Any values you want to add to localStorage in the user's browser.
#'@param .dots A list of values you want to add to localStorage in the user's browser.
#'
#'@export
setLocalStorage <- function(session, ..., .dots) {

  vals <- list(...)

  if(!missing(.dots)) {
    vals <- unique(c(vals, .dots))
  }

  vals <- vals[names(vals) != ""]

  session$sendCustomMessage("setLocalStorage", vals)

}

#'storeInput
#'
#'Automatically store and retrieve values for the wrapped input. (Experimental)
#'
#'This function is not yet working.
#'
#'@param tag An input element whose value you want to store in localStorage
#'
#'@export
storeInput <- function(tag) {
  tag$attribs$class <- paste(tag$attribs$class, "shiny-local-storage")
  return(attachDependencies(tag, shinyLocalStorageDep))
}
