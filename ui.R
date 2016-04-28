#
# Sampling van pearson R correlaties
# voor IDA
#
# Code door R. J. Pat-El; 2016
# 


library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Steekproevenverdeling van de pearson correlatie"),
  
  # Sidebar with a slider input for correlation 
  sidebarLayout(
    sidebarPanel(
       sliderInput("pears",
                   "correlatie:",
                   min = -.99,
                   max = .99,
                   value = .60),
      sliderInput("N",
                  "Steekproefgrootte:",
                  min = 10,
                  max = 1000,
                  value = 500)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot"),
       plotOutput("Scatter")
    )
  )
))
