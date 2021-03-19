library(shiny)

ui <- fluidPage(
  "Hello World!",
  
  sliderInput(
    inputId = "num",
    label = "Número de observações: ",
    min = 1,
    max = 100,
    value = 20,
  ),
  
  textInput("titulo", "Título do Histograma: "),
  actionButton("atualizar", "atualizar!"),
  
  plotOutput("hist"),
  verbatimTextOutput("sumario"),
  actionButton("salvar_dados", "salvar dados as CSV")
)

server <- function(input, output, session) {
  
  dados <- eventReactive(input$atualizar, {
    rnorm(input$num)
  })
  
  output$hist <- renderPlot({
    titulo <- isolate(input$titulo)
    hist(dados(), main = titulo)
  })
  
  output$sumario <- renderPrint({
    summary(dados())
  })
  
  observeEvent(input$salvar_dados, {
    write.csv(dados(), "dados.csv")
    cat("Salvo!\n")
  })
  
  observe({
    print(dados())
    print(as.numeric(input$salvar_dados))
  })
}

shinyApp(ui, server)