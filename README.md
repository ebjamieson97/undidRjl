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
install.packages("JuliaCall")
library(JuliaCall)
install_julia()
```

### Utility Commands

#### 1. `checkundidversion()`

Arguments: none

Checks and prints the currently installed and the latest version of Undid.jl package. If the installed version is out of date, it will prompt you to consider updating using the function `updateundid()`.

#### 2. `updateundid()`

Arguments: none



