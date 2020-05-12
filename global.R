# ---- Loading libraries ----
library("shiny")
library("shinydashboard")
library("tidyverse")
library("leaflet")
library("plotly")
library("DT")
library("countrycode")

source("utils.R", local = T)

updateData <- function() {
  changed_date <<- readRDS("data/changed_date.RDS")
  current_date <<- readRDS("data/current_date.RDS")
  data_greece_all <<- readRDS("data/data_greece_all.RDS")
  data_greece_cumulative <<- readRDS("data/data_greece_cumulative.RDS")
  data_greece_region <<- readRDS("data/data_greece_region.RDS")
  data_greece_region_timeline <<- readRDS("data/data_greece_region_timeline.RDS")
  data_greece_age_distribution <<- readRDS("data/data_greece_age_distribution.RDS")
  data_greece_age_averages <<- readRDS("data/data_greece_age_averages.RDS")
  data_greece_gender <<- readRDS("data/data_greece_gender.RDS")
  data_west_macedonia_hospitals <<- readRDS("data/data_west_macedonia_hospitals.RDS")
  data_west_macedonia_total <<- readRDS("data/data_west_macedonia_total.RDS")
}

updateData()
