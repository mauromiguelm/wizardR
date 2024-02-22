test_that("wizard returns the correct output", {
  wizard_output <- wizardR::wizard(
    orientation = "horizontal",
    style = "dots",
    show_buttons = TRUE,
    modal = FALSE
  )

  testthat::expect_equal(htmltools::tagGetAttribute(wizard_output, "class"), "wizard")

  res <- htmltools::tagGetAttribute(wizard_output, "data-configuration")

  res <- jsonlite::parse_json(res)

  testthat::expect_equal(res, list("wz_ori" = "horizontal", "wz_nav_style" = "dots", "buttons" = "true"))


  # this id is necessary for modal to work
  testthat::expect_true(is.character(htmltools::tagGetAttribute(wizard_output, "id")))
})

test_that("wizard_step returns the correct output", {
  wizard_step_output <- wizardR::wizard_step(
    step_title = "Hello tag",
    shiny::h5("hello, this is step 0.",
      modal = FALSE
    )
  )

  testthat::expect_equal(htmltools::tagGetAttribute(wizard_step_output, "class"), "wizard-step")

  testthat::expect_equal(htmltools::tagGetAttribute(wizard_step_output, "data-title"), "Hello tag")
})

# check that flex is applied to the steps and the container
test_that("wizard_step returns the correct output with flex", {
  wizard_step_output <- wizardR::wizard_step(
    step_title = "Hello tag",
    shiny::h5("hello, this is step 0.",
      modal = FALSE
    )
  )

  wizard <- wizardR::wizard(
    orientation = "horizontal",
    style = "dots",
    show_buttons = TRUE,
    modal = FALSE,
    flex = FALSE,
    wizard_step_output
  )

  # get the class from children div
  wizard_container <- wizard$children[[1]]
  container_class <- htmltools::tagGetAttribute(wizard_container, "class")

  expect_equal(container_class, "wizard-content container html-fill-container")

  wizard_step <- wizard_container$children[[1]]
  step_class <- htmltools::tagGetAttribute(wizard_step[[1]], "class")

  expect_equal(step_class, "wizard-step html-fill-item html-fill-container")

})


# check that flex is NOT applied to the steps and the container when flex = FALSE
testthat("wizard_step returns the correct output with flex", {
  wizard_step_output <- wizardR::wizard_step(
    step_title = "Hello tag",
    shiny::h5("hello, this is step 0.",
      modal = FALSE
    )
  )

  wizard <- wizardR::wizard(
    orientation = "horizontal",
    style = "dots",
    show_buttons = TRUE,
    modal = FALSE,
    flex = FALSE,
    wizard_step_output
  )

  # get the class from children div
  wizard_container <- wizard$children[[1]]
  container_class <- htmltools::tagGetAttribute(wizard_container, "class")

  expect_equal(container_class, "wizard-content container")

  wizard_step <- wizard_container$children[[1]]
  step_class <- htmltools::tagGetAttribute(wizard_step[[1]], "class")

  expect_equal(step_class, "wizard-step")

})