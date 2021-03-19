library(shiny)

ui <- ui <- fluidPage(
  
  titlePanel("Tabsets"),
  
  sidebarLayout(
    
    sidebarPanel(
      sliderInput("num", "Tamanho da amostra: ", 0, 1000, 500)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Gráfico", plotOutput("grafico")), 
        tabPanel("Sumário", verbatimTextOutput("sumario")), 
        tabPanel("Tabela", tableOutput("tabela"))
      )
    )
  )
)

server <- function(input, output, session) {
  
  dados <- reactive({
    rnorm(input$num)
  })
  
  output$grafico <- renderPlot({
    hist(dados())
  })
  
  output$sumario <- renderPrint({
    summary(dados())
  })
  
  output$table <- renderTable({
    dados()
  })
}

shinyApp(ui, server)