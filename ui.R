library(shiny)
library(reshape2)
library(tidyr)
library(dplyr)

dfcell <- read.csv('data/CellPhonePer100.csv', header = TRUE, row.names = 1)
createTidy <- function(df, varname = "DataName"){
  numcols <- ncol(df)
  colnames(df) <- substr(colnames(df[1:numcols]),2,5)
  df['country'] <- row.names(df) 
  tidydf <- gather_(df, "year", value_col=varname, colnames(df)[1:numcols])
  #  tidydf <- gather_(df, "year", value_col = varname, 1:numcols)
  #tidydf$year <- as.numeric(as.character(tidydf$year))
  tidydf$year <- as.character(tidydf$year)
  #http://www.cookbook-r.com/Manipulating_data/Converting_between_vector_types/
  return(tidydf)
}
tidycell <- createTidy(dfcell,"CellPhonePer100")
#ppp1 <- ggplot(data = tidycell, aes(x = year, y = CellPhonePer100)) + geom_boxplot() + labs(title="Cell Phone Per 100 By Year over all Countries") +
  
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Growth of Cell Phones"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      helpText("Compare cell phones per 100 of population for up to 10 countries.  
               Choose which country(ies) to compare. 
               Delete countries you no longer wish to compare."),
      selectizeInput("countries", "Select Countries:",
                  unique(tidycell$country), multiple=TRUE, 
                  selected = "United States",
                  options = list(maxItems = 10))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", h2("Plot of Cell Phones per 100 Population for", align="center"),
                 h3(textOutput("caption"), align="center"),
                 plotOutput("chart"),
                 textOutput(paste("Plot of Cell Phones per 100 Population for", "caption")),
                 h3(textOutput("errorText"), color="red")
        ),
        tabPanel("Documentation",includeMarkdown("documentation.md"))
        )
      )
    )
  )
)