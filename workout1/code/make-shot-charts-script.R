##shot charts
#1.input
#2.output
#3.description

#court image(to be used as background of plot)
court_file <- "../Desktop/STAT133/workout1/images/nba-court.jpg"

#create raste obeject
library(jpeg)
library(grid)
library(ggplot2)
court_image <- rasterGrob(readJPEG(court_file),
                          width = unit(1,"npc"),
                          height = unit(1,"npc"))

#shot chart with court background
klay_shot_chart <- ggplot(data=kt)+
  annotation_custom(court_image,-250,250,-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Chart: Klay Thompson (2016 season)')+
  theme_minimal()

#storing images as pdf files
pdf(file = "../Desktop/STAT133/workout1/images/klay-thompson-shot-chart.pdf", width = 6.5, height = 5) 
klay_shot_chart
dev.off()

#This one is for kevin
kevin_shot_chart <- ggplot(data=kd)+
  annotation_custom(court_image,-250,250,-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Chart: Kevin Durant (2016 season)')+
  theme_minimal()

pdf(file = "../Desktop/STAT133/workout1/images/kevin-durant-shot-chart.pdf", width = 6.5, height = 5) 
kevin_shot_chart
dev.off()

#This one is for Stephen
stephen_shot_chart <- ggplot(data=sc)+
  annotation_custom(court_image,-250,250,-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Chart: Stephen Curry (2016 season)')+
  theme_minimal()

pdf(file = "../Desktop/STAT133/workout1/images/stephen-curry-shot-chart.pdf", width = 6.5, height = 5) 
stephen_shot_chart
dev.off()

#This punch is for Andre
andre_shot_chart <- ggplot(data=ai)+
  annotation_custom(court_image,-250,250,-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Chart: Andre Iguodala (2016 season)')+
  theme_minimal()

pdf(file = "../Desktop/STAT133/workout1/images/andre-iguodala-shot-chart.pdf", width = 6.5, height = 5) 
andre_shot_chart
dev.off()

#This kick is for Draymond
draymond_shot_chart <- ggplot(data=dg)+
  annotation_custom(court_image,-250,250,-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Chart: Stephen Curry (2016 season)')+
  theme_minimal()

pdf(file = "../Desktop/STAT133/workout1/images/draymond-green-shot-chart.pdf", width = 6.5, height = 5) 
draymond_shot_chart
dev.off()

#Taste the punches from all enraged players!(facetting to show all charts in one image)
#This assembled image will be stored as both pdf and png
assembled_shot_chart <- ggplot(data=assembled)+
  annotation_custom(court_image,-250,250,-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle("Shot Charts: GSW (2016 season)")+
  facet_wrap(~name)+
  theme_minimal()

pdf(file = "../Desktop/STAT133/workout1/images/gsw-shot-charts.pdf", width = 8, height = 7) 
assembled_shot_chart
dev.off()

png(file = "../Desktop/STAT133/workout1/images/gsw-shot-charts.png", width = 8, height = 7) 
assembled_shot_chart
dev.off()
