
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

 
 titlePanel("Foreign residents in Lombardy region (Italy) for area district and year"), 
  fluidRow( 
      tabsetPanel(
            tabPanel("Instructions", htmlOutput("instructions")),
            tabPanel("Plot", plotOutput("distPlot")),
            tabPanel("Table", tableOutput("distTable"))
                 )
    ),
  hr(),
  
  fluidRow(
    
      column(3,
      checkboxGroupInput("Province", "Area districts to be shown:",
                         unique(a$Provincia),
                         selected = unique(a$Provincia)
                        )
      )
      ,
      
      column(4, offset = 1,
      checkboxGroupInput("Sex", "Sex:",
                         c("Male", "Female"), selected = c("Male", "Female") 
                     ),
      sliderInput("year", "Years range:",
                  min = min(a$Anno), max = max(a$Anno), value = c(2011, 2016), step = 1, sep=""
                )
      ),
      
      column(4,
      checkboxGroupInput("Age", "Age range:",
                         unique(a$Classe.d.eta.),
                         selected = unique(a$Classe.d.eta.)
              )
      )
  
  ) 
))  