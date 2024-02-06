library(shiny)
library(wizardR)

ui <- fluidPage(
  "wizard",
  theme = bslib::bs_theme(version = 5L),
  wizard()
)

server <- \(input, output, session) {
}

shinyApp(ui, server)
