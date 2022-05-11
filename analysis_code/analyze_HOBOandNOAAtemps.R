# 2022-05-11


## 1. Set up

  # point to data locale
  data_locale = "creation_code/"
  
  # load in HOBO data
  source(paste0(data_locale, "create_HOBOtempandlight.R"))
  
  # load in NOAA data
  source(paste0(data_locale, "create_NOAAdata.R"))

  
## 2. Format data
  
  # summarize HOBO data by day
  daily_HOBO_temps = 
    templightdepth_data %>%
      filter(Variable == "Temp_C") %>%
      group_by(Location) %>%
      pivot_wider(names_from = Variable, values_from = Value, values_fn = "mean") %>%
    group_by(Location, 
             date = floor_date(DateTime, "day")) %>%
    summarise(HOBO_average_daily_tempC = mean(Temp_C))

  # rename NOAA data columns
  daily_NOAA_temps = 
    NOAA_data %>%
      as_tibble() %>%
      dplyr::select(c("SST_MIN", "SST_MAX", "date", "BAL")) %>%
      rename(NOAA_SST_min = SST_MIN,
             NOAA_SST_max = SST_MAX) %>%
      mutate(NOAA_SST_avg = ((NOAA_SST_min + NOAA_SST_max) / 2))
  
  
## 3. Merge data frames together by date
  
  HOBOandNOAAtemps = merge(daily_HOBO_temps, daily_NOAA_temps)
  
    
  

  
  
  
  
  