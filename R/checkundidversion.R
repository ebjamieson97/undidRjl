#' Checks and prints the currently installed and the latest version of Undid.jl package
#'
#' Checks and prints the currently installed and the latest version of Undid.jl package
#' @import JuliaCall
#' @export
checkundidversion <- function() {

  first_string <- julia_eval("using Pkg; if Base.find_package(\"Undid\") === nothing; println(\"Undid.jl not found. Installing now.\"); Pkg.add(url=\"https://github.com/ebjamieson97/Undid.jl\"); println(\"Undid.jl done installing.\");else; deps = Pkg.dependencies(); package_version = deps[Base.UUID(\"b4918ae7-7c73-4176-80be-8405760cf2ee\")].version; current_Undid_version = string(package_version); end; string(\"Currently installed version of Undid.jl is: \", current_Undid_version, \".\")")
  second_string <- julia_eval("using Downloads; try; url = \"https://raw.githubusercontent.com/ebjamieson97/Undid.jl/main/Project.toml\"; content = Downloads.download(url); file_content = read(content, String); start_pos = findfirst(\"version = \", file_content); output = file_content[start_pos[end]+2:start_pos[end]+8]; catch e; println(\"An error occurred: \", e, \"Check your internet connection.\"); end")
  second_string <- gsub('\\"', '', second_string)
  cat(first_string, "\nLatest version of Undid.jl is:", second_string, "\nConsider calling function `updateundid` if installed version is out of date.")
  
}
