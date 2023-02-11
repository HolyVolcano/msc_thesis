############## CSV ####################

features <- read.csv(file = "C:/Users/MJAR0016/Desktop/final_red_orange_MEA.csv")
head(features)

cols.input <- c("Th_lead_red_orange_head","Pat_lead_red_orange_head",
                "Total_video_red_orange_head","Th_lead_red_orange_body","Pat_lead_red_orange_body","Total_video_red_orange_body")

features[,cols.input] <- features[,cols.input] * 100

################################ BODY RED #########################################

gathercols <- c("Pat_lead_red_orange_body", "Th_lead_red_orange_body", "Total_video_red_orange_body")

data_3 <- gather(features, condition, measurement, gathercols, factor_key=TRUE)
data_3

p1 <- ggplot(data_3, aes(x=condition, y=measurement, fill=Type)) + 
  geom_boxplot() +
  geom_point(position=position_jitterdodge(),alpha=0.5) + 
  ggtitle("Boxplot of BODY Synch % by Regions")  +
  xlab("Synchrony Regions") + ylab("Body Synchrony Percentage (%)")

p1 +  theme_minimal() + theme(legend.position = c(0.9, 0.9),text = element_text(size = 26),
                              legend.text=element_text(size=18),
                              legend.title=element_text(size=16)) + theme(plot.title = element_text(hjust = 0.5)) + 
  scale_fill_manual(labels = c("Control", "OCD"), values=c("#FFF033", "#950BD3"))


ggsave("C:/Users/MJAR0016/Desktop/body_red_orange.pdf", width = 30, height = 20, units = "cm")


################################ HEAD RED ##########################################


gathercols1 <- c("Pat_lead_red_orange_head", "Th_lead_red_orange_head", "Total_video_red_orange_head")

data_4 <- gather(features, condition, measurement, gathercols1, factor_key=TRUE)
data_4

p2 <- ggplot(data_4, aes(x=condition, y=measurement, fill=Type)) + 
  geom_boxplot() +
  geom_point(position=position_jitterdodge(),alpha=0.5) + 
  ggtitle("Boxplot of HEAD Synch % by Regions")  +
  xlab("Synchrony Regions") + ylab("Head Synchrony Percentage (%)")

p2 +  theme_minimal() + theme(legend.position = c(0.9, 0.9),text = element_text(size = 22),
                              legend.text=element_text(size=14),
                              legend.title=element_text(size=12)) + theme(plot.title = element_text(hjust = 0.5)) + 
  scale_fill_manual(labels = c("Control", "OCD"), values=c("#FFF033", "#950BD3"))


ggsave("C:/Users/MJAR0016/Desktop/head_red_orange.pdf", width = 30, height = 30, units = "cm")