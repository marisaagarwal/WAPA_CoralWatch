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

  # temp_tempdata = templightdepth_data %>%
  #   filter(Variable == "Temp_C")
  
  
  # max daily temperatures
  daily_HOBO_temp_averages = 
    templightdepth_data %>%
      as_tibble() %>%
      filter(Variable == "Temp_C") %>%
      mutate(site = recode(Location, 
                           `Adelup Far LL` = "adelup", 
                           `Adelup LL` = "adelup",
                           `Agat LL` = "agat",
                           `Agat_Cluster_A_LL_` = "agat",
                           `Agat_Cluster_B_` = "agat", 
                           `Piti Outplant 10` = "asan", 
                           `Piti Outplant 20` = "asan",
                           `Piti Outplant 28` = "asan",
                           `Piti Outplant 50` = "asan",
                           `Hap's Reef #2` = "agat",
                           `Hap's Reef #3` = "agat",
                           `Piti LL` = "asan",
                           `Piti_LL_` = "asan",
                           `Adelup WL` = "adelup",
                           `Agat WL` = "agat",
                           `Piti WL` = "asan")) %>%
      dplyr::select(-c(SerialNo, Location)) %>%
      group_by(site, 
               date = floor_date(DateTime, "day")) %>%
      summarize(avg_temp = mean(Value))
      

## 3. Are the outplant loggers recording different temperatures?
  
  # run a unique GAM for each site
    outplant_temperature_models = 
      templightdepth_data %>%
        as.data.frame() %>%
        filter(Variable == "Temp_C") %>%
        filter(Location %in% c("Piti Outplant 10", "Piti Outplant 20",
                               "Piti Outplant 28", "Piti Outplant 50",
                               "Piti LL", "Piti_LL_")) %>%
        dplyr::select(-c(SerialNo, Variable)) %>%
        drop_na() %>%
        group_by(Location) %>%
        nest() %>%
        mutate(mod = map(.x = data,
                         .f = ~ gam(Value ~ s(as.numeric(DateTime)), 
                                    method = "REML", data = .x)))
    
        # how much of variation in data is explained by the gam?
          outplant_temperature_models %>%
                mutate(Rsquare_mod = map_dbl(mod, ~ summary(.)$r.sq))
          
        # access to other model outputs here: *unnest the column that has the info you want*
        outplant_temperature_models %>%
              mutate(tidy_mod = map(mod, tidy), 
                     glance_mod = map(mod, glance),
                     augment_mod = map(mod, augment)) %>%
              unnest(tidy_mod)
          



        
        
        
        
        
        
  
    