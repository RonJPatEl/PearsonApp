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
                   "Pearson correlatie in de populatie",
                   min = -.99,
                   max = .99,
                   value = .60),
      sliderInput("N",
                  "Steekproefgrootte:",
                  min = 10,
                  max = 1000,
                  value = 500),
      # Knop om steeds een extra steekproef mee te trekken
      actionButton("counter", label = "Trek een Steekproef"),
      
      # Resetknop om counter mee op nul te zetten
      actionButton("reset", label = "Reset"),
      
      # Knop om de volledige steekproevenverdeling te tonen
      actionButton("sampling", label= "Trek steekproevenverdeling")
      
       ),
   
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot"),
       plotOutput("Scatter"),
       uiOutput("count") #tijdelijk: counterteller van steekproefknop
    )
  )
))
