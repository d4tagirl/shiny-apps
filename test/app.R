
library(shiny)

server <- shinyServer(function(input, output, session) {
  
  output$summary <- renderText({
    ls(env=session$request)
  })
  
  output$headers <- renderUI({
    selectInput("header", "Header:", ls(env=session$request))
  })
  
  output$value <- renderText({
    if (nchar(input$header) < 1 || !exists(input$header, envir=session$request)){
      return("NULL");
    }
    return (get(input$header, envir=session$request));
  })
})

ui <- shinyUI(pageWithSidebar(
  headerPanel("Shiny Client Data"),
  sidebarPanel(
    uiOutput("headers")
  ),
  mainPanel(
    h3("Headers passed into Shiny"),
    verbatimTextOutput("summary"),
    h3("Value of specified header"),
    verbatimTextOutput("value")
  )
))

# Run the application 
shinyApp(ui = ui, server = server)

