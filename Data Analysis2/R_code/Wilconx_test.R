library(ggpubr)
library(tidyr)
library(rstatix)

############## CSV ####################

features <- read.csv(file = "C:/Users/MJAR0016/Desktop/final_rea_MEA.csv")
head(features)

cols.input <- c("Th_lead_red_head","Pat_lead_red_head",
                "Total_video_red_head","Th_lead_red_body","Pat_lead_red_body","Total_video_red_body")

features[,cols.input] <- features[,cols.input] * 100

################################ BODY RED #########################################

gathercols <- c("Pat_lead_red_body", "Th_lead_red_body", "Total_video_red_body", "Total_video_red_head")

data_3 <- gather(features, condition, measurement, gathercols, factor_key=TRUE)
str(data_3)



# data_3$Type <- as.factor(data_3$Type)
# head(data_3, 3)

data_3[data_3$condition=="Total_video_red_head",]

stat.test <- data_3 %>% 
  wilcox_test(measurement ~ Type) %>%
  add_significance()
stat.test

data_3 %>% wilcox_effsize(measurement ~ Type)

stat.test <- stat.test %>% add_xy_position(x = "group")

p1 <- ggplot(data_3, aes(x=data_3$condition=="Total_video_red_body", y=measurement, fill=Type)) + 
  geom_boxplot() +
  geom_point(position=position_jitterdodge(),alpha=0.5) + 
  ggtitle("Boxplot of BODY Synch % by Regions")  +
  xlab("Synchrony Regions") + ylab("Body Synchrony Percentage (%)")

p2 <- p1 +  theme_minimal() + theme(legend.position = c(0.9, 0.9),text = element_text(size = 26),
                                    legend.text=element_text(size=18),
                                    legend.title=element_text(size=16)) + theme(plot.title = element_text(hjust = 0.5)) + 
  scale_fill_manual(labels = c("Control", "OCD"), values=c("#FFF033", "#950BD3"))

p2 + 
  stat_pvalue_manual(stat.test, tip.length = 0) +
  labs(subtitle = get_test_label(stat.test, detailed = TRUE))