#
# Explore CLT by using the Gamma distribution
#

library(shiny)

# Define UI for App to explore CLT by using the Gamma distribution
shinyUI(fluidPage(
  
  # Application title and a short intro
  titlePanel("Exploring the CLT using the example of a Gamma distribution"),
  p("The central limit theorem (CLT) states that the sum of independent random numbers is normally-distributed. 
    Here we assume that the random numbers are drawn from a Gamma distribution with a 'shape' and 'scale' parameter."),
  
  h3("Define all parameters:"),
  
  # Sidebar with a slider and numeric inputs to define the parameters 
  sidebarLayout(
    sidebarPanel(
       h4("Parametrization of Gamma:"),
       sliderInput('shape',"Shape parameter:",min = 0.5,max = 10,value = 2),
       sliderInput('scale',"Scale parameter:",min=1,max=10,value=2),
       h4("Define test parameter:"),
       numericInput('id1', '# of random numbers (N):', 100, min = 10, max = 1000, step = 1),
       numericInput('id2', '# of samples:', 300, min = 10, max = 1000, step = 1),
       actionButton("goButton", "Submit")
    ),
    
    # Show a plot of the generated distribution, the theoretical & calculated mean as well as the SEM
    mainPanel(
       plotOutput("distPlot"),
       h5("The theoretical mean is"),
       verbatimTextOutput("Mu_Theo"),
       h5("The calculated mean from the random data is"),
       verbatimTextOutput("Mu_Data"),
       h5("The SEM is given by"),
       verbatimTextOutput("SEM_Data")
    )
  )
))
