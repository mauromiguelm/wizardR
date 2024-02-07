library(shiny)
library(wizardR)

ui <- fluidPage(
  "wizardR demo",
  theme = bslib::bs_theme(version = 5L),
    wizard(
      orientation = "horizontal",
      style = "progress",
      wizard_step(
        h5("hello")
      ),
      wizard_step(
        h5("world")
      ),
      wizard_step(
        plotOutput("plot")
      )
    )
)

server <- function(input, output, session) {
  
  output$plot <- renderPlot({
    plot(cars)
  })

}

shinyApp(ui, server)
