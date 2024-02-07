library(shiny)
library(wizardR)

ui <- fluidPage(
  "wizard",
  theme = bslib::bs_theme(version = 5L),
    wizard(
      wizard_step(
        h5("hello")
      ),
      wizard_step(
        h5("world")
      )
    )
)

server <- \(input, output, session) {
}

shinyApp(ui, server)
