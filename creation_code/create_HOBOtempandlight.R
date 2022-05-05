# 2022-04-27
# updated with data as of 2022-04-27
# data prep workflow (#1) created by Ashton Williams


## 1. Set up

  # call to path 
  setwd("data/HOBO Logger Data")

  # create lists of file names 
      # water level
      loggerfilelist.wl = grep(list.files(path = ".", 
                                          pattern = "*WL*"), 
                                          pattern = c("m_*"), 
                                          invert = TRUE, 
                                          value = TRUE) %>% 
                          print(.)
      # light level
      loggerfilelist.ll = grep(list.files(path = "."), 
                                          pattern = c("m_*"), 
                                          invert = TRUE, 
                                          value = TRUE) %>% 
                          grep(., 
                               pattern = c("*WL*"), 
                               invert = TRUE, 
                               value = TRUE) %>% 
                          print(.)

      
  # melt logger data into file names
      #create function 
        # light level 
        logger.melter.ll = function(filename) {
          newfile = read_csv(file = filename, skip = 2,
                              col_names = c("X.", "DateTime", "Temp_C", "Intensity_Lux")) %>%
            subset(., select = -c(X.)) %>%
            mutate(SerialNo = rm_between(filename, "(",")",extract = TRUE),
                   Location = rm_between(filename, " [", ".csv", extract = FALSE)) %>%
            melt(., id.vars = c("SerialNo", "Location", "DateTime"), measure.vars = c("Temp_C", "Intensity_Lux"),
                 variable.name = "Variable", value.name = "Value")
          accesspath = paste(getwd(), "/m_", sep = "")
          write_csv(newfile, paste(accesspath, filename, ".csv", sep = ""))
        }
        # water level
        logger.melter.wl = function(filename) {
          newfile = read_csv(file = filename, skip = 2,
                              col_names = c("X.", "DateTime", "Abs_Pressure", "Temp_C")) %>%
            subset(., select = -c(X.)) %>%
            mutate(SerialNo = rm_between(filename, "(",")",extract = TRUE),
                   Location = rm_between(filename, " [", ".csv", extract = FALSE)) %>%
            melt(., id.vars = c("SerialNo", "Location", "DateTime"), measure.vars = c("Temp_C", "Abs_Pressure"),
                 variable.name = "Variable", value.name = "Value")
          accesspath = paste(getwd(), "/m_", sep = "")
          write_csv(newfile, paste(accesspath, filename, ".csv", sep = ""))
        }      
        
      # apply function to files and put into lists
        # light level
        light_data = lapply(loggerfilelist.ll, logger.melter.ll)
        
        # water level
        water_data = lapply(loggerfilelist.wl, logger.melter.wl)
      

## 2. Tidy & beautify data
        
  # un-list the data & converting to data frame
      # light
      light_data = map(light_data, as.data.frame)
      light_data = rbindlist(light_data)
      as.data.frame(light_data)
      
      # water level 
      water_data = map(water_data, as.data.frame)
      water_data = rbindlist(water_data)
      as.data.frame(water_data)
      
  # check and reassign column data types
    # light
      str(light_data)
      
      light_data = 
        light_data %>%
          mutate(SerialNo = as.integer(SerialNo),
                 Variable = as.character(Variable),
                 Value = as.double(Value),
                 DateTime = mdy_hms(DateTime, tz = "Pacific/Guam"))
      
      # water level
      str(water_data)
      
      water_data = 
        water_data %>%
          mutate(SerialNo = as.integer(SerialNo),
                 Variable = as.character(Variable),
                 Value = as.double(Value),
                 DateTime = mdy_hms(DateTime, tz = "Pacific/Guam"))
        
  # combine the light and water depth data frames
  templightdepth_data = rbind(light_data, water_data)

  # recode logger labels for redundant sites
  templightdepth_data$Location = 
    recode(templightdepth_data$Location, 
           "Piti Outplants Tag 10" = "Piti Outplant 10",
           "Piti Outplants Tag 20" = "Piti Outplant 20",
           "Piti Outplants Tag 28" = "Piti Outplant 28",
           "Piti Outplants Tag 50" = "Piti Outplant 50", 
           "Asan_Outplant_20_" = "Piti Outplant 20",
           "Asan_Outplant_28_" = "Piti Outplant 28",
           "Asan_Outplant_10_" = "Piti Outplant 10")
      
      
    
## LEARNING/PRACTICE WITH STR_EXTRACT 
#  temp_file_names = 
#    list.files(path = "data/2022-04-26 HOBO Logger Download/test",
#               pattern = ".csv", ) %>%
#     as_tibble() %>%
#     rename(file_name = value) %>%
#     mutate(site = str_extract(file_name,"(\\w+)"),
#            logger_code = str_extract(file_name,"[0-9]{8}"), 
#            sampling_type = str_extract(file_name, "([:upper:]){2}"))
