
# wizardR

A user-friendly UI wizard that transforms complex tutorials or tasks into a sequence of steps.

## Installation

``` r
devtools::install_github("mauromiguelm/wizardR")
```


## Usage

``` r
wizard(  
    # add one or more steps
    wizard_step(
        ... # html content or shiny outputs
    )
)
```


## Example

You can find a demo example (with inputs and outputs) in `inst/app/App.R`. You can also run this demo `wizardR::run_app`.