library(tidyverse)
library(plotly)
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(reshape2)

#cvt <- read_csv ("cvt_daily.csv", col_types = cols (date = "c"))
cvt <- read_csv (url("https://covidtracking.com/api/v1/states/daily.csv"), col_types = cols (date = "c"))
cvt$date <- as.Date(cvt$date,format="%Y%m%d")
cvt_ca_temp <- cvt %>% filter(state=='CA' & date > as.Date("2020-04-14"))
cvt_ca <- select(cvt_ca_temp, date,
                    positiveIncrease,
                    inIcuCurrently, 
                    deathIncrease)

cvt_melt <- melt(cvt_ca, id=c("date"), measure.vars = c("positiveIncrease", 
                                                        "inIcuCurrently", 
                                                        "deathIncrease"))

# this plot currently does not work as desired 4/24/2020
g <- ggplot(cvt_melt, aes(x=date)) + 
            geom_smooth( aes(y=value, color=variable)) +
             scale_x_date(limits=as.Date(c("2020-04-15", Sys.Date()))) +
            labs(x = "Date", y = "Daily Covid Values", 
                 title = "California Daily Covid-19 Numbers", subtitle = "Data from the Covid Tracking Project") +
            theme_ipsum()

ggplotly(g)