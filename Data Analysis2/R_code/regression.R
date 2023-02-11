
library(ggplot2)
################### RANDOM FOREST #################


# using all variables including RED percentage and try to predict if OCD or non OCD


features <- read.csv(file = "C:/Users/MJAR0016/Desktop/data_SHAPP.csv")

cols.input <- c("Total_video_red_head","Total_video_red_body","Th_lead_red_head", "Th_lead_red_body",
               "Pat_lead_red_head", "Pat_lead_red_body")

#cols.input <- c("Total_video_red_head","Total_video_red_body")

features[,cols.input] <- features[,cols.input] * 100

features <- features[,2:22]

mydata <- na.omit(features)

# Check types of variables
str(mydata)

mydata <- mydata[-6,]

dim(mydata)

mydata_1 <- mydata[,c(2:15,17)]
mydata_1 <- na.omit(mydata_1)
str(mydata_1)
dim(mydata_1)

# Make dependent variable as a factor (categorical)
#mydata$Total_video_red_body = as.factor(mydata$Type)

library(randomForest)
#set.seed(71)
rf <-randomForest(Total_video_red_body~.,data=mydata_1, ntree=2000) 
print(rf)

floor(sqrt(ncol(mydata_1) - 1))


mtry <- tuneRF(mydata_1[-1],mydata_1$Total_video_red_body, ntreeTry=2000,
               stepFactor=1.5,improve=0.01, trace=TRUE, plot=TRUE)
best.m <- mtry[mtry[, 2] == min(mtry[, 2]), 1]
print(mtry)
print(best.m)


mydata_1[,c(16)]


#set.seed(71)
rf <-randomForest(Total_video_red_body~.,data=mydata_1, mtry=best.m, importance=TRUE,ntree=2000)
print(rf)
#Evaluate variable importance
importance(rf)
varImpPlot(rf)
varImp(rf)


###### PREDICTION AND PERFORMANCE MATRIX #########################

pred1=predict(rf) # -> see the probab with which is guessing a prediction

library(caret)
RMSE(pred1, mydata_1$Total_video_red_body)

#library(ROCR)
#perf = prediction(pred1[,2], mydata_1$Total_video_red_head)

#pred3 = performance(perf, "tpr","fpr")

### NOT USED FOR REGRESSION ONLY FOR CLASSIFICATION #####

# library(ROCR)

# # 1. Area under curve
# auc = performance(perf, "auc")
# auc
# # 2. True Positive and Negative Rate
# pred3 = performance(perf, "tpr","fpr")
# # 3. Plot the ROC curve
# plot(pred3,main="ROC Curve for Random Forest",col=2,lwd=2)
# abline(a=0,b=1,lwd=2,lty=2,col="gray")