library(shiny)
library(magrittr)

ui <- pageWithSidebar(
  headerPanel = headerPanel("Olá Shiny!"),
  
  sidebarPanel(
    sliderInput("num", "Tamanho da amostra:", min = 0, max = 150, value = 50)
  ),
  
  mainPanel(
    plotOutput("grafico_do_iris")
  )
)

server <- function(input, output, session) {
  
  output$grafico_do_iris <- renderPlot({
    ggplot(iris %>% sample_n(input$num)) + 
      geom_point(aes(x = Petal.Width, y = Sepal.Length))
  })
}

shinyApp(ui, server)