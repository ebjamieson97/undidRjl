#' Creates an initial .csv file (init.csv) specifying the silos, start times, end times, and treatment (or lack thereof) times.
#'
#' The `create_init_csv` function generates a CSV file with silo data, including start times, end times, and treatment times. 
#' The function can generate a blank CSV with just the headers, or it can take specific data inputs to pre-fill the CSV.
#' 
#' @details Ensure dates are entered consistently in the same format. 
#' Control silos should be marked as "control" in the `treatment_times` column. 
#' 
#' @param silo_names A character vector of silo names (e.g., "71", "73").
#' @param start_times A character vector of start times, corresponding to the silos.
#' @param end_times A character vector of end times, corresponding to the silos.
#' @param treatment_times A character vector of treatment times or "control", indicating when treatment started for each silo.
#' @param covariates A character vector of covariates (optional) or `FALSE` to exclude covariates.
#' 
#' @import JuliaCall
#' @export
#' 
#' @examples
#' # Example of how to use the create_init_csv function:
#' silo_names <- c("71", "73")
#' start_times <- c("1989", "1989")
#' end_times <- c("2000", "2000")
#' treatment_times <- c("1991", "control")
#' covariates <- c("asian", "black", "male")
#' 
#' # Generate and save the CSV file, and return the data frame
#' df <- create_init_csv(silo_names, start_times, end_times, treatment_times, covariates)
#' 
#' # Output the resulting data frame
#' print(df)
create_init_csv <- function(silo_names = NA, start_times = NA, end_times = NA, treatment_times = NA, covariates = FALSE) {
  
  # Force character to single entry Julia string vector
  # If covariates are not specified, set to false in Julia
  # Otherwise, pass specified covariates to Julia
  if ((typeof(covariates) == "character") & (length(covariates) == 1)){
    julia_assign("covariates", covariates)
    julia_eval("covariates = [covariates]")
  } 
  else if (is.logical(covariates) & identical(covariates, FALSE))  {
    julia_eval("covariates = false")
  } 
  else {
    julia_assign("covariates", covariates)
  }
  
  # If options have not been specified, produce a blank .csv
  if (all(is.na(silo_names)) & all(is.na(start_times)) & all(is.na(end_times)) & all(is.na(treatment_times))) {
    filepath <- julia_eval("create_init_csv(covariates = covariates)")
  } 
  else {
    julia_assign("silo_names", silo_names)
    julia_assign("start_times", start_times)
    julia_assign("end_times", end_times)
    julia_assign("treatment_times", treatment_times)
    filepath <- julia_eval("create_init_csv(silo_names, start_times, end_times, treatment_times, covariates = covariates)")
  }
  
  julia_assign("filepath", filepath)
  df <- julia_eval("read_csv_data(filepath)")
  
  # Fixes some weird Julia to R problem where elements are duplicated
  if (nrow(df) >= 1 && "covariates" %in% colnames(df)) {
    covariates = df$covariates[1]
    df$covariates <- list(covariates)
  }
  
  # Print filepath and return df
  filepath <- gsub("\\\\", "/", filepath)
  cat("init.csv saved to:", filepath, "\n")
  return(df)
  
}
 