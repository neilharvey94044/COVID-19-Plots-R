# Uses data from the Covid Tracking Project to plot California's daily increase in confirmed Covid-19 cases
# Data is taken dynamically from https://covidtracking.com/api/v1/states/daily.csv

library(tidyverse)
library(plotly)
library(ggplot2)
library(dplyr)
library(hrbrthemes)

#cvt <- read_csv ("cvt_daily.csv", col_types = cols (date = "c"))
cvt <- read_csv (url("https://covidtracking.com/api/v1/states/daily.csv"), col_types = cols (date = "c"))
cvt$date <- as.Date(cvt$date,format="%Y%m%d")
glimpse(cvt)

cvt_ca <- cvt %>% filter(state=='CA')
data <- data.frame (cvt_ca$date,
			  cvt_ca$positiveIncrease)
glimpse(data)

p <- data %>%
  ggplot( aes(x=cvt_ca.date, y=cvt_ca.positiveIncrease)) +
    labs(y="Daily Positive Increase", x="Date") +
    geom_area(fill="#69b3a2", alpha=0.5) +
    geom_line(color="#69b3a2") +
    ggtitle("California Positive Daily Increase") +
    theme_ipsum()

ggplotly(p)


