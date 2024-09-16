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

#### 3. `create_init_csv()`

Generates an initial `.csv` file (`init.csv`) specifying the silo names, start times, end times, and treatment times. This file is used to then create the `empty_diff_df.csv` which is sent to each silo.

**Arguments**:
- **`silo_names`** :: `character vector` or `NA` (defaults ~ `NA`) — A character vector of silo names, e.g. `c("71", "73")`.
- **`start_times`** :: `character vector` or `NA` (defaults ~ `NA`) — A character vector of start times, corresponding to the silos. 
- **`end_times`** :: `character vector` or `NA` (defaults ~ `NA`) — A character vector of end times, corresponding to the silos. 
- **`treatment_times`** :: `character vector` or `NA` (defaults ~ `NA`) — A character vector of treatment times or "control", indicating when treatment started for each silo. 
- **`covariates`** :: `character vector` or `FALSE` (optional) (defaults ~ `FALSE`) — A character vector of covariates, or `FALSE` to exclude covariates.


