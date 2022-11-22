# 2022-02-23



## 1. Load in data

  # point to data locale & load data --> NOAA data
  data_locale = "analysis_code/"
  source(paste0(data_locale, "analyze_NOAAdata.R"))
  
  # point to data locale & load data --> NOAA data
  data_locale = "analysis_code/"
  source(paste0(data_locale, "analyze_HOBOtempandlight.R"))
  
  # point to data locale & load data --> CoralWatch data
  data_locale = "analysis_code/"
  source(paste0(data_locale, "analyze_averagecolor.R"))

  
## 2. Prepare data
  
  # merge together monthly avg colorcode & monthly average NOAA SST
  monthly_color_and_NOAASST = merge(monthly_color_averages, monthly_SST_averages)
  
  # merge together avg colorcodes & daily average NOAA SST
  color_and_dailyNOAASST = merge(CoralWatch_data %>%
                               dplyr::select(c("site", "date", "colorcode_average",
                                               "coral_type", "bleaching_season")),
                             daily_NOAA_SST_averages)
  
  # merge together avg colorcodes & daily average HOBO temp
  color_and_dailyHOBOtemp = merge(CoralWatch_data %>%
                                   dplyr::select(c("site", "date", "colorcode_average",
                                                   "coral_type", "bleaching_season")),
                                  daily_HOBO_temp_averages)
  
  
## 3. Plotting
  
  # does trend in avg color code follow trend in NOAA SST?
  monthly_color_and_NOAASST %>%
    ggplot(aes(x = month)) +
      geom_point(aes(y = monthly_avg_colorcode), 
                 color = "purple") +
      geom_line(data = monthly_SST_averages, 
                aes(x = month, y = avg_SST_max / 10),
                alpha = 0.6) +
      scale_y_continuous(name = "Avg colorcode", 
                         sec.axis = sec_axis(~.*10, name = "Monthly SST avg")) +
      facet_wrap(~site, ncol = 1) +
      theme_light()
  
  # correlation between avg NOAA SST and avg color?
  monthly_color_and_NOAASST %>%
    ggplot(aes(x = avg_SST_max, y = monthly_avg_colorcode)) +
      geom_point() +
      geom_smooth(method = "lm") +
      facet_wrap(~site) +
      theme_light()
  
  color_and_dailyNOAASST %>%
    mutate(site = recode(site, agat = "Agat", adelup = "Adelup", asan = "Asan")) %>%
    filter(!coral_type == "Plate corals") %>%
      ggplot(aes(x = avg_SST_max, y = colorcode_average)) +
        geom_point(aes(color = coral_type), alpha = 0.35) +
        geom_smooth(method = "lm", color = "black") +
        facet_grid(coral_type~site) +
        labs(x = "Maximum Daily SST (from NOAA)",
             y = "Average Coral Color Score") +
        theme_light() +
        theme(legend.position = "none")

  # correlation between daily avg HOBO temp and avg color?
  color_and_dailyHOBOtemp %>%
    mutate(site = recode(site, agat = "Agat", adelup = "Adelup", asan = "Asan")) %>%
    filter(!coral_type == "Plate corals") %>%
      ggplot(aes(x = avg_temp, y = colorcode_average)) +
        geom_point(aes(color = coral_type), alpha = 0.35) +
        geom_smooth(method = "lm", color = "black") +
        facet_grid(coral_type~site) +
        labs(x = "Maximum Daily Temperature (from HOBO loggers)",
             y = "Average Coral Color Score") +
        theme_light() +
        theme(legend.position = "none")
  


  
  