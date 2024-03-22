library(shiny)
library(wizardR)
library(bslib)
library(shiny)
library(htmltools)
library(plotly)

plotly_widget <- plotly::plot_ly(x = diamonds$cut) %>%
  config(displayModeBar = FALSE) %>%
  layout(margin = list(t = 0, b = 0, l = 0, r = 0))


ui <- fluidPage(
  "wizardR demo",
    theme = bslib::bs_theme(version = 5L),
    # add button
    actionButton("show_wizard", "Show wizard"),
    actionButton("show_shinyalert", "Show shinyalert"),
    wizard(
      modal = TRUE,
      lock_start = TRUE,
      id = "my_modal",
      # start sequence of steps
      wizard_step(
        step_title = "Hello tag",
        # add lock button
        shiny::actionButton("lock_wizard", "Lock"),
        shiny::actionButton("unlock_wizard", "unLock")
      ),
      wizard_step(
        step_title = "Numeric input",
        shiny::actionButton("reset_wizard", "Reset"),
        shiny::numericInput("number", "Select a number", value = 30, min = 20, max = 100)
      ),
      wizard_step(
        bslib::layout_columns(
          bslib::card(
          full_screen = TRUE,
          card_header("A filling plot"),
          card_body(plotly_widget)
        ),card(
          full_screen = TRUE,
          card_header("A filling plot"),
          card_body(plotly_widget)
        ),card(
          full_screen = TRUE,
          card_header("A filling plot"),
          card_body(plotly_widget)
        ),card(
          full_screen = TRUE,
          card_header("A filling plot"),
          card_body(plotly_widget)
        )
        ),
        bslib::layout_columns(
          bslib::card(
          full_screen = TRUE,
          card_header("A filling plot"),
          card_body(plotly_widget)
        ),card(
          full_screen = TRUE,
          card_header("A filling plot"),
          card_body(plotly_widget)
        ),card(
          full_screen = TRUE,
          card_header("A filling plot"),
          card_body(plotly_widget)
        ),card(
          full_screen = TRUE,
          card_header("A filling plot"),
          card_body(plotly_widget)
        )
        )
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

  observeEvent(input$lock_wizard, {
    wizardR::lock("my_modal")
  })

  observeEvent(input$unlock_wizard, {
    wizardR::unlock("my_modal")
  })

  # trigger on wizard finish
  observeEvent(input$my_modal, {
    print(input$my_modal)
  })

  observeEvent(input$reset_wizard, {
    print("reset wizard")
    wizardR::reset("my_modal")
  })

  observeEvent(input$show_shinyalert, {
    shinyalert::shinyalert(
      title = "Hello",
      text = "This is a shinyalert",
      type = "success"
    )
  })
}

shinyApp(ui, server)
