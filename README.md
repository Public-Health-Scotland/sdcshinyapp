# sdcshinyapp
This package runs a Shiny app that is used to perform statistical disclosure control (SDC).

## Installation
To install `{sdcshinyapp}`, the `{remotes}` package is required.
```r
install.packages("remotes")
```

`{sdcshinyapp}` can then be installed directly from GitHub.
```r
remotes::install_github("Public-Health-Scotland/sdcshinyapp")
```

## Using sdcshinyapp
To see the documentation for any functions or included datasets, you can run `?sdcshinyapp::function_name` or `?sdcshinyapp::datasetname` in the console after installing the package.

First, load `{sdcshinyapp}`

```r
library(sdcshinyapp)
```

To run the shiny app locally.
```r
run_app()
```

Instructions on how to use the SDC App are given in the **Home** tab within the **App Instructions** subtab.
