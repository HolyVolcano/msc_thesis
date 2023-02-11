

features <- read.csv(file = "C:/Users/MJAR0016/Desktop/data_SHAPP.csv")

cols.input <- c("Total_video_red_head","Total_video_red_body")
features[,cols.input] <- features[,cols.input] * 100

features <- features[,2:18]

data1 <- na.omit(features)

# Check types of variables
str(data1)


# load library
library(caret)
library(e1071)

# Transforming the dependent variable to a factor
data1$Type = as.factor(data1$Type)

#Partitioning the data into training and validation data
set.seed(101)
index = createDataPartition(data1$Type, p = 0.7, list = F )
train = data1[index,]
validation = data1[-index,]

# Explore data
dim(train)
dim(validation)
names(train)
head(train)
head(validation)

# Setting levels for both training and validation data
levels(train$Type) <- make.names(levels(factor(train$Type)))
levels(validation$Type) <- make.names(levels(factor(validation$Type)))

# Setting up train controls
repeats = 3
numbers = 10
tunel = 10

set.seed(1234)
x = trainControl(method = "repeatedcv",
                 number = numbers,
                 repeats = repeats,
                 classProbs = TRUE,
                 summaryFunction = twoClassSummary)

model1 <- train(Type~. , data = train, method = "knn",
                preProcess = c("center","scale"),
                trControl = x,
                metric = "ROC",
                tuneLength = tunel)

# Summary of model
model1
plot(model1)

# Validation
valid_pred <- predict(model1,validation, type = "prob")

#Storing Model Performance Scores
library(ROCR)
pred_val <-prediction(valid_pred[,2],validation$Type)

# Calculating Area under Curve (AUC)
perf_val <- performance(pred_val,"auc")
perf_val

# Plot AUC
perf_val <- performance(pred_val, "tpr", "fpr")
plot(perf_val, col = "green", lwd = 1.5)

#Calculating KS statistics
ks <- max(attr(perf_val, "y.values")[[1]] - (attr(perf_val, "x.values")[[1]]))
ks