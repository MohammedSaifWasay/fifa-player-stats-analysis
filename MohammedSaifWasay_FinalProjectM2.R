#Mohammed Saif Wasay, June 2024, ALY6010 80685 - Probability Theory and Introductory Statistics

#Final Project: Milestone 2

cat("\014") # clears console
rm(list = ls()) # clears global environment
try(dev.off(dev.list()["RStudioGD"]), silent = TRUE) # clears plots
try(p_unload(p_loaded(), character.only = TRUE), silent = TRUE) #clears packages
options(scipen = 100) # disables scientific notation for entire R session

#Loading Libraries
library(pacman)
p_load(tidyverse)
library(dplyr)

fifa <- read.csv("player_stats.csv")

#view(fifa)

#Checking Nulls/missing data
colSums(is.na(fifa))
colSums(fifa == "")
colSums(fifa == "None")

#Marking column all values are empty or None hence removing the column
fifa <- subset(fifa, select = -marking)

#Changing Value column from string to integer by removing $ and .
fifa$value <- gsub("[$.]", "", fifa$value)

fifa$value <- as.numeric(fifa$value)
class(fifa$value)

#There few rows with \xe9 removing those from player
fifa$player <- iconv(fifa$player, to = "ASCII//TRANSLIT")
fifa$player <- gsub("e", "e", fifa$player)
fifa <- drop_na(fifa)


#There is no column to check if a player is outfield player or goalkeeper, creating new column for this
fifa <- fifa %>% mutate(position_type = ifelse(
  gk_positioning < 30 | gk_diving < 30 | gk_handling < 30 | gk_kicking < 30 | gk_reflexes < 30 | att_position == 56,
  "Outfield",
  "Goalkeeper"
))

#Creating subsets of data for goalkeeper and outfield players 
goalkeeper_columns <- c("player", "position_type", "country", "height", "weight", "age", "club", "gk_positioning", "gk_diving", "gk_handling", "gk_kicking", "gk_reflexes", "value")
goalkeeper_data <- fifa %>% select(goalkeeper_columns) %>% filter(position_type == "Goalkeeper")
outfield_data <- fifa %>% select(-matches("gk_")) %>% filter(position_type != "Goalkeeper")

goalkeeper_data
outfield_data

#Checking Normality
hist(fifa$age, main="Histogram of Data", col="lightblue", border="black")
qqnorm(fifa$age)
qqline(fifa$age)

#Checking Normality
hist(fifa$weight, main="Histogram of Weight", col="lightblue", border="black")
qqnorm(fifa$weight)
qqline(fifa$weight)

#Checking Normality
hist(fifa$height, main="Histogram of Height", col="lightblue", border="black")
qqnorm(fifa$height)
qqline(fifa$height)

#Hypothesis testing that average weight of outfielders is lesser than goalkeepers weight
of_wt <- mean(outfield_data$weight)
t.test(goalkeeper_data$weight, mu = of_wt, alternative = "greater", conf.level = .95)

#Hypothesis testing that average height of goalkeepers is more than average outfielder height
t.test(goalkeeper_data$height, mu = 180, alternative = "greater", conf.level = .95)

#Hypothesis testing that average age of goalkeepers and outfield players
t.test(outfield_data$age, goalkeeper_data$age, alternative = "less", var.equal = FALSE, conf.level = .95)

