#Mohammed Saif Wasay
#ALY6010 80685
#Probability Theory and Introductory Statistics

# Loading Libraries
library(pacman)
p_load(tidyverse, dplyr, psych, ggthemes, plotly)

# Reading the dataset
fifa <- read.csv("C:/Users/Mohammed Saif Wasay/Documents/code/data/player_stats.csv")

# Checking for missing data
na_counts <- colSums(is.na(fifa))
empty_counts <- colSums(fifa == "")
none_counts <- colSums(fifa == "None")

# Removing the 'marking' column which has all empty or 'None' values
fifa <- fifa %>% select(-marking)

# Converting 'value' column from string to integer
fifa$value <- fifa$value %>% gsub("[$.]", "", .) %>% as.numeric()
class(fifa$value)

# Removing rows with non-ASCII characters in 'player' column
fifa$player <- fifa$player %>% iconv(to = "ASCII//TRANSLIT") %>% gsub("e", "e", .)
fifa <- fifa %>% drop_na()

# Creating a new column to identify outfield players and goalkeepers
fifa <- fifa %>% mutate(position_type = ifelse(
  gk_positioning < 30 | gk_diving < 30 | gk_handling < 30 | gk_kicking < 30 | gk_reflexes < 30 | att_position == 56,
  "Outfield",
  "Goalkeeper"
))

# Top 30 highest valued players
high_value_30 <- fifa %>% arrange(desc(value)) %>% head(30)

# Bottom 30 lowest valued players
low_value_30 <- fifa %>% arrange(desc(value)) %>% tail(30)

# Descriptive statistics for the entire dataset
stats <- describe(fifa)

# Creating subsets for goalkeepers and outfield players
goalkeeper_columns <- c("player", "position_type", "country", "height", "weight", "age", "club", "gk_positioning", "gk_diving", "gk_handling", "gk_kicking", "gk_reflexes", "value")
goalkeeper_data <- fifa %>% select(goalkeeper_columns) %>% filter(position_type == "Goalkeeper")
outfield_data <- fifa %>% select(-matches("gk_")) %>% filter(position_type != "Goalkeeper")

# Descriptive statistics for numeric data
gk_descriptive_stats <- describe(goalkeeper_data %>% select(where(is.numeric)))
of_descriptive_stats <- describe(outfield_data %>% select(where(is.numeric)))

# Plotting histograms and bar plots
ggplot(fifa, aes(x = position_type)) +
  geom_bar(fill = "green", color = "black") +
  labs(title = "Count of Players by Position Type", x = "Position Type", y = "Count")

ggplot(fifa, aes(x = age)) +
  geom_histogram(binwidth = 1, fill = "yellow", color = "black") +
  labs(title = "Age Distribution of Players", x = "Age", y = "Count") + theme_tufte()

ggplot(fifa, aes(x = height)) +
  geom_histogram(binwidth = 3, fill = "blue", color = "black") +
  labs(title = "Height Distribution of Players", x = "Height", y = "Count") + theme_tufte()

ggplot(fifa, aes(x = weight)) +
  geom_histogram(binwidth = 3, fill = "red", color = "black") +
  labs(title = "Weight Distribution of Players", x = "Weight", y = "Count") + theme_tufte()

ggplot(high_value_30, aes(x = country)) +
  geom_bar(fill = "maroon") +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, color = "black") +
  labs(title = "Highest Valued Players by Country", x = "Country", y = "Count") +
  theme_tufte() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(low_value_30, aes(x = country)) +
  geom_bar(fill = "darkgreen") +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, color = "black") +
  labs(title = "Lowest Valued Players by Country", x = "Country", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Subset of data for major football countries
major_countries <- c("England", "France", "Italy", "Germany", "Spain", "Argentina", "Brazil", "Netherlands")
efigs_data <- fifa %>% filter(country %in% major_countries)

# Total players for each major country
ggplot(efigs_data, aes(x = country)) + 
  geom_bar(fill = "skyblue") +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5) +
  labs(title = "Bar Chart of Total Players for Each Major Country", x = "Country", y = "Count") +
  theme_tufte()

# Scatter plots for various attributes
plot_ly(outfield_data, x = ~ball_control, y = ~dribbling, type = "scatter", mode = "markers", text = ~player) %>%
  layout(title = "Scatter Plot for Ball Control vs Dribbling")

plot_ly(goalkeeper_data, x = ~gk_positioning, y = ~gk_reflexes, type = "scatter", mode = "markers", text = ~player) %>%
  layout(title = "Scatter Plot for Goalkeeper Positioning vs Reflexes")

plot_ly(fifa, x = ~height, y = ~weight, type = "scatter", mode = "markers", text = ~player) %>%
  layout(title = "Scatter Plot for Player Height vs Weight")

# Boxplots for height, weight, and age by position type
ggplot(fifa, aes(x = position_type, y = height, fill = position_type)) +
  geom_boxplot() +
  labs(title = "Boxplot of Height and Position Type", x = "Position Type", y = "Height") +
  scale_fill_manual(values = c("maroon", "yellow")) +
  theme_economist()

ggplot(fifa, aes(x = position_type, y = weight, fill = position_type)) +
  geom_boxplot() +
  labs(title = "Boxplot of Weight and Position Type", x = "Position Type", y = "Weight") +
  scale_fill_manual(values = c("maroon", "yellow")) +
  theme_economist()

ggplot(fifa, aes(x = position_type, y = age, fill = position_type)) +
  geom_boxplot() +
  labs(title = "Boxplot of Age and Position Type", x = "Position Type", y = "Age") +
  scale_fill_manual(values = c("maroon", "yellow")) +
  theme_economist()

# Boxplot for player value by country
ggplot(efigs_data, aes(x = country, y = value)) +
  geom_boxplot(fill = "orange") +
  labs(title = "Boxplot of Value by Country", x = "Country", y = "Value") +
  theme_economist() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Density plot for player age by position type
ggplot(fifa, aes(x = age, fill = position_type)) +
  geom_density(alpha = 0.7) +
  labs(title = "Density Plot for Player Age by Position Type", x = "Age", fill = "Position Type") +
  scale_fill_manual(values = c("Outfield" = "skyblue", "Goalkeeper" = "maroon")) +
  theme_tufte()

