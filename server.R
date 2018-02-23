#
# Explore CLT by using the Gamma distribution
#

library(shiny)

# Define server logic required to do computation and draw histogram etc.
shinyServer(function(input, output) {
        
        v <- reactiveValues(data = NULL)
        observeEvent(input$goButton, {v$data <- input$goButton})
   
        # main part
        output$distPlot <- renderPlot({
                
                if (is.null(v$data)) return()
                
                isolate({
                        
                # generate random numbers
                Mean_rnum <- numeric(input$id2)
                for (i in 1:input$id2){
                        
                        rmun <- rgamma(input$id1, input$shape, scale = input$scale)
                        Mean_rnum[i] <- mean(rmun)}
                
                
                # draw the histogram
                hist(Mean_rnum, breaks = min(round(input$id2/2),20), col = 'darkgray', border = 'white',
                     xlab = 'sum of N random numbers',main = 'Probability density of sum of N Gamma-distributed random numbers',
                     freq = FALSE)
                
                
                # compute mean and SEM theoretically and from the sample
                Mu_Theo <- input$shape*input$scale
                Mu_Data <- mean(Mean_rnum)
                SEM_Data <- sd(Mean_rnum)/sqrt(input$id2)
                output$Mu_Theo <- renderPrint({Mu_Theo})
                output$Mu_Data <- renderPrint({Mu_Data})
                output$SEM_Data <- renderPrint({SEM_Data})
                
                # add theoretical mean and normal distribution with mean and SD given by data
                lines(c(Mu_Theo, Mu_Theo), c(0, 10.0),col="red",lwd=3)
                x <- seq(min(Mean_rnum)*0.95,max(Mean_rnum)*1.95,length=500)
                y <- dnorm(x,mean=Mu_Data,sd=sd(Mean_rnum))
                lines(x,y,col="blue",lwd=3)
            
                })
        })
  
})
