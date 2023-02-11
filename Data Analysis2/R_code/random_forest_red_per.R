

################### RANDOM FOREST #################


# using all variables including RED percentage and try to predict if OCD or non OCD


features <- read.csv(file = "C:/Users/MJAR0016/Desktop/data_SHAPP.csv")

cols.input <- c("Total_video_red_head","Total_video_red_body","Th_lead_red_head", "Th_lead_red_body",
                "Pat_lead_red_head", "Pat_lead_red_body")

features[,cols.input] <- features[,cols.input] * 100

features <- features[,2:22]

mydata <- na.omit(features)
mydata <- mydata[-6,]

# Check types of variables
str(mydata)


dim(mydata)

# Make dependent variable as a factor (categorical)
mydata$Type = as.factor(mydata$Type)

library(randomForest)
set.seed()
rf <-randomForest(Type~.,data=mydata, ntree=500) 
print(rf)

floor(sqrt(ncol(mydata) - 1))


mtry <- tuneRF(mydata[-1],mydata$Type, ntreeTry=500,
               stepFactor=1.5,improve=0.01, trace=TRUE, plot=TRUE)
best.m <- mtry[mtry[, 2] == min(mtry[, 2]), 1]
print(mtry)
print(best.m)





set.seed(100)
rf <-randomForest(Type~.,data=mydata, mtry=best.m, importance=TRUE,ntree=1000)
print(rf)
#Evaluate variable importance
#importance(rf)
#varImpPlot(rf)


###### PREDICTION AND PERFORMANCE MATRIX #########################

pred1=predict(rf,type = "prob") # -> see the probab with which is guessing a prediction

library(ROCR)
perf = prediction(pred1[,2], mydata$Type)
# 1. Area under curve
auc = performance(perf, "auc")
auc
# 2. True Positive and Negative Rate
pred3 = performance(perf, "tpr","fpr")
# 3. Plot the ROC curve
plot(pred3,main="ROC Curve for Random Forest",col=2,lwd=2)
abline(a=0,b=1,lwd=2,lty=2,col="gray")