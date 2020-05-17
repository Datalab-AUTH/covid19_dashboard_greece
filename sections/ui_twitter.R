body_twitter <- dashboardBody(
  tags$head(
    # don't display the hover box in wordclouds
    tags$style(HTML('div#wcLabel {display: none;}')),
  ),
  fluidRow(
    fluidRow(
      fluidRow(
        box(
          column(
            uiOutput("twitter_general_text"),
            width = 12,
            style = "padding: 10px; padding-left: 50px; padding-right: 50px"
          ),
          width = 12
        )
      ),
      fluidRow(
        box(
          title = "Δημοφιλή hashtags",
          wordcloud2Output("twitter_hashtags"),
          width = 6
        ),
        box(
          column(
            uiOutput("twitter_hashtags_text"),
            width = 12,
            style = "padding: 50px;"
          ),
          width = 6
        )
      ),
      fluidRow(
        box(
          title = "Hashtags ανά ημέρα",
          column(
            wordcloud2Output("twitter_hashtags_per_day"),
            width = 12
          ),
          column(
            sliderInput(
              "timeslider_twitter_hashtags",
              label      = "Επιλογή ημερομηνίας",
              min        = min(data_twitter_hashtags$date),
              max        = max(data_twitter_hashtags$date),
              value      = max(data_twitter_hashtags$date),
              width      = "100%",
              timeFormat = "%d.%m.%Y",
              animate    = animationOptions(interval = 2000, loop = TRUE)
            ),
            class = "slider",
            width = 12,
            style = 'padding-left:15px; padding-right:15px;'
          ),
          width = 6
        ),
        box(
          column(
            uiOutput("twitter_hashtags_per_day_text"),
            width = 12,
            style = "padding: 50px;"
          ),
          width = 6
        )
      ),
      fluidRow(
        box(
          title = "Tweets ανά ημέρα",
          plotlyOutput("twitter_tweets_per_day"),
          width = 6
        ),
        box(
          column(
            uiOutput("twitter_tweets_per_day_text"),
            width = 12,
            style = "padding: 50px;"
          ),
          width = 6
        )
      ),
      fluidRow(
        box(
          title = "Δημοφιλείς σύνδεσμοι",
          uiOutput("twitter_links_total"),
          width = 6
        ),
        box(
          column(
            uiOutput("twitter_links_total_text"),
            width = 12,
            style = "padding: 50px;"
          ),
          width = 6
        )
      )
    )
  )
)

page_twitter <- dashboardPage(
  title   = "Twitter",
  header  = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body    = body_twitter
)