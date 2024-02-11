
test_that("wizard returns the correct output", {
  wizard_output <- wizardR::wizard(orientation = "horizontal", style = "dots", show_buttons = TRUE)

  testthat::expect_equal(htmltools::tagGetAttribute(wizard_output, "class"), "wizard")

  testthat::expect_equal(htmltools::tagGetAttribute(wizard_output, "data-orientation"), "horizontal")

  testthat::expect_equal(htmltools::tagGetAttribute(wizard_output, "data-style"), "dots")

  testthat::expect_equal(htmltools::tagGetAttribute(wizard_output, "data-show-buttons"), "true")

  testthat::expect_equal(htmltools::tagGetAttribute(wizard_output, "id"), NULL)
  
})

test_that("wizard_step returns the correct output", {
  wizard_step_output <- wizardR::wizard_step(step_title = "Hello tag", shiny::h5("hello, this is step 0."))

  testthat::expect_equal(htmltools::tagGetAttribute(wizard_step_output, "class"), "wizard-step")

  testthat::expect_equal(htmltools::tagGetAttribute(wizard_step_output, "data-title"), "Hello tag")
  
})
