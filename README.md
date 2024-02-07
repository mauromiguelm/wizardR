
# wizardR: A simple UI to break down complex tasks into steps.

A user-friendly UI wizard that transforms complex tutorials or tasks into a sequence of steps.

## Installation

```
devtools::install_github("mauromiguelm/wizardR)
```R


## Usage

```
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

```R