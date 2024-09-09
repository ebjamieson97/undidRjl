#' Creates the empty_diff_df.csv to be sent out to all the silos.
#'
#' The `create_diff_df` function generates a CSV file with missing values for that are then filled at the appropriate silos.
#' 
#' @details Ensure dates are entered consistently in the same format. 
#' Control silos should be marked as "control" in the `treatment_times` column. 
#' 
#' @param filepath A string filepath to the init.csv
#' @param date_format A string indicating the format of the dates in the init.csv
#' @param freq A string indicating the frequency of the data to be analyzed (e.g. monthly, yearly)
#' @param covariates A character vector of covariates (optional) or `FALSE` to exclude to use covariates found in the init.csv
#' @param freq_multiplier An integer, if required, to multiply with the freq (e.g. if you are analyzing data that is collected every 3 months you would set freq_multiplier = 3 and freq = "monthly")
#' 
#' @import JuliaCall
#' @export
#' 
#' @examples
#' df = create_diff_df("C:/Users/User/Project Files/init.csv", "yyyy", "yearly")
create_diff_df <- function(filepath, date_format, freq, covariates = FALSE, freq_multiplier = FALSE) { 
  
  # Pass strings to Julia
  julia_assign("filepath", filepath)
  julia_assign("date_format", date_format)
  julia_assign("freq", freq)
  
  
  # Parse covariates to Julia
  if (is.logical(covariates) & identical(covariates, FALSE)) {
    julia_eval("covariates = false")
  }
  else if ((typeof(covariates) == "character") & (length(covariates) == 1)){
    julia_assign("covariates", covariates)
    julia_eval("covariates = [covariates]")
  } 
  else {
    julia_assign("covariates", covariates)
  } 
  
  # Parse freq_multiplier to Julia
  if (is.logical(freq_multiplier) & identical(freq_multiplier, FALSE)) {
    julia_eval("freq_multiplier = false")
  }
  else {
    julia_assign("freq_multiplier", freq_multiplier)
    julia_eval("freq_multipler = Int(freq_multiplier)")
  }
  
  # Run Undid.jl function
  julia_eval("outputs = create_diff_df(filepath, covariates = covariates, date_format = date_format, freq = freq, freq_multiplier = freq_multiplier, confine_matching = true)")
  save_path <- julia_eval("outputs[1]")
  empty_diff_df <- julia_eval("string.(outputs[2])")
  
  
  # Print filepath and return df
  save_path <- gsub("\\\\", "/", save_path)
  cat("empty_diff_df.csv saved to:", save_path, "\n")
  return(empty_diff_df)

}
