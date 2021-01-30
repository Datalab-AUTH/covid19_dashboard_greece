#!/usr/bin/Rscript

# this script processes all data inputs (JHU, OECD, Oxford etc) and
# outputs RDS files that are ready to be consumed by the Shiny app.

library("tidyverse")
library("fs")
library("countrycode")
library("wbstats")
library("zoo")
library("httr")
library("reshape2")
library("jsonlite")
library("rgdal")
library("leaflet")

source("utils.R", local = T)

#
# Greece data from covid-19-greece project
#
data_greece_all <- GET("https://covid-19-greece.herokuapp.com/all")
data_greece_ICU <- GET("https://covid-19-greece.herokuapp.com/intensive-care")
data_greece_total_tests <- GET("https://covid-19-greece.herokuapp.com/total-tests")
if (data_greece_all["status_code"] == 200 &&
    data_greece_ICU["status_code"] == 200 &&
    data_greece_total_tests["status_code"] == 200) {
  data_greece_all_parsed <- data_greece_all %>%
    content(as="text", encoding = "UTF-8") %>%
    fromJSON() %>%
    first()
  data_greece_ICU_parsed <- data_greece_ICU %>%
    content(as="text", encoding = "UTF-8") %>%
    fromJSON() %>%
    first() %>%
    rename("icu" = "intensive_care") %>%
    fill(icu)
  data_greece_total_tests_parsed <- data_greece_total_tests %>%
    content(as="text", encoding = "UTF-8") %>%
    fromJSON() %>%
    first() %>%
    fill(tests) %>%
    mutate(tests = ifelse(is.na(tests), 0, tests),
           tests = ifelse(date == "2020-04-13", 43431, tests), # fix badly reported data
           tests = ifelse(date == "2020-04-14", 47389, tests),
           tests = ifelse(date == "2020-04-15", 48798, tests),
           tests = ifelse(date == "2020-06-03", 189750, tests), # these are bad due to underreporting
           tests = ifelse(date == "2020-06-05", 202719, tests), # for that week
           tests = ifelse(date == "2020-06-06", 211115, tests),
           tests = ifelse(date == "2020-06-07", 220659, tests),
           tests = ifelse(date == "2020-06-10", 237276, tests), # these two are swapped
           tests = ifelse(date == "2020-06-11", 240924, tests),
           tests = ifelse(date == "2020-06-24", 291840, tests), # these are swapped too
           tests = ifelse(date == "2020-06-25", 295639, tests),
           )
    
  data_greece <- data_greece_all_parsed %>%
    merge(data_greece_ICU_parsed) %>%
    merge(data_greece_total_tests_parsed) %>%
    arrange(date) %>%
    as_tibble() %>%
    mutate(date = as.Date(date, format="%Y-%m-%d")) %>%
    mutate(
      confirmed_new = confirmed - lag(confirmed, 1),
      confirmed_7day_mean = rollmean(confirmed_new, 7, fill = NA, align = "right"),
      deaths_new = deaths - lag(deaths, 1),
      icu_new = icu - lag(icu, 1) + deaths_new,
      tests_new = tests - lag(tests, 1)
    )
  saveRDS(data_greece, "data/data_greece_all.RDS")
}
data_greece_cumulative <- GET("https://covid-19-greece.herokuapp.com/total")
if (data_greece_cumulative["status_code"] == 200) {
  data_greece_cumulative_parsed <- data_greece_cumulative %>%
    content(as="text", encoding = "UTF-8") %>%
    fromJSON() %>%
    first()
  saveRDS(data_greece_cumulative_parsed, "data/data_greece_cumulative.RDS")
}
data_greece_geo <- read_csv("data/greece_geo_coordinates.csv", col_types = "cddi")
data_greece_region <- GET("https://covid-19-greece.herokuapp.com/regions")
if (data_greece_region["status_code"] == 200) {
  data_greece_region_parsed <- data_greece_region %>%
    content(as="text", encoding = "UTF-8") %>%
    fromJSON() %>%
    first() %>%
    rename("confirmed" = "region_cases") %>%
    merge(data_greece_geo) %>%
    mutate(confirmedPerCapita = round(100000 * confirmed / population, 2))
  saveRDS(data_greece_region_parsed, "data/data_greece_region.RDS")
}
data_greece_region_timeline <- GET("https://covid-19-greece.herokuapp.com/regions-history")
if (data_greece_region_timeline["status_code"] == 200) {
  data_greece_geo <- read_csv("data/greece_geo_coordinates.csv")
  d <- data_greece_region_timeline %>%
    content(as="text", encoding = "UTF-8") %>%
    fromJSON() %>%
    first()
  dates <- d %>%
    pluck("date") %>%
    enframe() %>%
    mutate(value = as.Date(value, format = "%Y-%m-%d")) %>%
    rename("date" = "value", "index" = "name")
  timeline <- d %>%
    pluck("regions") %>%
    melt() %>%
    filter(variable == "region_cases") %>%
    select(-variable) %>%
    merge(data_greece_geo) %>%
    rename(
      "region" = "region_en_name",
      "index" = "L1",
      "confirmed" = "value"
      ) %>%
    merge(dates) %>%
    select(-index) %>%
    group_by(region) %>%
    arrange(region) %>%
    mutate(
      confirmed_new = confirmed - lag(confirmed, 1),
      confirmed_7day_mean = rollmean(confirmed_new, 7, fill = NA, align = "right"),
      confirmedPerCapita = round(100000 * confirmed / population, 2),
      confirmedPerCapita_new = round(100000 * confirmed_new / population, 2)
    ) %>%
    as_tibble()
  saveRDS(timeline, "data/data_greece_region_timeline.RDS")
}
data_greece_age <- GET("https://covid-19-greece.herokuapp.com/age-distribution")
if (data_greece_age["status_code"] == 200) {
  data_greece_age_parsed <- data_greece_age %>%
    content(as="text", encoding = "UTF-8") %>%
    fromJSON() %>%
    first()
  data_greece_age_distribution <- data_greece_age_parsed$total_age_groups %>%
    melt() %>%
    rename("group" = "L2", "var" = "L1") %>%
    group_by(var) %>%
    mutate(pct = round(100 * value / sum(value), 2)) %>%
    ungroup()
  data_greece_age_averages <- c(case = data_greece_age_parsed$age_average,
                                death = data_greece_age_parsed$average_death_age)
  saveRDS(data_greece_age_distribution, "data/data_greece_age_distribution.RDS")
  saveRDS(data_greece_age_averages, "data/data_greece_age_averages.RDS")
}
data_greece_gender <- GET("https://covid-19-greece.herokuapp.com/gender-distribution")
if (data_greece_gender["status_code"] == 200) {
  data_greece_gender_parsed <- data_greece_gender %>%
    content(as="text", encoding = "UTF-8") %>%
    fromJSON() %>%
    first() %>%
    melt() %>%
    filter(L1 != "updated") %>%
    rename("Gender" = "L1", "Percentage" = "value") %>%
    mutate(Gender = recode(Gender, "total_females_percentage" = "Γυναίκες", "total_males_percentage" = "Άνδρες"),
           Percentage = as.numeric(Percentage))
  saveRDS(data_greece_gender_parsed, "data/data_greece_gender.RDS")
}

