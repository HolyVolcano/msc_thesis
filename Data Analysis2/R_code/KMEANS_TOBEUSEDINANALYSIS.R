##################### K MEANS GOOD ################################# 




features <- read.csv(file = "C:/Users/MJAR0016/Desktop/try.csv")
head(features)

cols.input <- c(
  "Total_video_red_head","Total_video_red_body")

features[,cols.input] <- features[,cols.input] * 100
features <- features[-6,]

colnames(features)[1]  <- "Type"

head(features)




library(factoextra)
library(cluster)

df1 <- features[,c(1:17)]
df <- scale(features[,c(2:17)])


fviz_nbclust(df, kmeans, method = "wss")


#calculate gap statistic based on number of clusters
gap_stat <- clusGap(df,
                    FUN = kmeans,
                    nstart = 25,
                    K.max = 10,
                    B = 50)

#plot number of clusters vs. gap statistic
fviz_gap_stat(gap_stat)


#make this example reproducible
set.seed(1)

#perform k-means clustering with k = 4 clusters
km <- kmeans(df, centers = 2, nstart = 25)


fviz_cluster(km, data = df)

aggregate(features[,c(2:17)], by=list(cluster=km$cluster), mean)

cm <- table(df1$Type, km$cluster)


# First, relabel the data with the cluster number
df1$cluster = km$cluster
for (i in 1:length(df1$Type)){
  if (df1$cluster[i] == 1){
    df1$label[i] = "OCD"
  } else if (df1$cluster[i] == 2){
    df1$label[i] = "control"
  } 
}
# Second, calculate the accuracy score
mean(df1$label ==df1$Type)
count(df1$label ==df1$Type)














