# 2022-02-23



## 1. Load in data

  # point to data locale & load data --> NOAA data
  data_locale = "analysis_code/"
  source(paste0(data_locale, "analyze_NOAAdata.R"))
  
  # point to data locale & load data --> CoralWatch data
  data_locale = "analysis_code/"
  source(paste0(data_locale, "analyze_averagecolor.R"))

  
## 2. Prepare data
  
  # merge together avg colorcode & average SST
  monthly_color_and_SST = merge(monthly_color_averages, monthly_SST_averages)

  
## 3. Exploratory plotting
  
  # does trend in avg color code follow trend in SST?
  monthly_color_and_SST %>%
    ggplot(aes(x = month)) +
      geom_point(aes(y = monthly_avg_colorcode), 
                 color = "purple") +
      geom_line(data = monthly_SST_averages, 
                aes(x = month, y = avg_SST_max / 10),
                alpha = 0.6) +
      scale_y_continuous(name = "Avg colorcode", 
                         sec.axis = sec_axis(~.*10, name = "Monthly SST avg")) +
      facet_wrap(~site) +
      theme_light()
  
  # correlation between avg SST and avg bleaching level?
  monthly_color_and_SST %>%
    ggplot(aes(x = avg_SST_max, y = monthly_avg_colorcode)) +
      geom_point() +
      geom_smooth(method = "lm") +
      facet_wrap(~site) +
      theme_light()
  
  

  
  