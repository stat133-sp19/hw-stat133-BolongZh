#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(reshape)

# Define UI for application
ui <- fluidPage(
  
  # Application title
  titlePanel("Investment Modalities"),
  
  # Sidebar  
  fluidRow(
    column(4,
      sliderInput("initial",
                  label = "Initial Amount",
                  min = 0,
                  max = 100000,
                  step = 500,
                  value = 1000,
                  pre = "$"),
      sliderInput("a_contrib",
                  label = "Annual Contribution",
                  min = 0,
                  max = 50000,
                  step = 500,
                  value = 2000,
                  pre = "$")),
    column(4,
      sliderInput("rate",
                   label = "Return rate(in %)",
                   min = 0,
                   max = 20,
                   step = 0.1,
                   value = 5
                   ),
      sliderInput("growth",
                  label = "Growth rate(in %)",
                  min = 0,
                  max = 20,
                  step = 0.1,
                  value = 2)),
    column(4,
      sliderInput("year",
                  label = "Years",
                  min = 0,
                  max = 50,
                  step = 1,
                  value = 20),
      selectInput("facet",
                  label = "Facet?",
                  choices = c("No","Yes")
                  ))
      
      
    ),
    
    # outputs in the main panel
    mainPanel(
      h4(textOutput("plot_sec_title")),
      plotOutput("timeline_plot", width = "150%"),
      h4(textOutput("balances_sec_title")),
      tableOutput("balances")
    )
  )

  
  

# Define server logic required to draw the plot and the table
server <- function(input, output) {
      
  future_value <- function(amount, rate, years){
    result <- amount*(1+rate)^years
    return(result)
  }
  annuity <- function(contrib, rate, years){
    result <- contrib*(((1+rate)^years - 1)/rate)
    return(result)
  }
  growing_annuity <- function(contrib, rate, growth, years){
    result <- contrib*(((1+rate)^years - (1+growth)^years)/(rate-growth))
    return(result)
  }
  
  
  output$timeline_plot <- renderPlot({
     year <- 0:input$year
     no_contrib <- rep(0,input$year+1)
     fixed_contrib <- rep(0,input$year+1)
     growing_contrib <- rep(0,input$year+1)
     #calculating no contribution model
     for (i in 0:input$year){
       no_contrib[i+1] <- future_value(amount = input$initial, rate = input$rate/100, years = i)
     }
     #calculating fixed contribution model
     for (i in 0:input$year){
       fixed_contrib[i+1] <- future_value(amount = input$initial, rate = input$rate/100, years = i) + 
         annuity(contrib = input$a_contrib, rate = input$rate/100, years = i)
     }
     #calculating growing contribution model
     for (i in 0:input$year){
       growing_contrib[i+1] <- future_value(amount = input$initial, rate = input$rate/100, years = i) + 
         growing_annuity(contrib =  input$a_contrib, rate = input$rate/100, growth = input$growth/100, years = i)
     }
   
      untidy <- data.frame(year = year, no_contrib = no_contrib, fixed_contrib = fixed_contrib, growing_contrib = growing_contrib)
      modalities <- melt(untidy,"year")
      options(scipen=10000)
      original <- ggplot(data = modalities, aes(x=year,y=value,color=variable)) +
      geom_line(size = 2) +
      geom_point(shape = 16, size = 6)+
      ggtitle("Three Modes of Investing")
      if (input$facet == "No") {
        print(original)
      }
      else{
        facetted <- original + facet_wrap(~variable) + theme_bw() + 
          geom_area(aes(fill = variable, group = variable),alpha = 0.5, position = 'identity')
        print(facetted)
      }
        
  })
  output$plot_sec_title <- renderText("Timelines")
  output$balances_sec_title <- renderText("Balances")
  output$balances <- renderTable({  
    year <- 0:10
    no_contrib <- rep(0,11)
    fixed_contrib <- rep(0,11)
    growing_contrib <- rep(0,11)
    #calculating no contribution model
    for (i in 0:10){
      no_contrib[i+1] <- future_value(amount = input$initial, rate = input$rate/100, years = i)
    }
    #calculating fixed contribution model
    for (i in 0:10){
      fixed_contrib[i+1] <- future_value(amount = input$initial, rate = input$rate/100, years = i) + 
        annuity(contrib = input$a_contrib, rate = input$rate/100, years = i)
    }
    #calculating growing contribution model
    for (i in 0:10){
      growing_contrib[i+1] <- future_value(amount = input$initial, rate = input$rate/100, years = i) + 
        growing_annuity(contrib =  input$a_contrib, rate = input$rate/100, growth = input$growth/100, years = i)
    }
    modalities <- data.frame(year = year, no_contrib = no_contrib, fixed_contrib = fixed_contrib, growing_contrib = growing_contrib)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)