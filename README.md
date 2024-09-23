# undidRjl


## Installation 
```R
install.packages("devtools") # if devtools is not already installed
devtools::install_github("ebjamieson97/undidRjl") 
```

## Requirements
* JuliaCall package for R
* Julia 1.9.4 or later

JuliaCall and Julia itself can be downloaded by calling
```R
install.packages("JuliaCall") # installs JuliaCall
library(JuliaCall) # loads JuliaCall
install_julia() # installs Julia
```

### Utility Commands

#### 1. `checkundidversion()`

Checks and prints the currently installed and the latest version of Undid.jl package. If the installed version is out of date, it will prompt you to consider updating using the function `updateundid()`. If Undid.jl is not installed, installs Undid.jl.


#### 2. `updateundid()`

Updates Undid.jl to the latest version if Undid.jl is already installed.


## Stage One: Initialize

#### 3. `create_init_csv()` - Returns a dataframe and prints a filepath.

Generates an initial `.csv` file (`init.csv`) specifying the silo names, start times, end times, and treatment times. This file is then used to create the `empty_diff_df.csv`, which is sent to each silo. If `create_init_csv()` is called without providing any silo names, start times, end times, or treatment times, an `init.csv` will be created with the appropriate column headers and blank columns. 

Covariates may be specified when calling `create_init_csv()` or when calling `create_diff_df()`.

Ensure that dates are all entered in the same date format, a list of acceptable date formats can be seen [here.](#valid-date-formats)

**Arguments**:
- **`silo_names`** :: `character vector` or `NA` (default: `NA`) — A character vector of silo names, e.g., `c("71", "73")`.
- **`start_times`** :: `character vector` or `NA` (default: `NA`) — A character vector of start times corresponding to the silos.
- **`end_times`** :: `character vector` or `NA` (default: `NA`) — A character vector of end times corresponding to the silos.
- **`treatment_times`** :: `character vector` or `NA` (default: `NA`) — A character vector of treatment times, or `"control"` to indicate when treatment started for each silo.
  
- (optional) **`covariates`** :: `character vector` or `FALSE` (default: `FALSE`) — A character vector of covariates, or `FALSE` to exclude covariates.

**Examples**
```R
> create_init_csv(silo_names = c("ON", "QC"), start_times = c("2010", "2010"), end_times = c("2022", "2022"), treatment_times = c("control", "2016"))
init.csv saved to: C:/Users/User/Documents/init.csv 
  silo_name start_time end_time treatment_time
1        ON       2010     2022        control
2        QC       2010     2022           2016
```

#### 4. `create_diff_df()` - Returns a dataframe and prints a filepath.

Generates the `empty_diff_df.csv` file specifying all of the relevant regressions that are to be run at each silo. The `empty_diff_df.csv` file is sent to each silo in order to be filled out.

Covariates may be specified when calling `create_init_csv()` or when calling `create_diff_df()`.

**Arguments**:
- **`filepath`** :: `character` — Filepath to the `init.csv`.
- **`date_format`** :: `character` — Specify the [format](#valid-date-formats) of the dates in the `init.csv`.
- **`freq`** :: `character` — Specify the frequency of the data to be analyzed ("daily", "weekly", "monthly", or "yearly").

- (optional) **`covariates`** :: `character vector` or `FALSE` (default: `FALSE`) — Vector of covariates or `FALSE` to use covariates found in the `init.csv`.
- (optional) **`freq_multiplier`** :: `integer` or `FALSE` (default: `FALSE`) — An integer, if required, to multiply with the freq (e.g. if you are analyzing data that is collected every 3 months you would set freq_multiplier = 3 and freq = "monthly")

**Examples**
```R
> create_diff_df("C:/Users/User/Documents/init.csv", "yyyy", "yearly")
empty_diff_df.csv saved to: C:/Users/User/Documents/empty_diff_df.csv 
  silo_name treat common_treatment_time start_time   end_time diff_estimate diff_var diff_estimate_covariates diff_var_covariates covariates date_format    freq
1        ON     0                  2016 2010-01-01 2022-01-01       missing  missing                  missing              missing       none        yyyy 1 year
2        QC     1                  2016 2010-01-01 2022-01-01       missing  missing                  missing              missing       none        yyyy 1 year 
```

## Stage Two: Silo

#### 5. `undid_stage_two()` - 

The `undid_stage_two()` function uses date information from the `empty_diff_df.csv` and the local silo data to fill in the necessary diff_estimates.

**Arguments**:
- **`filepath`** :: `character` — Filepath to the `empty_diff_df.csv`.
- **`silo_data`** :: `list` — Dataframe of the local silo data. 
- **`time_column`** `character` — Name of column where the time/date information is stored in the `silo_data`.
- **`outcome_column`** `character` — Name of column where the outcome of interest data is stored in the `silo_data`.
- **`local_date_format`** `character` — [Format](#valid-date-formats) of the dates in the `time_column`.
- (optional) **`consider_covariates`** `logical` (default: `TRUE`) — If set to `FALSE`, ignores carrying out the calculations to fill the column `diff_estimate_covariates`.

**Examples**
```R
silo_data <- read_dta("C:/Users/User/Documents/Data/QC.dta")
output <- undid_stage_two(filepath = "C:/Users/User/Downloads/empty_diff_df.csv", 
local_silo_name = "QC", 
silo_data = silo_data, 
time_column = "year", 
outcome_column = "coll", 
local_date_format = "yyyy")

# To view the filled_diff_data:
print(output[[1]][2])

# To view the trends_data
print(output[[2]][2])
```

## Stage Three: Analysis

#### 6. `undid_stage_three()` - 

Ipsum lorem

**Arguments**:

**Examples**
```R
```

#### 7. `plot_parallel_trends()` - 

Ipsum lorem

**Arguments**:

**Examples**
```R
```

## Appendix

#### Valid Date Formats
- `ddmonyyyy` → 25aug1990
- `yyyym00` → 1990m8
- `yyyy/mm/dd` → 1990/08/25
- `yyyy-mm-dd` → 1990-08-25
- `yyyymmdd` → 19900825
- `yyyy/dd/mm` → 1990/25/08
- `yyyy-dd-mm` → 1990-25-08
- `yyyyddmm` → 19902508
- `dd/mm/yyyy` → 25/08/1990
- `dd-mm-yyyy` → 25-08-1990
- `ddmmyyyy` → 25081990
- `mm/dd/yyyy` → 08/25/1990
- `mm-dd-yyyy` → 08-25-1990
- `mmddyyyy` → 08251990
- `mm/yyyy` → 08/1990
- `mm-yyyy` → 08-1990
- `mmyyyy` → 081990
- `yyyy` → 1990

