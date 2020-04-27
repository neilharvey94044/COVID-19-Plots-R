# Plots daily increases for California, New York, and the entire US.
# Data is taken dynamically from the Covid Tracking Project
# https://covidtracking.com/api/v1/states/daily.csv

library(tidyverse)
library(plotly)
library(ggplot2)
library(dplyr)
library(hrbrthemes)

#cvt <- read_csv ("cvt_daily.csv", col_types = cols (date = "c"))
cvt <- read_csv (url("https://covidtracking.com/api/v1/states/daily.csv"), col_types = cols (date = "c"))
cvt$date <- as.Date(cvt$date,format="%Y%m%d")
cvt_newpos <- select(cvt, date, state, positiveIncrease)

cvt_ca <- cvt_newpos %>% filter(state=='CA')
cvt_ny <- cvt_newpos %>% filter(state=='NY')

cvt_us <- cvt_newpos %>% 
  group_by(date) %>% 
  summarise(positiveIncrease = sum(positiveIncrease), state = 'US')
cvt_us_ca_ny <- rbind(cvt_us, cvt_ca, cvt_ny)


g <- ggplot() + 
            geom_point(data=cvt_us_ca_ny,  aes(x=date, y=positiveIncrease, col=state)) +
            geom_smooth(data=cvt_ny, aes(x=date, y=positiveIncrease, color="NY")) +
            geom_smooth(data=cvt_ca, aes(x=date, y=positiveIncrease, color="CA")) +
            geom_smooth(data=cvt_us, aes(x=date, y=positiveIncrease, color="US")) +
            scale_x_date(limits=as.Date(c("2020-03-01", Sys.Date()))) +
            labs(x = "Date", y = "Daily Covid Positive Increase", 
                 title = "Daily Covid-19 Positive Increase", subtitle = "Data from the Covid Tracking Project") +
            theme_ipsum()

ggplotly(g)