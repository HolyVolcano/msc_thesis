
library(ggpubr)
library(tidyr)

############## CSV ####################

features <- read.csv(file = "C:/Users/MJAR0016/Desktop/final_rea_MEA.csv")
head(features)

cols.input <- c("Th_lead_red_head","Pat_lead_red_head",
          "Total_video_red_head","Th_lead_red_body","Pat_lead_red_body","Total_video_red_body")

features[,cols.input] <- features[,cols.input] * 100


features <- features[-6,]

################################ BODY RED #########################################

gathercols <- c("Pat_lead_red_body", "Th_lead_red_body", "Total_video_red_body")

data_3 <- gather(features, condition, measurement, gathercols, factor_key=TRUE)
str(data_3)




################################ GRAPHS ##########################################################


p1 <- ggplot(data_3, aes(x=condition, y=measurement, fill=Type)) + 
  geom_boxplot() +
  geom_point(position=position_jitterdodge(),alpha=0.5) + 
  ggtitle("Boxplot of BODY Synch % by Regions")  +
    xlab("Synchrony Regions") + ylab("Body Synchrony Percentage (%)")

p1 +  theme_minimal() + theme(legend.position = c(0.9, 0.9),text = element_text(size = 26),
            legend.text=element_text(size=18),
            legend.title=element_text(size=16)) + theme(plot.title = element_text(hjust = 0.5)) + 
  scale_fill_manual(labels = c("Control", "OCD"), values=c("#FFF033", "#950BD3"))
  

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