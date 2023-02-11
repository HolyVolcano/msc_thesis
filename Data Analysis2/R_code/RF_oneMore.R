 # https://www.r-bloggers.com/2021/04/random-forest-in-r/ 

library(randomForest)
library(datasets)
library(caret)


features <- read.csv(file = "C:/Users/MJAR0016/Desktop/data_SHAPP.csv")

cols.input <- c("Total_video_red_head","Total_video_red_body","Th_lead_red_head", "Th_lead_red_body",
                "Pat_lead_red_head", "Pat_lead_red_body")

features[,cols.input] <- features[,cols.input] * 100

features <- features[,2:22]

data <- na.omit(features)

# Check types of variables
str(data)

write.csv(data, "C:/Users/MJAR0016/Desktop/DATA.csv")


data$Type <- as.factor(data$Type)
table(data$Type)

set.seed(222)
ind <- sample(2, nrow(data), replace = TRUE, prob = c(0.7, 0.3))
train <- data[ind==1,]
test <- data[ind==2,]


rf <- randomForest(Type~., data=train, proximity=TRUE) 
print(rf)

p1 <- predict(rf, train)
confusionMatrix(p1, train$ Type)

p2 <- predict(rf, test)
confusionMatrix(p2, test$ Type)

plot(rf)

t <- tuneRF(train[,-5], train[,5],
            stepFactor = 0.5,
            plot = TRUE,
            ntreeTry = 150,
            trace = TRUE,
            improve = 0.05)


hist(treesize(rf),
     main = "No. of Nodes for the Trees",
     col = "green")

varImpPlot(rf,
           sort = T,
           n.var = 10,
           main = "Top 10 - Variable Importance")
importance(rf)

partialPlot(rf, train, Openface_gaze_child, "Control")

MDSplot(rf, train$Types)
