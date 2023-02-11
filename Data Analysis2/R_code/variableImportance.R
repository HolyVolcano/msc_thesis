


###############  VARIABLE IMPORTANCE ###########################

#Read Data
rm(list=ls())
#Libraries----
Sys.setenv(LANG="EN") #to get errors in english
options(warn=-1) # options(warn=0) #warnings on


############## RANDOM FOREST ##################################

library(readxl)
library(dplyr)
library(ggplot2)
library(randomForest)
library(varImp)

features <- read.csv(file = "C:/Users/MJAR0016/Desktop/data_SHAP.csv")

cols.input <- c("Total_video_red_head","Total_video_red_body")

features[,cols.input] <- features[,cols.input] * 100

head(features)

features <- na.omit(features)

y = as.matrix(features[17])  #### OUTPUT
x = as.matrix(features[,3:16])


model <- randomForest(y, data = x, importance=TRUE) 


#Conditional=True, adjusts for correlations between predictors.
i_scores <- varImp(model, conditional=TRUE)

#Gathering rownames in 'var'  and converting it to the factor
#to provide 'fill' parameter for the bar chart. 
i_scores <- i_scores %>% tibble::rownames_to_column("var") 
i_scores$var<- i_scores$var %>% as.factor()

#Plotting the bar and polar charts for comparing variables
i_bar <- ggplot(data = i_scores) + 
  geom_bar(
    stat = "identity", #it leaves the data without count and bin
    mapping = aes(x = var, y=x, fill = var), 
    show.legend = FALSE,
    width = 1
  ) + 
  labs(x = NULL, y = NULL)

i_bar + coord_polar() + theme_minimal()
i_bar + coord_flip() + theme_minimal()