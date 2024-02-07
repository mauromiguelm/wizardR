
# wizardR

A user-friendly UI wizard that transforms complex tutorials or tasks into a sequence of steps.

## Installation

``` r
devtools::install_github("mauromiguelm/wizardR)
```


## Usage

``` r
wizard(  
    # configuration of widget 
    orientation = "horizontal",
    style = "progress",
    show_buttons = FALSE,
    
    # add one or multiple steps
    wizard_step(
        ... # html content or shiny outputs
    )
)
```


## Example

You can find a demo example (with inputs and outputs) in `inst/app/App.R`. You can also run this demo `wizardR::run_app`.