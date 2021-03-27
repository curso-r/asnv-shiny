library(shiny)
library(shinydashboard)
library(tidyverse)


ui <- dashboardPage(
  dashboardHeader(
    title = "Iris Predictor"
  ),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Calculator", tabName = "calc", icon = icon("calculator")),
      menuItem("Descriptive", tabName = "desc", icon = icon("grid"))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "calc",
        h1("Predição do Sepal.Length"),
        fluidRow(
          valueBox(3.91, subtitle = "Linear Regression", color = "aqua"),
          valueBox(2.73, subtitle = "Random Forest", color = "orange"),
          valueBox(2.9, subtitle = "XGBoost", color = "purple")
        ),
        fluidRow(
          box(width = 4,
            title = "Features",
            sliderInput("sepal_length", "Sepal Length:", min = 0, max = 6, value = 4),
            sliderInput("petal_length", "Petal Length:", min = 0, max = 6, value = 4),
            sliderInput("petal_width", "Petal Width:", min = 0, max = 6, value = 4),
            selectInput("species", "Species", choices = unique(iris$Species))
          ),
          box(width = 8,
            title = "Sense of Extrapolation (PCA)",
            plotOutput("grafico")
          )
        )
      ),
      tabItem(tabName = "desc", "B")
    )
  )
)

server <- function(input, output, session) {
  
  
  output$grafico <- renderPlot({
    validate(
      need(!is.null(input$species), "Species não informada")
    )
    
    iris %>%
      dplyr::filter(Species == input$species) %>%
      ggplot(aes(Sepal.Length, Sepal.Width, colour = Species)) +
      geom_point()
  })
}

shinyApp(ui, server)