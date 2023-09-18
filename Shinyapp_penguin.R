
library(shiny)
library(tidyverse)
library(palmerpenguins)

ui <- fluidPage(
  titlePanel("Interesting Facts about Different Species of Penguins"),
  sidebarPanel(
    selectInput("Cspecies", 
                label = "Choose one species of Penguins to learn about:",
                choices = c("Adelie", 
                            "Chinstrap",
                            "Gentoo"),
                selected = "Adelie"),
    helpText("See the relationship between the body mass and bill length 
              among the species of penguins you chose")
  ),
  mainPanel(
    plotOutput("plot1")
  )
)


server <- function(input, output) {
  output$plot1 <- renderPlot(
    penguins%>%
      filter(!is.na(sex) & species == input$Cspecies)%>%
      ggplot()+
      geom_point(mapping = aes(x=body_mass_g, y=bill_length_mm, color = sex))+
      geom_smooth(mapping = aes(x=body_mass_g, y=bill_length_mm))+
      labs(title = "Relationship between Body Mass and Bill Length of Penguins",
           x = "Body Mass (g)", y = "Bill Length (mm)")
  )
}


shinyApp(ui = ui, server = server)