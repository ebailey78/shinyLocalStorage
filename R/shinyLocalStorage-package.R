#' shinyLocalStorage
#'
#' @name shinyLocalStorage
#' @docType package
NULL

shinyLocalStorageDep <- htmlDependency("shinyLocalStorage", packageVersion("shinyLocalStorage"),
                                  src = system.file("www", package = "shinyLocalStorage"),
                                  script = "shinyLS.js")

