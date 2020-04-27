library(tidyverse)
library(plotly)
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(reshape2) #deprecated library
library(data.table)


jh_timeseries <- read_csv ("D:\\dev\\repos\\COVID-19\\csse_covid_19_data\\csse_covid_19_time_series\\time_series_covid19_confirmed_US.csv")
setnames(jh_timeseries, "Admin2", "County")

jh_ca <- filter(jh_timeseries, Province_State =="California" & County %in% c("San Francisco", 
                                                                              "San Mateo", 
                                                                              "Contra Costa",
                                                                              "Santa Clara",
                                                                              "Marin",
                                                                              "Alameda"))


jh_ca_melt <- reshape2::melt(jh_ca, id=c("County"), measure.vars=c("4/15/20","4/16/20","4/17/20","4/18/20","4/19/20","4/20/20","4/21/20",
                                                        "4/22/20","4/23/20","4/24/20","4/25/20","4/26/20"), variable.name="Date", value.name = "Confirmed")
jh_ca_melt$Date <- as.Date(jh_ca_melt$Date, format="%m/%d/%y")



g <- ggplot(jh_ca_melt, aes(x=Date)) + 
  geom_smooth( aes(y=Confirmed, color=County)) +
  scale_x_date(limits=as.Date(c("2020-04-15", Sys.Date()))) +
  labs(x = "Date", y = "Confirmed", 
       title = "Bay Area Daily Covid-19 Confirmed", subtitle = "Data from Johns Hopkins Project") +
  theme_ipsum()
 

ggplotly(g)