# 2022-04-27

## 1. Set up

  # set working directory                     # if it doesn't work: Session > Set Working Directory > the WAPA_temperatures folder
  setwd("research/WAPA_temperatures") 

  # load in the data
  source("creation_code/create_HOBOtempandlight.R")
  
  # check data structure
  str(light_data)
  str(water_data)
  str(templightdepth_data)
  
  
## 2. Summary items
  
  # min, max, mean temps --> **FIND where the bad data is!**
  templightdepth_data %>%
    # filter(Variable == "Temp_C") %>%
    group_by(Variable) %>% 
    summarize(min = min(Value, na.rm = T), 
              mean = mean(Value, na.rm = T),
              max = max(Value, na.rm = T))

  temp_tempdata = templightdepth_data %>%
    filter(Variable == "Temp_C")

  
## 3. Are the outplant loggers recording stat sig different temperatures?
  
  # want to run a unique gam for each site within the dataframe
  
    # current test, still not working!
    templightdepth_data %>%
      as_tibble() %>%
      filter(Variable == "Temp_C") %>%
      filter(Location %in% c("Piti Outplant 10", "Piti Outplant 20",
                             "Piti Outplant 28", "Piti Outplant 50",
                             "Piti LL", "Piti_LL_")) %>%
      nest(-Location) %>% 
      mutate(fit = map(data, ~ gam(Value ~ s(DateTime),
                                   method = "REML", data = .x)))

  