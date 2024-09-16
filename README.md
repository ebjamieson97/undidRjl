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

1. **checkundidversion()**

```R
> checkundidversion()
Currently installed version of Undid.jl is: 0.1.13. 
Latest version of Undid.jl is: 0.1.13 
Consider calling function `updateundid` if installed version is out of date.
```
