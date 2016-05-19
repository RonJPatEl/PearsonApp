# Shiny app voor steekproevenverdeling pearson correlatie
# 
#
# In de app wordt een pearson correlatie uit een N aantal random datasets getrokken
# 
# auteur: dr. Ron J. Pat-El (2016)
#


library(shiny)
library(ggplot2)

# laad de functies in
source("Functions.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # maak een tabel vol pearson correlaties
  M <- reactive({ SamplePearson(reps = 1000, N=input$N, rho = input$pears) })
  
  # plot steekproevenverdeling pearson correlaties
  output$distPlot <- renderPlot({
    # maak een tabel vol pearson correlaties
    #M <- SamplePearson(reps = 1000, N=input$N, rho = input$pears)
    stripchart(round(M()[1:values$i], digits=2), 
           #col='darkblue',
           bg='black',
           method="stack", 
           pch=22, 
           offset=0.3, 
           cex=1, 
           xlim=c(-1,1), 
           ylim=c(1,10000),
           main=paste("verdeling van", values$i, "correlatie(s) bij rho =", input$pears))
  })
  
  # plot scatterplot
  output$Scatter <- renderPlot({
    
    # teken scatterplot met gemiddelde pearson uit alle pearsons
#    plot(MeanPearsonData(rho=M()[values$i], N=input$N),
#         main = paste("scatterplot van steekproef", values$i, " r =", round(M()[values$i], digits = 2), "N =", input$N ))
     ggplot(MeanPearsonData(rho=M()[values$i], N=input$N), aes(x=x,y=y)) + 
      geom_point() + 
      geom_smooth(method='lm') + 
      ggtitle(paste("scatterplot van steekproef", values$i, " r =", round(M()[values$i], digits = 2), "N =", input$N )) +
      theme_bw()
  })
  
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

