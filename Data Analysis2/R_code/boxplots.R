

############## CSV ####################

features <- read.csv(file = "C:/Users/MJAR0016/Desktop/final.csv")
head(features)


############# PLOT ######################

boxplot(features$Pat_lead_orange_head)


boxplot(features$Pat_lead_orange_head, features$Pat_lead_green_head,
        main="Different boxplots for synchrony",
        col="orange",
        border="brown"
)

library(ggplot2)

ggplot(features, aes(x=))


data_long <- gather(features, condition, measurement, Pat_lead_orange_head:Pat_lead_green_head, factor_key=TRUE)
data_long

library(tidyr)

ggplot(data_long, aes(x=condition, y=measurement, fill=Type))+ geom_boxplot()


data_long_body_pat_lead <- gather(features, condition, measurement, Pat_lead_orange_body:Pat_lead_green_body, factor_key=TRUE)
data_long_body_pat_lead

ggplot(data_long_body_pat_lead, aes(x=condition, y=measurement, fill=Type))+ geom_boxplot()



data_long_head_th_lead <- gather(features, condition, measurement, Th_lead_orange_head:Th_lead_green_head, factor_key=TRUE)
data_long_head_th_lead

ggplot(data_long_head_th_lead, aes(x=condition, y=measurement, fill=Type))+ geom_boxplot()


data_long_body_th_lead <- gather(features, condition, measurement, Th_lead_orange_body:Th_lead_green_body, factor_key=TRUE)
data_long_body_th_lead

ggplot(data_long_body_th_lead, aes(x=condition, y=measurement, fill=Type))+ geom_boxplot()


data_long_head_total <- gather(features, condition, measurement, Total_video_orange_head:Total_video_green_head, factor_key=TRUE)
data_long_head_total

ggplot(data_long_head_total, aes(x=condition, y=measurement, fill=Type))+ geom_boxplot()



data_long_body_total <- gather(features, condition, measurement, Total_video_orange_body:Total_video_green_body, factor_key=TRUE)
data_long_body_total

ggplot(data_long_body_total, aes(x=condition, y=measurement, fill=Type)) + 
  geom_boxplot() +
  geom_point(position=position_jitterdodge(),alpha=0.5)




##############################################################################################################


gathercols <- c("Pat_lead_orange_head", "Th_lead_orange_head", "Total_video_orange_head")

data_1 <- gather(features, condition, measurement, gathercols, factor_key=TRUE)
data_1

ggplot(data_1, aes(x=condition, y=measurement, fill=Type)) + 
  geom_boxplot() +
  geom_point(position=position_jitterdodge(),alpha=0.5)


gathercols1 <- c("Pat_lead_orange_body", "Th_lead_orange_body", "Total_video_orange_body")

data_2 <- gather(features, condition, measurement, gathercols1, factor_key=TRUE)
data_2

ggplot(data_2, aes(x=condition, y=measurement, fill=Type)) + 
  geom_boxplot() +
  geom_point(position=position_jitterdodge(),alpha=0.5)


###############################################################################################################


gathercols2 <- c("Pat_lead_green_body", "Th_lead_green_body", "Total_video_green_body")

data_3 <- gather(features, condition, measurement, gathercols2, factor_key=TRUE)
data_3

ggplot(data_3, aes(x=condition, y=measurement, fill=Type)) + 
  geom_boxplot() +
  geom_point(position=position_jitterdodge(),alpha=0.5)



gathercols3 <- c("Pat_lead_green_head", "Th_lead_green_head", "Total_video_green_head")

data_4 <- gather(features, condition, measurement, gathercols3, factor_key=TRUE)
data_4

ggplot(data_4, aes(x=condition, y=measurement, fill=Type)) + 
  geom_boxplot() +
  geom_point(position=position_jitterdodge(),alpha=0.5)


############################################################################################
library(ggfortify)
df <- features[,c(3:14,17:28)]
pca_res <- prcomp(df, scale. = TRUE)

autoplot(pca_res, data = features, colour = 'Type')


#############################################################################################


library(ggfortify)
df <- features[,c(15:28)]
pca_res <- prcomp(na.omit(df), scale. = TRUE)

autoplot(pca_res, data = na.omit(features), colour = 'Type')





##################################################################################################

# PCA without adult 

library(ggfortify)
df <- features[,c(3:16,23:28)]  # with procentages
pca_res <- prcomp(na.omit(df), scale. = TRUE)

autoplot(pca_res, data = na.omit(features), colour = 'Type')


#########################################################################

# PCA without adult 

library(ggfortify)  # without procentages
df <- features[,c(15:16,23:28)]  
pca_res <- prcomp(na.omit(df), scale. = TRUE)

autoplot(pca_res, data = na.omit(features), colour = 'Type', loadings = TRUE,  loadings.label = TRUE, loadings.label.size = 3)


##################################################################################################

# PCA without adult 

library(ggfortify)  # without procentages
df <- features[,c(23:28)]  
pca_res <- prcomp(df, scale. = TRUE)

autoplot(pca_res, data = features, colour = 'Type', loadings = TRUE,  loadings.label = TRUE, loadings.label.size = 3)







####################################################3

# ALL FEATURES

# PCA without adult 


library(ggfortify)  # without procentages
df <- features[,c(3:28)] 
pca_res <- prcomp(na.omit(df), scale. = TRUE)

autoplot(pca_res, data = na.omit(features), colour = 'Type', loadings = TRUE,  loadings.label = TRUE, loadings.label.size = 3)







######################################?
library(missMDA)

pca_full <- imputePCA(features[,c(3:28)])

pca_res <- prcomp(pca_full$completeObs, scale. = TRUE)

autoplot(pca_res, data = features, colour = 'Type', loadings = TRUE, 
         loadings.label = TRUE, loadings.label.size = 3)



