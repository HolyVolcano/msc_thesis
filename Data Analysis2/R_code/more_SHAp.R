features <- read.csv(file = "C:/Users/MJAR0016/Desktop/data_4_SHAP.csv")
head(features)
# 
# features1 <- features[,2:15]
# head(features)

library(xgboost)
library(shapr)



library(farff)
library(OpenML)
library(dplyr)
library(xgboost)
library(ggplot2)
library(SHAPforxgboost)

# Load King Country house prices dataset on OpenML
# ID 42092, https://www.openml.org/d/42092

df <- features

# Define response and features
y <- features[16]
x <- features[,3:15]

# random split
set.seed(83454)
ix <- sample(nrow(df), 0.8 * nrow(df))

dtrain <- xgb.DMatrix(data.matrix(df[ix, x]),
                      label = df[ix, y])
dvalid <- xgb.DMatrix(data.matrix(df[-ix, x]),
                      label = df[-ix, y])

params <- list(
  objective = "reg:squarederror",
  learning_rate = 0.05,
  subsample = 0.9,
  colsample_bynode = 1,
  reg_lambda = 2,
  max_depth = 5
)

fit_xgb <- xgb.train(
  params,
  data = dtrain,
  watchlist = list(valid = dvalid),
  early_stopping_rounds = 20,
  print_every_n = 100,
  nrounds = 10000 # early stopping
)