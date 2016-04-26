#
# Shiny app voor steekproevenverdeling pearson correlatie
# 
#
# In de app wordt een pearson correlatie uit een N aantal random datasets getrokken
# 
# auteur: dr. Ron J. Pat-El (2016)
#


library(shiny)

# laad de functies in
source("Functions.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
    # maak een tabel vol pearson correlaties
    M <- SamplePearson(reps = input$N, rho = input$pears)
    # teken histogram met steekproevenverdeling van rho
    hist(M, col = 'darkgray', border = 'white', breaks=20, xlim=c(-1,1), prob=T)
    lines(density(M), col='blue', lwd=2)
  })
  
  output$Scatter <- renderPlot({
    
    # teken scatterplot met gemiddelde pearson uit alle pearsons
    plot(MeanPearsonData(rho=input$pears, N=500))
  })
  
})
