
library(dplyr)
library(stringr)

# Loads in your datasets
obesity_df <- read.csv("2022-white.csv") 
poverty_df <- read.csv("poverty_state_grid_table.csv", skip = 3, header = TRUE)
nutrition <- read.csv("../final-project-brookedietmeier/Nutrition__Physical_Activity__and_Obesity_-_Behavioral_Risk_Factor_Surveillance_System.csv")

##hihihiajdslfk
nutrition <- nutrion %>% 
  filter(YearStart == 2020 | YearStart == 2021 | YearStart == 2022)

#keep all columns up to the one just before "Margin of Error"
poverty_df <- poverty_df %>%
              select(1:which(names(poverty_df) == "Margin.of.error1......") - 1)

obesity_df <- obesity_df %>%
             select(1:which(names(obesity_df) == "X95..CI") - 1)

#join poverty and obesity datasets
obesity_poverty_df <- inner_join(poverty_df, obesity_df, by = "State")

#rename column names to properly identify data in joined dataset 
obesity_poverty_df <- obesity_poverty_df %>% 
                      rename(`Poverty Rate` = Rate)

obesity_poverty_df <- obesity_poverty_df %>% 
                      rename(`Obesity Prevelance` = Prevalence)

#save unified dataset to a new file 
write.csv(obesity_poverty_df, "Unified_dataset.csv", row.names = FALSE)

