# Instagram Engagement Analysis

This project analyzes Instagram engagement data to identify trends in user interactions, focusing on how factors such as time of day, the use of hashtags, and post types (videos or multiple images) influence the number of likes and comments.

## Dataset

The dataset used in this analysis is sourced from [Kaggle](https://www.kaggle.com/datasets/propriyam/instagram-data).

## Key Analysis Steps

1. **Data Cleaning**: The dataset was cleaned by removing empty rows and converting Unix timestamps to readable date formats.
2. **Exploratory Data Analysis**: Several visualizations were created to explore engagement patterns:
   - **Engagement by Time of Day**: Examining how likes and comments vary throughout the day.
   - **Hashtag Analysis**: Exploring the impact of different hashtags and their frequency of use on engagement.
   - **Post Type Analysis**: Comparing the engagement on video posts vs. posts with multiple images.
   
## Tools Used

- **R**: Data manipulation, cleaning, and visualization.
- **RMarkdown**: Documentation and report generation.
- **Libraries**:
  - `tidyverse` for data manipulation and visualization.
  - `lubridate` for working with dates and times.
  - `stringr` for string manipulation.

## Conclusion

This analysis provides insights into optimizing Instagram posts for higher engagement. By analyzing factors like time, hashtag use, and post type, creators can make informed decisions to maximize their audience interaction.

## How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/instagram-engagement-analysis.git
   
2.	Open the Instagram_Engagement_Analysis.Rmd file in RStudio and run the code to reproduce the analysis.