#
# data from SandBird github repo
# https://github.com/Sandbird/covid19-Greece
#
data_sandbird_cases <- read_csv("data/sandbird/cases.csv",
                                col_names = TRUE,
                                col_types = cols(.default = "i", date = "D")) %>%
  mutate(new_ag_tests = ag_tests - lag(ag_tests, 1),
         total_tests_pcr_ag = total_tests + ag_tests)
saveRDS(data_sandbird_cases, "data/data_sandbird_cases.RDS")

#
# map data from covid19.gov.gr
#
# Read in map data
greece_spdf <- readOGR( "data/greece_map/perif_enot/", encoding="cp1253")
greece_spdf_trans <- spTransform(greece_spdf, CRS("+proj=longlat +ellps=GRS80"))
saveRDS(greece_spdf_trans, "data/greece_spdf.RDS")

# color data for areas
color_data <- fromJSON("data/greece_map/data.json") %>%
  lapply(data.frame, stringsAsFactors = FALSE) %>%
  bind_rows() %>%
  rename("area" = "name1") %>%
  select(-"zip") %>%
  unique() %>%
  mutate(color = recode(color, "yellow" = 1, "red" = 2, "grey" = 3)) %>%
  add_row(area = "ΑΓΙΟ ΟΡΟΣ", color = 0)

