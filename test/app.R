#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyLocalStorage)

options(shiny.port = 4123)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(

   # Application title
   titlePanel("Old Faithful Geyser Data"),

   # Sidebar with a slider input for number of bins
   sidebarLayout(
      sidebarPanel(
        useLocalStorage(),
        actionButton("test1", "Set Value"),
        actionButton("test2", "Set Another Value"),
         storeInput(sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30))
      ),
      # Show a plot of the generated distribution
      mainPanel(
        textOutput("testOutput"),
         plotOutput("distPlot")
      )
   )
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output, session) {

  observeEvent(input$test1, {
    setLocalStorage(session, x = 4, y = 5)
  })

  observeEvent(input$test2, {
    setLocalStorage(session, x = 2, y = 4)
  })

  output$testOutput <- renderText({
    print(input$localStorage$inputs)
    as.numeric(input$localStorage$x) + as.numeric(input$localStorage$y) + as.numeric(input$localStorage$inputs$bins)
  })

   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2]
      bins <- seq(min(x), max(x), length.out = input$bins + 1)

      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })

})

# Run the application
shinyApp(ui = ui, server = server)

