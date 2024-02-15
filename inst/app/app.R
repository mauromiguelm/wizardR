library(shiny)
library(wizardR)

ui <- fluidPage(
  "wizardR demo",
    theme = bslib::bs_theme(version = 5L),
    # add button
    actionButton("show_wizard", "Show wizard"),
    wizard(
      modal = TRUE,
      id = "my_modal",
      # start sequence of steps
      wizard_step(
        step_title = "Hello tag",
        shiny::h5("hello, this is step 0.")
      ),
      wizard_step(
        step_title = "Numeric input",
        shiny::numericInput("number", "Select a number", value = 30, min = 20, max = 100)
      ),
      wizard_step(
        step_title = "Plot output from input",
        plotOutput("plot")
      ),
      wizard_step(
        shiny::h5("No step title defined. This is the last step.")
      )
    )
)

server <- function(input, output, session) {
  
  output$plot <- renderPlot({
    plot(1:input$number, rnorm(input$number))
  })

  output$text <- renderText({
    "hello world"
  })

  # show the wizard
  observeEvent(input$show_wizard, {
    wizardR::wizard_show("my_modal")
  })
}

shinyApp(ui, server)
