# Plots the Johns Hopkins Covid-19 time series for california 
# confirmed cases for all California counties.
# The data was obtained from https://github.com/CSSEGISandData/COVID-19.git

library(tidyverse)
library(plotly)
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(reshape2)
library(data.table)


jh_timeseries <- read_csv ("D:\\dev\\repos\\COVID-19\\csse_covid_19_data\\csse_covid_19_time_series\\time_series_covid19_confirmed_US.csv")

jh_ca <- filter(jh_timeseries, Province_State =="California")

jh_ca_melt <- melt(jh_ca, id=c("Admin2"), measure.vars=c("4/15/20","4/16/20","4/17/20","4/18/20","4/19/20","4/20/20","4/21/20",
                                                        "4/22/20","4/23/20"), variable.name="Date", value.name = "Confirmed")
jh_ca_melt$Date <- as.Date(jh_ca_melt$Date, format="%m/%d/%y")
setnames(jh_ca_melt, "Admin2", "County")


g <- ggplot(jh_ca_melt, aes(x=Date)) + 
  geom_smooth( aes(y=Confirmed, color=County)) +
  scale_x_date(limits=as.Date(c("2020-04-15", Sys.Date()))) +
  labs(x = "Date", y = "Confirmed", 
       title = "California Daily Covid-19 Confirmed", subtitle = "Data from Johns Hopkins Project") +
  theme_ipsum() +
  geom_label(
    label="Los Angeles County!!", 
    x=as.Date(c("2020-04-19")),
    y=15000,
    label.padding = unit(0.55, "lines"), # Rectangle size around label
    label.size = 0.35,
    color = "black",
    fill="#69b3a2"
  )

show(g)