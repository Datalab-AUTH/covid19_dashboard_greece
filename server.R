server <- function(input, output, session) {
  sourceDirectory("sections", recursive = TRUE)

  # Trigger once an hour
  dataLoadingTrigger <- reactiveTimer(3600000)
  
  observeEvent(dataLoadingTrigger, {
    updateData()
  })
  
  # Greece overall
  observe({
    data_greece <- data_atDate_greece(input$timeslider_greece)
  })
  
  observe({
    updateSliderInput(
      session,
      "timeslider_greece",
      max = min(max(data_greece_region_timeline$date), max(data_greece_all$date)),
      value = min(max(data_greece_region_timeline$date), max(data_greece_all$date))
    )
  })
  
  # West Macedonia
  observe({
    data_west_macedonia <- data_atDate_west_macedonia(input$timeslider_west_macedonia)
  })

  observe({
    updateSliderInput(
      session,
      "timeslider_west_macedonia",
      max = max(data_west_macedonia_hospitals$date),
      value = max(data_west_macedonia_hospitals$date)
    )
  })
  
  # Twitter
  observe({
    updateSliderInput(
      session,
      "timeslider_twitter_hashtags",
      max = max(data_twitter_hashtags$date),
      value = max(data_twitter_hashtags$date)
    )
  })
  
  
  # URL Queries
  observe({
    query <- parseQueryString(session$clientData$url_search)
    if ("tab" %in% names(query)) {
      if (query$tab == "greece") {
        updateTabsetPanel(session, "navbar_set_panel", selected = "page-greece")
      } else if (query$tab == "plots") {
        updateTabsetPanel(session, "navbar_set_panel", selected = "page-plots")
      } else if (query$tab == "west-macedonia") {
        updateTabsetPanel(session, "navbar_set_panel", selected = "page-west-macedonia")
      } else if (query$tab == "measures") {
        updateTabsetPanel(session, "navbar_set_panel", selected = "page-measures")
      } else if (query$tab == "twitter") {
        updateTabsetPanel(session, "navbar_set_panel", selected = "page-twitter")
      } else if (query$tab == "about") {
        updateTabsetPanel(session, "navbar_set_panel", selected = "page-about")
      }
    }
  })
}