area_names <- read_csv("data/area_names.csv", col_types = "cci")

areas <- data.frame(place = greece_spdf_trans$LEKTIKO,
                   id = greece_spdf_trans$KALCODE) %>%
  rename("area" = "place") %>%
  inner_join(color_data, by = "area") %>%
  inner_join(area_names, by = "area") %>%
  mutate(level = replace(color, color == 0, NA),
         level_text = recode(color,
                             `1` = "A. Επιτήρησης",
                             `2` = "B. Αυξημένου κινδύνου",
                             `3` = "Γ. Συναγερμού",
                             .default = "Δεν υφίσταται")) # for Agio Oros
saveRDS(areas, "data/greece_areas.RDS")

# prerendered map
outfile <- "data/greece_map/map.png"
outfile_size <- 1600
png(filename = outfile, width = outfile_size, height = outfile_size, bg = "transparent")
par(mar = c(0,0,0,0))
plot(greece_spdf_trans,
     col = map_pal(areas$color),
     bg = "#444B55")
dev.off()

areas_population <- areas %>%
  filter(!is.na(level)) %>%
  group_by(level_text) %>%
  summarise(pop_sum = sum(population), .groups = "drop") %>%
  mutate(percent = round(100 * (pop_sum / sum(pop_sum)), 1))
saveRDS(areas_population , "data/greece_areas_population.RDS")

#
# vaccines from data.gov.gr
#
date_vaccinations_start <- "2020-10-28"
date_now <- Sys.Date()
data_greece_vaccines <- GET(paste0(
  "https://data.gov.gr/api/v1/query/mdg_emvolio?date_from=",
  date_vaccinations_start,
  "&date_to=",
  date_now),
  add_headers(Authorization = Sys.getenv("DATAGOVGRTOKEN")))
if (data_greece_vaccines["status_code"] == 200) {
  data_greece_vaccines_parsed <- data_greece_vaccines %>%
    content(as="text", encoding = "UTF-8") %>%
    fromJSON() %>%
    mutate(date = as.Date(referencedate)) %>%
    select(-"referencedate")
  data_greece_vaccines_total <- data_greece_vaccines_parsed %>%
    group_by(date) %>%
    summarise(total_distinct_persons = sum(totaldistinctpersons),
              total_vaccinations = sum(totalvaccinations),
              .groups = "drop") %>%
    mutate(completed_both_doses = total_vaccinations - total_distinct_persons,
           new_vaccinations = total_vaccinations - lag(total_vaccinations, 1),
           new_distinct_persons = total_distinct_persons - lag(total_distinct_persons, 1),
           new_both_doses = completed_both_doses - lag(completed_both_doses, 1),
           new_both_doses_7days = rollsum(new_both_doses, k = 7, fill = NA, align = "right"))
  data_greece_vaccines_total$new_vaccinations[1] <- data_greece_vaccines_total$total_vaccinations[1]
  data_greece_vaccines_total$new_distinct_persons[1] <- data_greece_vaccines_total$total_distinct_persons[1]
  data_greece_vaccines_total$new_both_doses[1] <- data_greece_vaccines_total$completed_both_doses[1]
  write_csv(data_greece_vaccines_total, "data/data_greece_vaccines_total.csv")
}

