library(farff)
library(OpenML)
library(dplyr)
library(xgboost)
library(ggplot2)
library(SHAPforxgboost)

features <- read.csv(file = "C:/Users/MJAR0016/Desktop/data_SHAP.csv")

cols.input <- c("Total_video_red_head","Total_video_red_body")

features[,cols.input] <- features[,cols.input] * 100

head(features)

df <- na.omit(features)

y = as.matrix(features[17])
x = as.matrix(features[,3:16])


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


# Step 1: Select some observations
X <- data.matrix(df[sample(nrow(df), 9), x])
# Step 2: Crunch SHAP values
shap <- shap.prep(fit_xgb, X_train = X)
# Step 3: SHAP importance
shap.plot.summary(shap)
# Step 4: Loop over dependence plots in decreasing importance
for (v in shap.importance(shap, names_only = TRUE)) {
  p <- shap.plot.dependence(shap, v, color_feature = "auto", 
                            alpha = 0.5, jitter_width = 0.1) +
    ggtitle(v)
  print(p)
}