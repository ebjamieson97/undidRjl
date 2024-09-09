#' Updates Undid.jl to the latest version if Undid.jl is already installed.
#'
#' Updates Undid.jl to the latest version if Undid.jl is already installed.
#' @import JuliaCall
#' @export
updateundid <- function() {
  
  julia_eval("using Pkg; Pkg.rm(\"Undid\"); Pkg.add(url=\"https://github.com/ebjamieson97/Undid.jl\")")
  
}

