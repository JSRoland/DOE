# ui.R

shinyUI(fluidPage(
  titlePanel("title panel"),

  sidebarLayout(position = "right",
    sidebarPanel( "sidebar panel",
sliderInput("slider1", label = h3("Slider"),
        min = 0, max = 100, value = 50)),
    mainPanel("main panel")
  )
))