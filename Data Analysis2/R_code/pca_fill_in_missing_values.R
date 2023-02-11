

features <- read.csv(file = "C:/Users/MJAR0016/Desktop/final.csv")
head(features)

nb <- estim_ncpPCA(features[,c(3:28)],method.cv = "Kfold", verbose = FALSE) 


nb$ncp

res.comp <- imputePCA(features[,c(3:28)], ncp = nb$ncp) # iterativePCA algorithm
#res.comp$features[1:3,]

# imp <- cbind.data.frame(res.comp$features,features[,2])


library(missMDA)

pca_full <- imputePCA(features[,c(3:28)])

pca_res <- prcomp(pca_full$completeObs, scale. = TRUE)

autoplot(pca_res, data = features, colour = 'Type', loadings = TRUE, 
         loadings.label = TRUE, loadings.label.size = 3)