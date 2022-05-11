# 2022-05-11


## 1. Set up

  # point to data locale
  data_locale = "analysis_code/"
  
  # load in HOBO data
  source(paste0(data_locale, "analyze_HOBOandNOAAtemps.R"))
  

## 2. Daily avg temp through time - all sites
  
  HOBOandNOAAtemps %>%
    # filter(!Location %in% c("Adelup WL")) %>%
    ggplot(aes(x = date)) +
      geom_point(aes(y = HOBO_average_daily_tempC), alpha = 0.25) +
      # geom_point(aes(y = HOBO_average_daily_tempC, 
      #            color = Location), 
      #            alpha = 0.25) +
      # geom_line(aes(y = HOBO_average_daily_tempC, color = Location)) +
      geom_line(aes(y = NOAA_SST_avg), color = "blue") +
      # geom_line(aes(y = NOAA_SST_max), color = "red") +
      # geom_line(aes(y = NOAA_SST_min), color = "purple") +
      theme_light()
  

## 3. Relationship between HOBO and NOAA temps
  
  HOBOandNOAAtemps %>%
    ggplot(aes(HOBO_average_daily_tempC, NOAA_SST_avg)) +
      geom_point(alpha = 0.1) +
      geom_abline(slope = 1, intercept = 0, color = "red") +
      xlim(24, 35) +
      ylim(24, 35) +
      labs(x = "HOBO Daily Average Temperature", 
           y = "NOAA Daily Average Temperature", 
           title = "2016-04 through 2021-09") +
      theme_light()
  
  

