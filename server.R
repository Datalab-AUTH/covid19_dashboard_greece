server <- function(input, output, session) {
  sourceDirectory("sections", recursive = TRUE)

  # Trigger once an hour
  dataLoadingTrigger <- reactiveTimer(3600000)
  
  observeEvent(dataLoadingTrigger, {
    updateData()
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
