library(shiny)
library(wizardR)

ui <- fluidPage(
  "wizardR demo",
    theme = bslib::bs_theme(version = 5L),
    wizard(
      orientation = "horizontal",
      style = "progress",
      show_buttons = TRUE,
      wizard_step(
        h5("hello")
      ),
      wizard_step(
        textOutput("text")
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

  output$text <- renderText({
    "hello world"
  })

}

shinyApp(ui, server)
