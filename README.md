# undidRjl


## Installation 
```R
install.packages("devtools")
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

Arguments: none

#### 2. `updateundid()`

Updates Undid.jl to the latest version if Undid.jl is already installed.

Arguments: none

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
- **`covariates`** :: `character vector` or `FALSE` (optional, default: `FALSE`) — A character vector of covariates, or `FALSE` to exclude covariates.

**Examples**
```R
> create_init_csv(silo_names = c("ON", "QC"), start_times = c("2010", "2010"), end_times = c("2022", "2022"), treatment_times = c("control", "2016"))
init.csv saved to: C:/Users/User/Documents/init.csv 
  silo_name start_time end_time treatment_time
1        ON       2010     2022        control
2        QC       2010     2022           2016
```

#### 4. `create_diff_df()` - Returns a dataframe and prints a filepath.


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

