library(shiny)
library(wizardR)
library(bslib)
library(shiny)

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
        step_title = "Try to lock wizard after shinyvalidate activated",
        shiny::textInput("login_email", "Enter some text and lock wizard in step 1")
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

  observeEvent(input$login_email, {
    # validate text input
    req(input$login_email)
    print("text input changed")
    print(input$login_email)
    iv <- shinyvalidate::InputValidator$new()
    iv$add_rule("login_email", shinyvalidate::sv_required())
    iv$add_rule("login_email", shinyvalidate::sv_email())
    iv$enable()
  })
}

shinyApp(ui, server)
