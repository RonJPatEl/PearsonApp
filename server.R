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
  
  # maak een tabel vol pearson correlaties
  M <- reactive({ SamplePearson(reps = 1000, N=input$N, rho = input$pears) })
  
  # plot steekproevenverdeling pearson correlaties
  output$distPlot <- renderPlot({

    # teken histogram met steekproevenverdeling van rho
    #hist(M()[1:values$i], col = 'darkgray', breaks=20, border = 'white', xlim=c(-1,1), prob=F)
    stripchart(round(M()[1:values$i], digits=2), 
               col='darkgray',
               method="stack", 
               pch=16, 
               offset=0.3, 
               cex=1, 
               xlim=c(-1,1), 
               ylim=c(0,100))
    #lines(density(M), col='blue', lwd=2)
    
    #hist(M, col = 'darkgray', border = 'white', breaks=20, xlim=c(-1,1), prob=T)
    stripchart(round(M, digits=2), method="stack", pch=1, offset=0.8, cex=1, xlim=c(-1,1), ylim=c(0,100))
    #lines(density(M), col='blue', lwd=2)
  })
  
  # plot scatterplot
  output$Scatter <- renderPlot({
    
    # teken scatterplot met gemiddelde pearson uit alle pearsons
    plot(MeanPearsonData(rho=M()[values$i], N=input$N))
  })
  
  # tijdelijke print van de valuecounter van de steekproefgenerator
  # maak counter
      values <- reactiveValues(i = 1) # holder van counter value
      #observer runt iedere keer als knop gedrukt wordt, en telt 1 op bij counter:
         observeEvent(input$counter, {
           if (values$i < 1000) {isolate(values$i <- values$i + 1)}
         })
      #observer runt iedere keer als resetknopt gedrukt wordt en zetter teller op nul:
         observeEvent(input$reset, {
           isolate(values$i <- 1)
         })
      #observer runt iedere keer als sampling-knop gedrukt wordt en zetter teller op 1000
         observeEvent(input$sampling, {
           isolate(values$i <- 1000)
         })
  
      #placeholder om de steekproefcounter te testen
      output$count <- renderUI({paste0("counter = ", values$i)})
})
