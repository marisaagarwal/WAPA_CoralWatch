# 2022-02-09


## 1. Set up

  # point to data locale
  data_locale = "analysis_code/"
  
  # load in the data
  source(paste0(data_locale, "analyze_averagecolor.R"))

  
## 2. Plot average CoralWatch color through time
  
  # all data: loess model by site
  CoralWatch_data %>%
    ggplot(aes(date_time, colorcode_average)) +
    geom_point(aes(color = coral_type, shape = coral_type), alpha = 0.4) +
    geom_smooth(method = "loess", se = F) +
    facet_wrap(~site) +
    theme_light()
  
  # all data: linear trend by site & coral type
  CoralWatch_data %>%
    ggplot(aes(date_time, colorcode_average)) +
      geom_point(aes(color = coral_type, shape = coral_type), alpha = 0.4) +
      geom_smooth(method = "lm", aes(group = coral_type, color = coral_type), se = F) +
      facet_wrap(~site) +
      theme_light()
  
  # all data: boxplots with mean
    ggplot() +
      geom_boxplot(data = CoralWatch_data, 
                   aes(factor(date_time), colorcode_average),
                   alpha = 0.6) +
      geom_point(data = CoralWatch_data %>%
                          group_by(site, date_time) %>%
                          summarise(average_colorcode = mean(colorcode_average)),
                 aes(x = factor(date_time), y  = average_colorcode, 
                     color = "red"), show.legend = F) +
      geom_line(data = CoralWatch_data %>%
                        group_by(site, date_time) %>%
                        summarise(average_colorcode = mean(colorcode_average)),
                aes(x = factor(date_time), y  = average_colorcode, 
                    group = site,
                    color = "red"), show.legend = F) +
      facet_wrap(~site, ncol = 2) +
      theme_light() 
  
  # # averages from each survey: linear trend
  # CoralWatch_average_colorcodes %>%
    # ggplot(aes(date_time, average_colorcode)) +
    #   geom_point(aes(color = coral_type, shape = coral_type)) +
    #   geom_smooth(method = "lm", aes(group = coral_type, color = coral_type), se = F) +
    #   facet_wrap(~site) +
    #   theme_light()
    