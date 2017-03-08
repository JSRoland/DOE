#Server.R



		
		
shinyServer(function(input, output){
# generate random levels?

	

# Reset Data
    exp_data = read.table(text="",
                         col.names=c("Treatment","IDX","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","YLD"),
                          colClasses = c("double","double","double","double","double","double",
                                        "double","double","double","double",
                                        "double","double","double","double",
                                        "double","double","double","double",
                                        "double","double","double") 
                         )
  # Create levels:
  # The important part of reactiveValues()
    
    values <- exp_data
	x <- sample(1:5,replace = FALSE)
	for(j in c(1:5)){
        for(i in c(1:100)){
			
	    # Random values:
	if (j==x){
		A <- runif(1, 3.0, 3.5)				# Alternative A
		}
	else{
		A <- runif(1, 0, 3.5)				# A
		}
		B <- runif(1, 0, 3)	    			# B
		C <- runif(1, 0, 2.0)				# C
		D <- runif(1, 0, 5.0)				# D
		E <- runif(1, 0, 2.5)				# E
	if (j==x){
		F <- runif(1, 1.5, 2.0)				# Alternative F
		}
	else{
		F <- runif(1, 0, 2.0)				# F
		}
		G <- runif(1, 0, 2.5)				# G
		H <- runif(1, 0, 2.0)				# H
		I <- runif(1, 0.4, 2.0)				# I
		J <- runif(1, 0, 3.0)				# J
		K <- runif(1, 0, 1.2)				# K
		L <- runif(1, 0, 2.0)				# L
		M <- runif(1, 0, 2.0)				# M
		N <- runif(1, 0, 1.5)				# N
		O <- runif(1, 0.4, 3.5)				# O
		P <- runif(1, 0, 2.0)				# P
		Q <- runif(1, 0, 10.0)				# Q
	if (j==x){
		R <- runif(1, 6.0, 18.0)			# Alternative R
		}
	else{	
		R <- runif(1, 0, 18.0)				# R
		}
		
		
          # Create Yield
          YLD <- sqrt(abs(15*(2-(A-1)^2-(F-1)^2))) + 15*(B)^2*exp(0.64-(B)^2-10*(B-G)^2) + 50*C*exp(0.04-(C)^2-10*(6*C-H)^2) + 0.5*D*E + 5*abs(I-K) + (J)^2 + (M)^2 - (J*M) + 10*exp(-100*((0.72*L-1.3)^2+(N-1.3)^2)) + rnorm(1,0,1)
          
          # create the new line to be added from your inputs
          newLine <- c(j,i,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,YLD)

          # update your data
          # note the unlist of newLine, this prevents a bothersome warning message that the rbind will return regarding rownames because of using isolate.
          values <- rbind(as.matrix(values), unlist(newLine))
		  
      }}
	  
		
		values <- data.frame(values)
		values$Treatment<-factor(values$Treatment)
		
output$av <- renderTable({	
        # Generate a new ANOVA table every time a widget is changed
values <- data.frame(values[c(1:input$slider1,101:(100+input$slider1),201:(200+input$slider1),301:(300+input$slider1),401:(400+input$slider1),501:(500+input$slider1)),])
tmp = values$Treatment == 1:input$slider2

isolate(av <- anova(aov(YLD[tmp]~Treatment[tmp], data=values)))
	},include.rownames=TRUE)
output$HSD <- renderPlot({
		# Generate a new Tukey plot
values <- data.frame(values[c(1:input$slider1,101:(100+input$slider1),201:(200+input$slider1),301:(300+input$slider1),401:(400+input$slider1),501:(500+input$slider1)),])
tmp <- data.frame(values$Treatment == 1:input$slider2)
tmp$Treatment<-factor(tmp$Treatment)

		isolate(av <- aov(YLD~Treatment, data=tmp))
	isolate(HSD <- plot(TukeyHSD(av,ordered=TRUE, conf.level=0.95)))	
		
		})
    })

