# Project 1
# Professor Mahzabeen, DAT301 Class: 76301: 12 PM to 1:15 PM
# Author: Neil Mahajan
# Semptember 5th, 2024



# Step 1: Set Up the Environment and Load the Data

# Install necessary packages 
install.packages(c("tidyverse", "lubridate", "stringr"))

# Load the libraries
library(tidyverse)  # For data manipulation and visualization
library(lubridate)  # For working with dates and times
library(stringr)    # For string manipulation

# Load the dataset: https://www.kaggle.com/datasets/propriyam/instagram-data
instagram_data <- read_csv("instagram_data.csv")

# Remove the last row which doesn't have any data from the dataset
instagram_data <- instagram_data %>% filter(row_number() != 11663)


# Step 2: Inspect and Explore the Data

# Get a quick overview of the dataset
glimpse(instagram_data)
summary(instagram_data)



# Step 3: Convert created_at to a Readable Date-Time Format

# Convert created_at from Unix timestamp to Date-Time format
instagram_data <- instagram_data %>%
  mutate(created_at = as.POSIXct(created_at, origin = "1970-01-01", tz = "UTC"))

# Add new columns for hour of the day and day of the week
instagram_data <- instagram_data %>%
  mutate(hour = hour(created_at),
         day_of_week = wday(created_at, label = TRUE))

# Filter out rows with NA values
instagram_data <- instagram_data %>%
  filter(!is.na(likes) & !is.na(comments) & !is.na(hour))

# Check that created_at is date and time, and hour and day_of_week were added
glimpse(instagram_data)
summary(instagram_data)



# Step 4: Extract Hashtags from the caption Field

# Extract hashtags from the caption field
instagram_data <- instagram_data %>%
  mutate(hashtags = str_extract_all(caption, "#\\S+"))

# Unnest hashtags if you want them in individual rows for analysis
instagram_data <- instagram_data %>%
  unnest(hashtags)

# Add a column for the number of hashtags
instagram_data <- instagram_data %>%
  mutate(num_hashtags = lengths(str_extract_all(caption, "#\\S+")))

# Check that hashtags column is created
glimpse(instagram_data)
summary(instagram_data)



# Step 5: Start with Exploratory Data Analysis

# Engagement by Time of Day: Plot likes and comments by hour of the day
instagram_data %>%
  group_by(hour) %>%
  summarise(avg_likes = mean(likes), avg_comments = mean(comments)) %>%
  ggplot(aes(x = hour)) +
  geom_line(aes(y = avg_likes), color = "blue", linewidth = 1) +
  geom_line(aes(y = avg_comments), color = "red", linewidth = 1) +
  labs(title = "Average Likes and Comments by Time of Day",
       x = "Hour of Day", y = "Average Engagement")

# Engagement by Hashtag String: Most common hashtags and average engagement
instagram_data %>%
  unnest(hashtags) %>%
  group_by(hashtags) %>%
  summarise(avg_likes = mean(likes), avg_comments = mean(comments)) %>%
  arrange(desc(avg_likes)) %>%
  head(10)

# Engagement by Number of Hashtag: Group by number of hashtags and summarize 
#average likes and comments
instagram_data %>%
  group_by(num_hashtags) %>%
  summarise(avg_likes = mean(likes), avg_comments = mean(comments), 
            .groups = "drop") %>%
  ggplot(aes(x = num_hashtags)) +
  geom_line(aes(y = avg_likes), color = "blue", linewidth = 1) +
  geom_line(aes(y = avg_comments), color = "red", linewidth = 1) +
  labs(title = "Average Likes and Comments by Number of Hashtags",
       x = "Number of Hashtags", y = "Average Engagement")

# Engagement by Post Type: Compare average likes and comments for post types
instagram_data %>%
  group_by(is_video, multiple_images) %>%
  summarise(avg_likes = mean(likes), avg_comments = mean(comments), 
            .groups = "drop") %>%
  ggplot(aes(x = is_video, y = avg_likes, fill = multiple_images)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Average Likes by Post Type", x = "Is Video", 
       y = "Average Likes")


