
library(dplyr)
library(stringr)

# Loads in your datasets
obesity_df <- read.csv("/Users/brookedietmeier/Desktop/Info_201_joining_datasets/final-project-brookedietmeier/2022-white.csv") 
poverty_df <- read.csv("/Users/brookedietmeier/Desktop/Info_201_joining_datasets/final-project-brookedietmeier/poverty_state_grid_table.csv", skip = 3, header = TRUE)
nutrition_df <- read.csv("/Users/brookedietmeier/Desktop/Info_201_joining_datasets/final-project-brookedietmeier/Nutrition__Physical_Activity__and_Obesity_-_Behavioral_Risk_Factor_Surveillance_System.csv")

##hihihiajdslfk
nutrition_df <- nutrition_df %>% 
  filter(YearStart == "2020" | YearStart == "2021" | YearStart == "2022")

#keep all columns up to the one just before "Margin of Error"
poverty_df <- poverty_df %>%
              select(1:which(names(poverty_df) == "Margin.of.error1......") - 1)

obesity_df <- obesity_df %>%
             select(1:which(names(obesity_df) == "X95..CI") - 1)

#change name of nutrition_df column from 'LocationDesc' to 'State'
nutrition_df <- nutrition_df %>% 
                rename(State = LocationDesc)

#join datasets
# First join poverty_df and obesity_df
temp_df <- inner_join(poverty_df, obesity_df, by = "State")

# Then join the result with nutrition_df
obesity_poverty_df <- inner_join(temp_df, nutrition_df, by = "State")


#rename column names to properly identify data in joined dataset 
obesity_poverty_df <- obesity_poverty_df %>% 
                      rename(`Poverty Rate` = Rate)

obesity_poverty_df <- obesity_poverty_df %>% 
                      rename(`Obesity Prevelance` = Prevalence)

#save unified dataset to a new file 
write.csv(obesity_poverty_df, "Unified_dataset.csv", row.names = FALSE)

