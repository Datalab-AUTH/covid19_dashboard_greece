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
           tests = ifelse(date == "2020-04-15", 48798, tests))
    
  data_greece <- data_greece_all_parsed %>%
    merge(data_greece_ICU_parsed) %>%
    merge(data_greece_total_tests_parsed) %>%
    arrange(date) %>%
    as_tibble() %>%
    mutate(date = as.Date(date, format="%Y-%m-%d")) %>%
    mutate(
      active_new = active - lag(active, 1),
      confirmed_new = confirmed - lag(confirmed, 1),
      deaths_new = deaths - lag(deaths, 1),
      recovered_new = recovered -  lag(recovered, 1),
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
data_greece_geo <- read_csv("data/greece_geo_coordinates.csv")
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
    mutate(confirmed_new = confirmed - lag(confirmed, 1)) %>%
    mutate(
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
    rename("Gender" = "L1", "Percentage" = "value") %>%
    mutate(Gender = recode(Gender, "total_females" = "Γυναίκες", "total_males" = "Άνδρες"))
  saveRDS(data_greece_gender_parsed, "data/data_greece_gender.RDS")
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
    pluck("refugee-camps")
}
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
# West Macedonia
#
data_west_macedonia <- GET("https://covid-19-greece.herokuapp.com/western-macedonia")
if (data_west_macedonia["status_code"] == 200) {
  data_hospitals_geo <- read_csv("data/west_macedonia_hospital_geo_coordinates.csv")
  d <- data_west_macedonia %>%
    content(as="text", encoding = "UTF-8") %>%
    fromJSON() %>%
    pluck("western-macedonia")
  dates <- d %>%
    pluck("date") %>%
    enframe() %>%
    mutate(value = as.Date(value, format = "%Y-%m-%d")) %>%
    rename("date" = "value", "index" = "name")
  hospitals <- d %>%
    pluck("hospitals") %>%
    melt() %>%
    rename("index" = "L1") %>%
    merge(dates) %>%
    select(-index) %>%
    merge(data_hospitals_geo) %>%
    as_tibble() %>%
    group_by(hospital_name, variable) %>%
    arrange(hospital_name, variable, date) %>%
    spread(variable, value) %>%
    replace_na(
      list(
        home_restriction_current = 0,
        hospitalized_current = 0,
        hospitalized_positive = 0,
        hospitalized_negative = 0,
        hospitalized_pending_result = 0,
        new_recoveries = 0,
        new_samples = 0
      )
    )
  hospitals_summed <- hospitals %>%
    group_by(date) %>%
    summarise(
      home_restriction_current = sum(home_restriction_current, na.rm = TRUE),
      hospitalized_positive = sum(hospitalized_positive, na.rm = TRUE),
      hospitalized_current = sum(hospitalized_current, na.rm = TRUE),
      hospitalized_negative = sum(hospitalized_negative, na.rm = TRUE),
      hospitalized_pending_result = sum(hospitalized_pending_result, na.rm = TRUE),
      new_recoveries = sum(new_recoveries, na.rm = TRUE),
      new_samples = sum(new_samples, na.rm = TRUE)
    ) %>%
    rename("tests_new" = "new_samples") %>%
    ungroup()
  total <- d$total %>%
    mutate(index = rownames(d)) %>%
    merge(dates) %>%
    merge(hospitals_summed) %>%
    select(-index) %>%
    rename(
      "confirmed" = "total_samples_positive",
      "deaths" = "total_deaths",
      "tests" = "total_samples",
      "tests_negative" = "total_samples_negative",
      "icu" = "hospitalized_ICU_current"
    ) %>%
    mutate(
      recoveries = confirmed - hospitalized_current - home_restriction_current,
      active = confirmed - recoveries
    ) %>%
    as_tibble()
  saveRDS(hospitals, file = "data/data_west_macedonia_hospitals.RDS")
  saveRDS(total, file = "data/data_west_macedonia_total.RDS")
}

data_west_macedonia_deaths <- GET("https://covid-19-greece.herokuapp.com/western-macedonia-deaths")
if (data_west_macedonia_deaths["status_code"] == 200) {
  d <- data_west_macedonia_deaths %>%
    content(as="text", encoding = "UTF-8") %>%
    fromJSON() %>%
    pluck("western-macedonia-deaths") %>%
    select(-permanent_residence_municipality_gr) %>%
    rename("municipality" = "permanent_residence_municipality_en") %>%
    mutate(municipality = recode(municipality, 
                                 "dimos_grevenon" = "Γρεβενών",
                                 "dimos_deskatis" = "Δεσκάτης",
                                 "dimos_kastorias" = "Καστοριάς",
                                 "dimos_nestoriou" = "Νεστορίου",
                                 "dimos_orestidos" = "Ορεστίδος",
                                 "dimos_voiou" = "Βοΐου",
                                 "dimos_eordaias" = "Εορδαίας",
                                 "dimos_kozanis" = "Κοζάνης",
                                 "dimos_servion" = "Σερβίων",
                                 "dimos_velventou" = "Βελβεντού",
                                 "dimos_amintaiou" = "Αμυνταίου",
                                 "dimos_prespon" = "Πρεσπών",
                                 "dimos_florinas" = "Φλώρινας"
                          ),
           sex = recode(sex,
                        "male" = "Άνδρες",
                        "female" = "Γυναίκες"
                        )
    ) %>%
    as_tibble()
    saveRDS(d, file = "data/data_west_macedonia_deaths.RDS")
}
  
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
