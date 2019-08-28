# --------------- #
# 0_data_wrangle #
# --------------- #

# ------------------------------------------
# DESC: loads, and cleans Excel data into suitable format for analysis
# SCRIPT DEPENDENCIES: none
# PACKAGE DEPENDENCIES:
# 1. 'readr' 
# 2. 'dplyr'
# 3. 'stringr'


# NOTES: none
# ------------------------------------------


# Data Import -------------------------------------------------------------
data_casualty <- read_csv(data = "data/Road_Collision_Casualties_In_Camden.csv")


# Data Wrangle ------------------------------------------------------------

columnnames_old <- colnames(data_casualties)
columnnames_new <- str_replace_all(string = columnnames_old, pattern = " ", replacement = "")

data_casualties_wrangled <- data_casualties %>% 
  # convert all string to factors to make plotting easier
  mutate_if(.predicate = is.character, .funs = factor) %>%
  # convert ID field to string
  mutate(Reference = as.character(Reference)) %>% 
  # rename columns to adhere to CamelCase
  rename_at(.vars = vars(columnnames_old), .funs = function(x) columnnames_new) %>% 
  # reduce columns to work with
  select(Reference:Location) %>% 
  # deal only with casualty data - is okay as NumberOfCasualties field is always 1
  filter(NumberOfCasualties == 1) %>% 
  # refactor Day to be in right order
  mutate(Day = recode_factor(Day,
                             `1` = "Monday",
                             `2` = "Tuesday",
                             `3` = "Wednesday",
                             `4` = "Thursday",
                             `5` = "Friday",
                             `6` = "Saturday",
                             `7` = "Sunday"))