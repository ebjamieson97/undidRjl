#' TITLE
#'
#' The `undid_stage_two` function DESCRIPTION.
#' 
#' @details ADD_DETAILS_HERE
#' 
#' @param filepath A string filepath to the empty_diff_df.csv
#' @param local_silo_name A string specifying the name of the local silo as it is written in the empty_diff_df.csv
#' @param silo_data A dataframe containing the local silo's data
#' @param time_column A string specifying the name of the column with the time/date information
#' @param outcome_column A string specifying the name of the column with outcome of interest data
#' @param local_date_format A string indicating the format of the dates in the data
#' @param consider_covariates A logical value (default `TRUE`), indicating whether to consider covariates
#' 
#' @import JuliaCall
#' @export
#' 
#' @examples
#' silo_data <- read_dta("C:/Users/User/Documents/Data/State71.dta")
#' output <- undid_stage_two(filepath = "C:/Users/User/Downloads/empty_diff_df.csv", 
#' local_silo_name = "71", 
#' silo_data = silo_data, 
#' time_column = "year", 
#' outcome_column = "coll", 
#' local_date_format = "yyyy")
#' 
#' # To view the filled_diff_data:
#' print(output[[1]][2])
#' 
#' # To view the trends_data
#' print(output[[2]][2])
#' 
undid_stage_two <- function(filepath, local_silo_name, silo_data, time_column, outcome_column, local_date_format, consider_covariates = TRUE){
  
  julia_eval("using Undid")
  
  # Change \\ to / and assign all variables in Julia
  filepath <- gsub("\\\\", "/", filepath)
  julia_assign("filepath", filepath)
  julia_assign("local_silo_name", local_silo_name)
  julia_assign("silo_data", silo_data)
  julia_assign("time_column", time_column)
  julia_assign("outcome_column", outcome_column)
  julia_assign("local_date_format", local_date_format)
  julia_assign("consider_covariates", consider_covariates)
  
  output <- julia_eval("run_stage_two(filepath, local_silo_name, silo_data, time_column, outcome_column, local_date_format, renaming_dictionary = false, consider_covariates = consider_covariates)")
  
  return(output)
  
}