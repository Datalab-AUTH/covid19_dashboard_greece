# ---- Loading libraries ----
library("shiny")
library("shinydashboard")
library("shinycssloaders")
library("tidyverse")
library("leaflet")
library("plotly")
library("DT")
library("countrycode")
library("wordcloud2")

source("utils.R", local = T)

updateData <- function() {
  changed_date <<- readRDS("data/changed_date.RDS")
  current_date <<- readRDS("data/current_date.RDS")
  data_greece_all <<- readRDS("data/data_greece_all.RDS")
  data_greece_cumulative <<- readRDS("data/data_greece_cumulative.RDS")
  data_greece_age_distribution <<- readRDS("data/data_greece_age_distribution.RDS")
  data_greece_age_averages <<- readRDS("data/data_greece_age_averages.RDS")
  data_greece_gender <<- readRDS("data/data_greece_gender.RDS")
  data_sandbird_cases <<- readRDS("data/data_sandbird_cases.RDS")
  data_sandbird_prefectures <<- readRDS("data/data_sandbird_prefectures.RDS")
  data_sandbird_map <<- readRDS("data/data_sandbird_map.RDS")
  data_greece_spdf <<- readRDS("data/greece_spdf.RDS")
  data_twitter_hashtags <<- readRDS("data/data_twitter_hashtags.RDS")
  data_twitter_hashtags_total <<- readRDS("data/data_twitter_hashtags_total.RDS")
  data_twitter_date_tweets <<- readRDS("data/data_twitter_date_tweets.RDS")
  data_twitter_links_total <<- readRDS("data/data_twitter_links_total.RDS")
  data_oxford <<- readRDS("data/data_oxford.RDS")
  data_greece_vaccines_total <<- read_csv("data/data_greece_vaccines_total.csv",
                                  col_types = cols(.default = "i", date = "D"))
}

updateData()
