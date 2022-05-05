# 2022-02-23



## 1. Set up

  # point to data locale
  data_locale = "analysis_code/"
  
  # load in the data
  source(paste0(data_locale, "analyze_NOAAdata.R"))

  
## 2. Preliminary visualizations
  
  # daily SSTs (max, min, & 90th percentile heat stress)
  NOAA_data %>%
    ggplot(aes(x = date)) +
      # geom_line(aes(y = SST_MIN), color = "light blue") +
      # geom_line(aes(y = SST_MAX), color = "dark blue") +
      geom_line(aes(y = `SST@90th_HS`), color = "dark red") +
      geom_hline(yintercept = 30, lty = "dashed", color = "blue") +   # approx. bleaching threshold at 30C
      theme_light()

  # monthly mean SSTs 
  monthly_SST_averages %>%
    ggplot(aes(x = month)) +
      geom_line(aes(y = avg_SST_max), color = "dark grey") +
      geom_line(aes(y = avg_SST_min), color = "light grey") +
      # geom_line(aes(y = avg_SST90th_HS), color = "dark red") +
      geom_hline(yintercept = 30, lty = "dashed", color = "blue") +    # approx. bleaching threshold at 30C 
      theme_light()
  
  # SST anomalies
    ggplot() +
      geom_line(data = NOAA_data, 
                aes(x = date, y = `SSTA@90th_HS`),
                alpha = 0.4) +
      geom_line(data = monthly_SST_averages, 
                aes(x = month, y = avg_SSTA90th_HS), color = "blue") +
      theme_light()
    
  
  
  
  
  
  

  