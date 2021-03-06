# ui.R
library(shiny)
library(scales)


shinyUI(fluidPage(
  titlePanel("ANOVA - Post-HOC visualization"),

  sidebarLayout(position = "right",
    sidebarPanel( h2("Options:"),
	
	
sliderInput("slider1", label = h3("Number of replicates: "),
        min = 0, max = 100, value = 50),
		
sliderInput("slider2", label = h3("Number of treatments: "),
		min = 1, max = 5, value = 3)
		
),
	
    mainPanel(tableOutput("av"),
	plotOutput("HSD")
	)
	
  ))
)