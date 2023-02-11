
############################## ALL FEATURES ###############################


features <- read.csv(file = "C:/Users/MJAR0016/Desktop/final_bun.csv")
head(features)

cols.input <- c(
                "Total_video_red_head","Total_video_red_body")

features[,cols.input] <- features[,cols.input] * 100
head(features)

features <- features[-6,]

library(ggfortify)
df <- features[,c(3:16)]
pca_res <- prcomp(df, scale. = TRUE)



autoplot(pca_res, data = features, colour = 'Type')

# loadings
head(pca_res$rotation)
head(pca_res$x)


############################## No % ###############################


library(ggfortify)
df <- features[,c(3:16)]
pca_res <- prcomp(na.omit(df), scale. = TRUE)

autoplot(pca_res, data = na.omit(features), colour = 'Type')


############################# w/out adult and all percentages ##########


library(ggfortify)
df <- features[,c(3:4,11:18)] 
pca_res <- prcomp(na.omit(df), scale. = TRUE)

autoplot(pca_res, data = na.omit(features), colour = 'Type')


########################## w/out adult and no percentages ##########################


library(ggfortify)
df <- features[,c(3:4,11:16)] 
pca_res <- prcomp(na.omit(df), scale. = TRUE)

autoplot(pca_res, data = na.omit(features), colour = 'Type')