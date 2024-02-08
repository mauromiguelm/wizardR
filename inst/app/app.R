library(shiny)
library(wizardR)

ui <- fluidPage(
  "wizardR demo",
    theme = bslib::bs_theme(version = 5L),
    wizard(
      # start sequence of steps
      wizard_step(
        step_title = "Hello tag",
        shiny::h5("hello, this is step 0.")
      ),
      wizard_step(
        step_title = "Text output",
        textOutput("text")
        
      ),
      wizard_step(
        step_title = "Plot output",
        plotOutput("plot")
      ),
      wizard_step(
        shiny::h5("No step title defined. This is the last step.")
      )
    )
)

server <- function(input, output, session) {
  
  output$plot <- renderPlot({
    plot(cars)
  })

  output$text <- renderText({
    "hello world"
  })

}

shinyApp(ui, server)