#
# Update the dates
#
current_date <- max(data_greece_all$date) %>% format("%m/%d/%y")
changed_date <- Sys.time()
saveRDS(current_date, "data/current_date.RDS")
saveRDS(changed_date, "data/changed_date.RDS")

#
# Refugee Camps
#
data_refugee_camps <- GET("https://covid-19-greece.herokuapp.com/refugee-camps")
if (data_refugee_camps["status_code"] == 200) {
  d <- data_refugee_camps %>%
    content(as="text", encoding = "UTF-8") %>%
    fromJSON() %>%
    pluck("refugee-camps") %>%
    unnest(cols = c(recorded_events)) %>%
    separate(case_detection_week,
             into = c("week_start", "week_end"),
             sep = "-",
             remove = FALSE) %>%
    mutate(week_start = as.Date(week_start, format = "%d/%m/%Y"),
           week_end = as.Date(week_end, format = "%d/%m/%Y")) %>%
    filter(!is.na(confirmed_cases))
}
saveRDS(data_refugee_camps, "data/data_refugee_camps.RDS")
# TODO: is this trustworthy enough to use it?

#
# Government measures
#
data_measures <- GET("https://covid-19-greece.herokuapp.com/measures-timeline")
if (data_measures["status_code"] == 200) {
  d <- data_measures %>%
    content(as="text", encoding = "UTF-8") %>%
    fromJSON() %>%
    pluck("measures")
  d_impose <- d %>%
    pluck("imposition") %>%
    mutate(group = "impose", color = "#fc8d62")
  d_lift <- d %>%
    pluck("lifting") %>%
    mutate(group = "lift", color = "#a6d854")
  d <- d_impose %>%
    rbind(d_lift) %>%
    mutate(
      blank = "",
      category_el = str_trimmer(category_el, 20),
      event_el = paste0(event_el, " (", format(as.Date(date), format="%d/%m/%Y"), ")"),
      event_el = str_trimmer(event_el, 25)
    ) %>%
    arrange(category_el, date)
}
saveRDS(d, "data/data_measures.RDS")

# Oxford data for government actions (Greece only)
data_oxford <- read_csv("data/data_oxford.csv") %>%
  mutate(Date = as.Date.character(Date, format="%Y%m%d")) %>%
  select("Date", 
         "StringencyIndexForDisplay",
         "GovernmentResponseIndexForDisplay",
         "ContainmentHealthIndexForDisplay",
         "EconomicSupportIndexForDisplay" ) %>%
  filter(Date >= "2020-02-20") %>%
  rename("Αυστηρότητας" = "StringencyIndexForDisplay",
         "Κυβερνητική αντίδρασης" = "GovernmentResponseIndexForDisplay",
         "Περιορισμού και υγείας" = "ContainmentHealthIndexForDisplay",
         "Οικονομικής υποστήριξης" = "EconomicSupportIndexForDisplay") %>%
  pivot_longer(c("Αυστηρότητας",
                 "Κυβερνητική αντίδρασης",
                 "Περιορισμού και υγείας",
                 "Οικονομικής υποστήριξης"))
saveRDS(data_oxford, "data/data_oxford.RDS")
  
