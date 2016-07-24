
library(shiny)
library(shinyLocalStorage)

inputs <- c("Text", "Select", "Selectize", "Slider", "DateRange", "DateInput",
            "Checkbox", "CheckboxGroup", "Radios")

ui <- shinyUI(fluidPage(
  titlePanel("shinyStorage Test"),
  tags$h4("Change the inputs then reload the page to see how the behavior is different."),
  fluidRow(
    column(width = 4,
      wellPanel(
        tags$h3("Stored Inputs"),
        storeInput(textInput("storedText", "Stored Text Input")),
        storeInput(selectInput("storedSelect", "Stored Select Input", choices = c("cat", "dog", "mouse"), selectize = FALSE)),
        storeInput(selectInput("storedSelectize", "Stored Selectize Input", choices = c("apple", "banana", "pear"), selectize = TRUE)),
        storeInput(sliderInput("storedSlider", "Stored Slider Input", 0, 5, 3)),
        storeInput(dateRangeInput("storedDateRange", "Stored Date Range Input")),
        storeInput(dateInput("storedDateInput", "Stored Date Input")),
        storeInput(checkboxInput("storedCheckbox", "Stored Checkbox Input")),
        storeInput(checkboxGroupInput("storedCheckboxGroup", "Stored Checkbox Group Input", choices = c("A", "B", "C"))),
        storeInput(radioButtons("storedRadios", "Stored Radio Buttons", choices = c("D", "E", "F")))
      )
    ),
    column(width = 4,
      wellPanel(
        tags$h3("Standard Inputs"),
        textInput("standardText", "Standard Text Input"),
        selectInput("standardSelect", "Standrad Select Input", choices = c("cat", "dog", "mouse"), selectize = FALSE),
        selectInput("standardSelectize", "Standard Selectize Input", choices = c("apple", "banana", "pear"), selectize = TRUE),
        sliderInput("standardSlider", "Standard Slider Input", 0, 5, 3),
        dateRangeInput("standardDateRange", "Standard Date Range Input"),
        dateInput("standardDateInput", "Standard Date Input"),
        checkboxInput("standardCheckbox", "Standard Checkbox Input"),
        checkboxGroupInput("standardCheckboxGroup", "Standard Checkbox Group Input", choices = c("A", "B", "C")),
        radioButtons("standardRadios", "Standard Radio Buttons", choices = c("D", "E", "F"))
      )
    ),
    column(width = 4,
      tags$h3("Output Values"),
      tags$table(class = "table",
        tags$tr(
          tags$th("Input Type"),
          tags$th("Stored Version"),
          tags$th("Standard Version")
        ),
        tagList(lapply(inputs, function(i) {
          tags$tr(
            tags$td(i),
            tags$td(textOutput(paste0("stored", i, "Value"))),
            tags$td(textOutput(paste0("standard", i, "Value")))
          )
        }))
      )
    )
  )
))

server <- shinyServer(function(input, output, session) {

  for(i in inputs) {
    output[[paste0("stored", i, "Value")]] <- eval(parse(text = paste0("renderText({input$stored", i, "})")))
    output[[paste0("standard", i, "Value")]] <- eval(parse(text = paste0("renderText({input$standard", i, "})")))
  }

})

# Run the application
shinyApp(ui = ui, server = server, options = list(port = 7384))

