
library(ggpubr)
library(tidyr)
library(ggpubr)

############## CSV ####################

features <- read.csv(file = "C:/Users/MJAR0016/Desktop/final_rea_MEA.csv")
head(features)

cols.input <- c("Th_lead_red_head","Pat_lead_red_head",
                "Total_video_red_head","Th_lead_red_body","Pat_lead_red_body","Total_video_red_body")

features[,cols.input] <- features[,cols.input] * 100

features <- features[-6,]

################################ BODY RED #########################################

gathercols <- c("Pat_lead_red_body", "Th_lead_red_body", "Total_video_red_body", "Total_video_red_head")
# gathercols <- c("Total_video_red_head", "Total_video_red_body") # used for statistical tests


data_3 <- gather(features, condition, measurement, gathercols, factor_key=TRUE)
str(data_3)

-------------------------------------------------------------------------------------------------------------------------------

# data_3$Type <- as.factor(data_3$Type)
# head(data_3, 3)

data_3[data_3$condition=="Total_video_red_head",]
dim <- features[,c(8)]

# Statistical test
# stat.test <- data_3 %>%
# t_test(measurement ~ condition) %>%
# add_significance()
# stat.test

compare_means(measurement ~ Type, data = data_3[data_3$condition=="Total_video_red_body",])
compare_means(measurement ~ Type, data = data_3[data_3$condition=="Total_video_red_head",])


test <- wilcox.test(measurement ~ Type, data = data_3[data_3$condition=="Total_video_red_body",])
test1 <- wilcox.test(measurement ~ Type, data = data_3[data_3$condition=="Total_video_red_head",])


################ CHECK if normal distribution for BODY CORR ##############

dff <- data_3[data_3$condition=="Total_video_red_body",]  

hist(subset(dff, Type == "Control")$measurement,
     main = "BODY Synchrony (%) distribution for Control patients",
     xlab = "Synchrony (%)"
)

hist(subset(dff, Type == "OCD")$measurement,
     main = "BODY Synchrony (%) distribution for OCD patients",
     xlab = "Synchrony (%)"
)

shapiro.test(subset(data_3, Type == "Control")$measurement)
shapiro.test(subset(data_3, Type == "OCD")$measurement)


################ CHECK if normal distribution for HEAD CORR ##############

dff1 <- data_3[data_3$condition=="Total_video_red_head",]

hist(subset(dff1, Type == "Control")$measurement,
     main = "HEAD Synchrony (%) distribution for Control patients",
     xlab = "Synchrony (%)"
)

hist(subset(dff1, Type == "OCD")$measurement,
     main = "HEAD Synchrony (%) distribution for OCD patients",
     xlab = "Synchrony (%)"
)

shapiro.test(subset(dff1, Type == "Control")$measurement)
shapiro.test(subset(dff1, Type == "OCD")$measurement)


################################ GRAPHS ##########################################################


p1 <- ggplot(data_3, aes(x=data_3$condition=="Total_video_red_body", y=measurement, fill=Type)) + 
  geom_boxplot() +
  geom_point(position=position_jitterdodge(),alpha=0.5) + 
  ggtitle("Boxplot of BODY Synch % by Regions")  +
  xlab("Synchrony Regions") + ylab("Body Synchrony Percentage (%)")

p2 <- p1 +  theme_minimal() + theme(legend.position = c(0.9, 0.9),text = element_text(size = 26),
                              legend.text=element_text(size=18),
                              legend.title=element_text(size=16)) + theme(plot.title = element_text(hjust = 0.5)) + 
  scale_fill_manual(labels = c("Control", "OCD"), values=c("#FFF033", "#950BD3"))

p2 
# p2 + stat_compare_means(method = "Wilcoxon") 

# p2 + 
#   stat_pvalue_manual(compare_mean(), tip.length = 0) +
#   labs(subtitle = get_test_label(stat.test, detailed = TRUE))

ggsave("C:/Users/MJAR0016/Desktop/body_red.pdf", width = 30, height = 20, units = "cm")


################################ HEAD RED ##########################################


gathercols1 <- c("Pat_lead_red_head", "Th_lead_red_head", "Total_video_red_head")

data_4 <- gather(features, condition, measurement, gathercols1, factor_key=TRUE)
data_4

p2 <- ggplot(data_4, aes(x=condition, y=measurement, fill=Type)) + 
  geom_boxplot() +
  geom_point(position=position_jitterdodge(),alpha=0.5) + 
  ggtitle("Boxplot of HEAD Synch % by Regions")  +
  xlab("Synchrony Regions") + ylab("Head Synchrony Percentage (%)")

p2 +  theme_minimal() + theme(legend.position = c(0.9, 0.9),text = element_text(size = 26),
                              legend.text=element_text(size=18),
                              legend.title=element_text(size=16)) + theme(plot.title = element_text(hjust = 0.5)) + 
  scale_fill_manual(labels = c("Control", "OCD"), values=c("#FFF033", "#950BD3"))


ggsave("C:/Users/MJAR0016/Desktop/head_red.pdf", width = 30, height = 20, units = "cm")