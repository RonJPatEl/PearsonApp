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
  fluidRow(
    column(4,
           wellPanel(
             helpText("Deze slider bepaalt welke pearson correlatie er tussen twee variabelen is in de gehele populatie"),
             sliderInput("pears",
                         "Pearson correlatie in de populatie",
                         min = -.99,
                         max = .99,
                         value = .60),
             
             helpText("Met deze slider wordt de steekproefgrootte van iedere steekproef aangepast"),
             sliderInput("N",
                         "Steekproefgrootte:",
                         min = 10,
                         max = 500,
                         value = 100),
             
             # Knop om steeds een extra steekproef mee te trekken
             actionButton("counter", label = "Trek een Steekproef", icon=icon("fa fa-step-forward")),
             
             # Knop om de volledige steekproevenverdeling te tonen
             actionButton("sampling", label= "Trek steekproevenverdeling", icon=icon("fa fa-fast-forward")),
             
             # Resetknop om counter mee op nul te zetten
             actionButton("reset", label = "Reset", icon=icon("fa fa-refresh")),
             
             helpText("U kunt een maximum van 1000 steekproeven trekken. Als u de knop [Trek steekproevenverdeling]
                      heeft ingedrukt zult u eerst moeten resetten voordat u weer individuele steekproeven kunt trekken ")
             
             )),
    
    # Show a plot of the generated distribution
    column(4,
           plotOutput("distPlot", height="800px")),
    column(4,
           plotOutput("Scatter", height="800px")
           #uiOutput("count") #tijdelijk: counterteller van steekproefknop
    )
  )
    ))
