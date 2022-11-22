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
      geom_smooth(method = "loess", se = T) +
      facet_wrap(~site, ncol = 1) +
      theme_light()
  
  # all data: trend by site & coral type (only branching and boulder)
  CoralWatch_data %>%
    mutate(site = recode(site, agat = "Agat", adelup = "Adelup", asan = "Asan")) %>%
    filter(coral_type %in% c("Boulder corals", "Branching corals")) %>%
    ggplot(aes(date_time, colorcode_average)) +
      geom_point(aes(color = coral_type, shape = coral_type), alpha = 0.4) +
      geom_smooth(method = "loess", aes(group = coral_type, color = coral_type), se = T) +
      scale_x_datetime(date_breaks = "year", date_labels = "%Y") +
      facet_wrap(~site, ncol = 1) +
      labs(x = "Date",
           y = "Color Score", 
           color = "Coral Type", shape = "Coral Type") +
      theme_light()
  
  CoralWatch_data %<>%
    mutate(site = recode(site, agat = "Agat", adelup = "Adelup", asan = "Asan"))
  
  # all data: boxplots & line plots
    ggplot() +
      # geom_boxplot(data = CoralWatch_data,
      #              aes(factor(date), colorcode_average,
      #                  color = bleaching_season),
      #              alpha = 0.4) +
      # scale_color_manual(values = c("blue", "red")) +
      geom_point(data = CoralWatch_data %>%
                          group_by(site, date) %>%
                          summarise(average_colorcode = mean(colorcode_average)),
                 aes(x = date, y  = average_colorcode), color = "green",
                 show.legend = F) +
      geom_point(data = CoralWatch_data %>%
                   group_by(site, date) %>%
                   summarise(average_lightcolorcode = mean(as.integer(lightcode_value))),
                 aes(x = date, y  = average_lightcolorcode), color = "light green",
                 show.legend = F) +
      geom_point(data = CoralWatch_data %>%
                           group_by(site, date) %>%
                           summarise(average_darkcolorcode = mean(as.integer(darkcode_value))),
                 aes(x = date, y  = average_darkcolorcode), color = "dark green",
                 show.legend = F) +
      geom_line(data = CoralWatch_data %>%
                        group_by(site, date) %>%
                        summarise(average_colorcode = mean(colorcode_average)),
                aes(x = date, y  = average_colorcode, group = site),
                color = "green",
                show.legend = F) +
      geom_line(data = CoralWatch_data %>%
                          group_by(site, date) %>%
                          summarise(average_lightcolorcode = mean(as.integer(lightcode_value))),
                aes(x = date, y = average_lightcolorcode, group = site),
                color = "light green",
                show.legend = F) +
      geom_line(data = CoralWatch_data %>%
                          group_by(site, date) %>%
                          summarise(average_darkcolorcode = mean(as.integer(darkcode_value))),
                aes(x = date, y = average_darkcolorcode, group = site),
                color = "dark green",
                show.legend = F) +
      facet_wrap(~site, ncol = 1) +
      labs(x = "Date", y = "Color Score", 
           title = "High, Average, and Low Coral Color Scores through Time",
           # title = "Distribution of Color Scores from CoralWatch Surveys", 
           # color = "Survey During \nBleaching Season?"
           )+
      scale_y_continuous(breaks = seq(1,6,by=1)) +
      scale_x_datetime(date_breaks = "year", date_labels = "%Y") +
      theme_light() +
      theme(axis.text.x = element_text(angle = 0))
      
  
  # # averages from each survey: linear trend
  # CoralWatch_average_colorcodes %>%
    # ggplot(aes(date_time, average_colorcode)) +
    #   geom_point(aes(color = coral_type, shape = coral_type)) +
    #   geom_smooth(method = "lm", aes(group = coral_type, color = coral_type), se = F) +
    #   facet_wrap(~site) +
    #   theme_light()
    
  #distribution of colors 
  darkcolor_distribution %>%
    mutate(site = recode(site, agat = "Agat", adelup = "Adelup", asan = "Asan")) %>%
    filter(site == "Adelup") %>%
    ggplot() +
      geom_bar(aes(x = factor(date), y = count_colorcode, 
                   fill = darkcode_value),
               stat = "identity", position = "fill") +
      scale_fill_brewer(palette = "YlOrBr") +
      theme_light() +
      labs(x = "Date", y = "Proportion of Corals",
           fill = "Color Score", 
           title = "Adelup") +
      theme(axis.text.x = element_text(angle = 90))
  
  
  
    