library(shiny)
library(reshape2)
library(ggplot2)
library(tidyr)
library(dplyr)

dfcell <- read.csv('data/CellPhonePer100.csv', header = TRUE, row.names = 1)
createTidy <- function(df, varname = "DataName"){
  numcols <- ncol(df)
  colnames(df) <- substr(colnames(df[1:numcols]),2,5)
  df['country'] <- row.names(df) 
  tidydf <- gather_(df, "year", value_col=varname, colnames(df)[1:numcols])
  #tidydf <- gather_(df, "year", value_col = varname, 1:numcols)
  #tidydf$year <- as.numeric(as.character(tidydf$year))
  tidydf$year <- as.character(tidydf$year)
  #http://www.cookbook-r.com/Manipulating_data/Converting_between_vector_types/
  return(tidydf)
}
tidycell <- createTidy(dfcell,"CellPhonePer100")

# Define server logic required to draw a ggplot chart
shinyServer(function(input, output) {
  errorText <- reactive( {
    ifelse(length(input$countries) > 10, 
           "Maximum of 10 Countries already selected.  You must deselect one before you can add more.",
           "")
    })

    formulaText <- reactive({
    paste(sort(input$countries), sep=", ", collapse = ", ")
  })
  output$caption <- renderText( {
    formulaText()
  })
  
  #http://web.stanford.edu/~cengel/cgi-bin/anthrospace/building-my-first-shiny-application-with-ggplot help
  output$chart <-  renderPlot( {
    p <- ggplot(data = subset(tidycell, country %in% input$countries & year >= 1980), aes(x = year, y = CellPhonePer100, group = country, colour=country), na.rm=TRUE) +
      geom_line(na.rm=TRUE) + geom_point(na.rm=TRUE) +
      scale_x_discrete( 
        breaks = seq(1980, 2011, by = 5)) +
      ggtitle("Cell Phones Per 100 People") +
      theme(axis.text.x = element_text(angle=45)) + labs(color = "Country")
    print(p)
    
  })
})