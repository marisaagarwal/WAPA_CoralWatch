# 2022-04-27

## 1. Set up

    # set working directory                     # if it doesn't work: Session > Set Working Directory > the WAPA_temperatures folder
    setwd("research/WAPA_temperatures") 
    
    # load in the data
    source("analysis_code/analyze_HOBOtempandlight.R")
    

## 2. Plotting all temperature data
    
    # all loggers
    templightdepth_data %>%
        filter(Variable == "Temp_C") %>%
        ggplot(aes(DateTime, Value)) +
            geom_point(alpha = 0.2) +
            scale_y_continuous(limits = c(15, 45)) +
            facet_wrap(~ Location) +
            theme_light()
    
    # piti outplants & clusters only
    templightdepth_data %>%
        filter(Location %in% c("Piti Outplant 10", "Piti Outplant 20",
                               "Piti Outplant 28", "Piti Outplant 50",
                               "Piti LL", "Piti_LL_")) %>%
        filter(Variable == "Temp_C") %>%
        ggplot(aes(DateTime, Value)) +
        geom_point(alpha = 0.1) +
        scale_y_continuous(limits = c(15, 45)) +
        facet_wrap(~ Location) +
        theme_light()
    
    templightdepth_data %>%
        filter(Location %in% c("Piti Outplant 10", "Piti Outplant 20",
                                "Piti Outplant 28", "Piti Outplant 50",
                               "Piti LL", "Piti_LL_")) %>%
        filter(Variable == "Temp_C") %>%
            ggplot(aes(DateTime, Value)) +
                geom_point(alpha = 0.1, aes(color = Location)) +
                # stat_smooth(method = "gam", aes(color = Location), se = F) +
                theme_light()
    
    
## 3. Plotting average daily temp
    
    # CoralNet sites
    templightdepth_data %>%
      filter(Variable == "Temp_C") %>%
      filter(!Location %in% c("Piti Outplant 10", "Piti Outplant 20",
                              "Piti Outplant 28", "Piti Outplant 50",
                              "Piti LL", "Piti_LL_", 
                              "Hap's Reef #2", "Hap's Reef #3")) %>%
        mutate(day = floor_date(DateTime, "day")) %>%
        group_by(Location, day) %>%
        summarize(avg_daily_temp = mean(Value)) %>%
      ggplot(aes(day, avg_daily_temp)) +
        geom_point(alpha = 0.05, aes(color = Location)) +
        stat_smooth(method = "gam", aes(color = Location), se = F) +
        facet_wrap(~Location) +
        theme_light() +
        theme(legend.position = "none")
    
    
    # Piti sites
    templightdepth_data %>%
      filter(Location %in% c("Piti Outplant 10", "Piti Outplant 20",
                             "Piti Outplant 28", "Piti Outplant 50",
                              "Piti_LL_", "Piti LL")) %>%
      filter(Variable == "Temp_C") %>%
        mutate(day = floor_date(DateTime, "day")) %>%
          group_by(Location, day) %>%
          summarize(avg_daily_temp = mean(Value)) %>%
      # filter(year(day) > 2019) %>%
      ggplot(aes(day, avg_daily_temp)) +
        geom_point(alpha = 0.1, aes(color = Location)) +
        stat_smooth(method = "gam", aes(color = Location), se = F) +
        theme_light()
    
    # Piti sites - only outplant loggers
    templightdepth_data %>%
      filter(Location %in% c("Piti Outplant 10", "Piti Outplant 20",
                             "Piti Outplant 28", "Piti Outplant 50")) %>%
      filter(Variable == "Temp_C") %>%
      mutate(day = floor_date(DateTime, "day")) %>%
      group_by(Location, day) %>%
      summarize(avg_daily_temp = mean(Value)) %>%
        ggplot(aes(day, avg_daily_temp)) +
          # geom_point(alpha = 0.1, aes(color = Location)) +
          stat_smooth(method = "gam", aes(color = Location), se = T) +
          theme_light()
      

    