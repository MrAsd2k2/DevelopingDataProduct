
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


library(shiny)

shinyServer(function(input, output) {

 
  output$instructions <- renderUI({ 
    HTML("The following application will help you browse the data about foreign residents in the Lombardy region of Italy according to the data from the <a href=\"https://www.dati.lombardia.it/Statistica/Stranieri-per-sesso-e-et-/ruva-yhry\">Lombardia OpenData project</a>.<br/>
         <p/>Begin by selecting which features you would like to include and exclude from the analysis by checking and unchecking the approriate checkboxes in the widget below.<br/> 
         The parameters you could work on are: the <i>area districts</i> &#40;the Lombardy region is divided in 12 provinces, more information on wikipedia: <a href=\"https://en.wikipedia.org/wiki/Lombardy\">en.wikipedia.org/wiki/Lombardy</a>&#41;,
         the <i>age range</i> of the foreign residents and their <i>sex</i>. Instead, the slider will help you selecting the <i>range of years</i> to be analyzed&#40;at the present time the dataset includes information from year 2011 to year 2016&#41;<br/>
         As soon as you are satisfied, switch to one of the other two tabs: <b>Plot</b> will display a graphical representation of the number of foreign residents, the <b>Table</b> tab will shows the same information in a tabular format.<br/>
          <p>The widgets will remain anchored at the bottom of the page so you might change some of the parameters without getting back to this page: the related plot and data table will be updated on the fly according to your choices.<br/>
        In case you would like to read the documentation again, click on the <b>istruction</b> tab to get back to this page.<br/>
      <p><u>The source code of the shiny application is available at: <a href=\"https://github.com/MrAsd2k2/DevelopingDataProduct\">https://github.com/MrAsd2k2/DevelopingDataProduct</a></u>
         ")         })
  
  
  output$distTable <- renderTable({
    
    sel <- a[which(a$Provincia %in% input$Province),]
    sel <- sel[which(sel$Classe.d.eta. %in% input$Age),]
    sel <- sel[which(sel$Anno >= input$year[1]),]
    sel <- sel[which(sel$Anno <= input$year[2]),]
    
    if (input$Sex[1] == "Male")
    { if (!is.na(input$Sex[2]))
    {
      h <- aggregate(sel$Maschi.in.totale+sel$Femmine.in.totale, by=list(sel$Anno, sel$Provincia), FUN="sum") 
    }
      else
      { h <- aggregate(sel$Maschi.in.totale, by=list(sel$Anno, sel$Provincia), FUN="sum")
      }
    }
    else
      h <- aggregate(sel$Femmine.in.totale, by=list(sel$Anno, sel$Provincia), FUN="sum")
    
    colnames(h) <- c("Area district", "Year", "Number of foreign residents")
    h
    
  }  
  )
  
  
  
  output$distPlot <- renderPlot({

    sel <- a[which(a$Provincia %in% input$Province),]
    sel <- sel[which(sel$Classe.d.eta. %in% input$Age),]
    sel <- sel[which(sel$Anno >= input$year[1]),]
    sel <- sel[which(sel$Anno <= input$year[2]),]
    
    if (input$Sex[1] == "Male")
    { if (!is.na(input$Sex[2]))
    {
      h <- aggregate(sel$Maschi.in.totale+sel$Femmine.in.totale, by=list(sel$Anno, sel$Provincia), FUN="sum") 
    }
      else
      { h <- aggregate(sel$Maschi.in.totale, by=list(sel$Anno, sel$Provincia), FUN="sum")
      }
    }
    else
      h <- aggregate(sel$Femmine.in.totale, by=list(sel$Anno, sel$Provincia), FUN="sum")
    
    provr <- unique(h$Group.2)
    xr <- range(h$Group.1)
    xr[2] <-  xr[2]+2 # needed some space for the legend...
    yr <- range(h$x)
    numProv <- length(provr)
    colr <- rainbow(numProv)
  
    
    plot(xr, yr, type="n", xlab = "Year", ylab="Number of individuals")
    
    for (i in 1:numProv)
    { k <- subset(h, Group.2 == provr[i])
      lines(k$Group.1, k$x, col=colr[i])
    }
  
    legend("right", yrange[2], provr, col <- colr)
  

  })

})
