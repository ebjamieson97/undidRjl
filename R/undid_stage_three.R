#' Compute the aggregate ATT.
#'
#' The `undid_stage_three` function combines the filled_diff_df.csv's and computes the aggregate ATT by silo, gvar, or (g,t).
#' 
#' @details If errors persist, check to see if there are missing diff_estiamtes in the filled_diff_df.csv's. If so, try setting interpolation = "linear_function"
#' 
#' @param dir_path A string filepath to folder containing all of the filled_diff_df.csv's
#' @param agg A string specifying the aggregation method. Either "silo", "g", or "gt". 
#' @param covariates A logical value (default `FALSE`), indicating whether to consider covariates
#' @param save_csv A logical value (default `FALSE`), indicating whether to save the combined_diff_df.csv
#' @param interpolation Takes in either `FALSE` or "linear_function" as options. Defaults to `FALSE`. Used to fill in missing values in the filled_diff_df.csv's
#' 
#' @import JuliaCall
#' @export
#' 
#' @examples
#' output <- undid_stage_three(filepath = "C:/Users/User/Downloads/", 
#' interpolation = "linear_function")
#' 
#' # To view the df
#' print(output)
#'
undid_stage_three <- function(dir_path, agg = "silo", covariates = FALSE, save_csv = FALSE, interpolation = FALSE){
  
  julia_eval("using Undid")
  
  julia_assign("dir_path", dir_path)
  julia_assign("agg", agg)
  julia_assign("covariates", covariates)
  julia_assign("save_csv", save_csv)
  julia_assign("interpolation", interpolation)
  
  output <- julia_eval("run_stage_three(dir_path, agg = agg, covariates = covariates, save_all_csvs = save_csv, interpolation = interpolation)")
  
  return(output)
  
}
