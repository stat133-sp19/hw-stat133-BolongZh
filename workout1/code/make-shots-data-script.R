##Data preparation script

#1.input:data of our chosen nba players
#2.output:table and summary of chosen nba players' shots
#3.description

#assign variable names to each data set
kt<- read.csv(file="../Desktop/STAT133/workout1/data/klay-thompson.csv", stringsAsFactors = FALSE)
kd<- read.csv(file="../Desktop/STAT133/workout1/data/kevin-durant.csv", stringsAsFactors = FALSE)
sc<- read.csv(file="../Desktop/STAT133/workout1/data/stephen-curry.csv", stringsAsFactors = FALSE)
ai<- read.csv(file="../Desktop/STAT133/workout1/data/andre-iguodala.csv", stringsAsFactors = FALSE)
dg<- read.csv(file="../Desktop/STAT133/workout1/data/draymond-green.csv", stringsAsFactors = FALSE)
nba <- read.csv(file="../Desktop/STAT133/workout1/data/nba2018-players.csv",stringsAsFactors = FALSE)

#create a column for the player name
kt$name <- "Klay-Thompson"
kd$name <- "Kevin Durant"
sc$name <- "Stephen Curry"
ai$name <- "Andre Iguodala"
dg$name <- "Draymond Green"

#clarify y/n as in the column shot_made_flage
kt$shot_made_flag[kt$shot_made_flag=="n"] <- "shot_no"
kt$shot_made_flag[kt$shot_made_flag=="y"] <- "shot_yes"

kd$shot_made_flag[kd$shot_made_flag=="n"] <- "shot_no"
kd$shot_made_flag[kd$shot_made_flag=="y"] <- "shot_yes"

sc$shot_made_flag[sc$shot_made_flag=="n"] <- "shot_no"
sc$shot_made_flag[sc$shot_made_flag=="y"] <- "shot_yes"

ai$shot_made_flag[ai$shot_made_flag=="n"] <- "shot_no"
ai$shot_made_flag[ai$shot_made_flag=="y"] <- "shot_yes"

dg$shot_made_flag[dg$shot_made_flag=="n"] <- "shot_no"
dg$shot_made_flag[dg$shot_made_flag=="y"] <- "shot_yes"

#add a column storing information about the minute in a match when a shot is made
kt$minute <- (kt$period *12)-kt$minutes_remaining
kd$minute <- (kd$period *12)-kd$minutes_remaining
sc$minute <- (sc$period *12)-sc$minutes_remaining
ai$minute <- (ai$period *12)-ai$minutes_remaining
dg$minute <- (dg$period *12)-dg$minutes_remaining

#assign variable names to the summary of each data set
kt_sum <- summary(kt)
kd_sum <- summary(kd)
sc_sum <- summary(sc)
ai_sum <- summary(ai)
dg_sum <- summary(dg)

#output summaries as txt files
sink("../Desktop/STAT133/workout1/output/klay-thompson-summmary.txt")
kt_sum
sink()

sink("../Desktop/STAT133/workout1/output//kevin-durant-summmary.txt")
kd_sum
sink()

sink("../Desktop/STAT133/workout1/output/stephen-curry-summmary.txt")
sc_sum
sink()

sink("../Desktop/STAT133/workout1/output/andre-iguodala-summmary.txt")
ai_sum
sink()

sink("../Desktop/STAT133/workout1/output/draymond-green-summmary.txt")
dg_sum
sink()

#stack tables into one single data frame of all our chosen players and export it as csv file. Then generate its summary.
assembled <- rbind(kt,kd,sc,ai,dg)
write.csv(assembled,file="../Desktop/STAT133/workout1/data/shots-data.csv")

sink("../Desktop/STAT133/workout1/output/shots-data-summmary.txt")
summary(assembled)
sink()