#
# Twitter
#
twitter_hashtags <- read_csv("data/twitter/dateTags.csv") %>%
  select(-total) %>%
  melt() %>%
  group_by(variable) %>%
  arrange(variable, -value) %>%
  rename(
    "date" = "variable",
    "number" = "value"
  ) %>%
  filter(Hashtags != "κορωνοιος") %>%
  filter(Hashtags != "COVID19greece") %>%
  filter(Hashtags != "covid19greece") %>%
  filter(Hashtags != "μενουμε_σπιτι") %>%
  filter(Hashtags != "μενουμεσπιτι") %>%
  filter(Hashtags != "κορονα") %>%
  filter(Hashtags != "κορονοϊος") %>%
  filter(Hashtags != "καραντινα") %>%
  filter(Hashtags != "εοδυ") %>%
  filter(Hashtags != "eody") %>%
  filter(Hashtags != "απαγορευση_κυκλοφοριας") %>%
  filter(Hashtags != "απαγορευσηκυκλοφοριας") %>%
  top_n(100) %>%
  filter(number > 0) %>%
  ungroup() %>%
  mutate(date = as.Date(date, format="%Y-%m-%d"))
saveRDS(twitter_hashtags, file = "data/data_twitter_hashtags.RDS")
twitter_hashtags_total <- read_csv("data/twitter/dateTags.csv") %>%
  select(Hashtags, total) %>%
  filter(Hashtags != "κορωνοιος") %>%
  filter(Hashtags != "COVID19greece") %>%
  filter(Hashtags != "covid19greece") %>%
  filter(Hashtags != "μενουμε_σπιτι") %>%
  filter(Hashtags != "μενουμεσπιτι") %>%
  filter(Hashtags != "κορονα") %>%
  filter(Hashtags != "κορονοϊος") %>%
  filter(Hashtags != "καραντινα") %>%
  filter(Hashtags != "εοδυ") %>%
  filter(Hashtags != "eody") %>%
  filter(Hashtags != "απαγορευση_κυκλοφοριας") %>%
  filter(Hashtags != "απαγορευσηκυκλοφοριας") %>%
  arrange(-total) %>%
  head(100)
saveRDS(twitter_hashtags_total, file = "data/data_twitter_hashtags_total.RDS")
data_twitter_date_tweets <- read_csv("data/twitter/dateTweets.csv") %>%
  rename(
    "date" = "Date",
    "tweets" = "DateValue"
  )
saveRDS(data_twitter_date_tweets, file = "data/data_twitter_date_tweets.RDS")

# function that transforms the links dataframe to an HTML numbered list
twitter_links_to_html <- function(d) {
  s <- "<ol>"
  for (row in 1:nrow(d)) {
    URL <- d[row, 1]
    number <- d[row, 2]
    title <- d[row, 3]
    shortURL <- d[row, 4]
    if (grepl("Î", title) || grepl("Ï", title)) {
      title <- shortURL
    }
    if (nchar(title) > 80) {
      title <- paste0(substr(title, 1, 80), "...")
    }
    if (row == 1) {
      font_size <- "xx-large"
    } else if (row == 2) {
      font_size <- "x-large"
    } else if (row == 3) {
      font_size <- "large"
    } else {
      font_size <- "medium"
    }
    s <- paste0(s, "<div style='font-size: ", font_size, "'><li><a href='", URL, "'>", title, "</a> (", shortURL, "). <em>", number, " αναφορές</em></li></div>")
  }
  s <- paste0(s, "</ol>")
  return(s)
}
data_twitter_links_total <- read_csv("data/twitter/links_total.csv") %>%
  rename("URL" = "Urls") %>%
  mutate(
    total = as.integer(total),
    shortURL = gsub("https://", "", URL),
    shortURL = gsub("http://", "", shortURL),
    shortURL = tolower(gsub("()/.*", "\\1", shortURL))
  ) %>%
  filter(URL != "http://naftemporiki.gr") %>%
  filter(URL != "http://WWW.10DECO.GR") %>%
  filter(URL != "http://MyVolos.Net") %>%
  filter(URL != "http://Libre.gr") %>%
  filter(URL != "http://Psts.gr") %>%
  arrange(-total) %>%
  top_n(10) %>%
  twitter_links_to_html()
saveRDS(data_twitter_links_total, file = "data/data_twitter_links_total.RDS")
