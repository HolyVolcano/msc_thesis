library(tidyverse)
library(xgboost)
library(caret)
source("C:/Users/MJAR0016/Desktop/shap.R")

features <- read.csv(file = "C:/Users/MJAR0016/Desktop/data_SHAP.csv")

cols.input <- c("Total_video_red_head","Total_video_red_body")

features[,cols.input] <- features[,cols.input] * 100

head(features)

features <- na.omit(features)

y = as.matrix(features[17])
x = as.matrix(features[,3:16])
###############################################################################################################

xgboost_model <- xgboost(data = x, label = y, max.depth = 2, eta = 1, 
                     nthread = 2, nrounds = 2)

shap_values=predict(xgboost_model,features, predcontrib = TRUE, approxcontrib = F)


##############################################################################################################

library(shapr)
model <- xgboost(
  data = x,
  label = y,
  nround = 20,
  verbose = FALSE
)

# Prepare the data for explanation
explainer <- shapr(x, model, n_combinations = 1000)

p <- mean(y)

explanation <- explain(
  x,
  approach = "empirical",
  explainer = explainer,
  prediction_zero = p
)

print(explanation$dt)

plot(explanation$dt[,1:9])






####################################################################################################

model_bike = xgboost(data = x, 
                     nround = 10, 
                     objective="reg:linear",
                     label= y)  

shap_result_bike = shap.score.rank(xgb_model = model_bike, 
                                   X_train =x,
                                   shap_approx = F
)

shap_long_bike = shap.prep(shap = shap_result_bike,
                           X_train = x , 
                           top_n = 14
)

plot.shap.summary(data_long = shap_long_bike)

xgb.plot.shap(data = x, # input data
              model = model_bike, # xgboost model
              features = names(shap_result_bike$mean_shap_score[1:10]), # only top 10 var
              n_col = 3, # layout option
              plot_loess = T # add red line to plot
)
