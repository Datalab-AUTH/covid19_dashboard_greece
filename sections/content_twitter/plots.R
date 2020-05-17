output$twitter_hashtags <- renderWordcloud2({
  w <- data_twitter_hashtags_total %>%
    wordcloud2a(fontFamily = "Arial",
               color = "random-light",
               backgroundColor = "#444B55")
  return(w)
})

output$twitter_hashtags_per_day <- renderWordcloud2({
  w <- data_twitter_hashtags %>%
    filter(date == input$timeslider_twitter_hashtags) %>%
    select(-date) %>%
    wordcloud2a(fontFamily = "Arial",
                color = "random-light",
                backgroundColor = "#444B55")
  return(w)
})

output$twitter_tweets_per_day <- renderPlotly({
  p <- plot_ly(
    data = data_date_tweets,
    x = ~date,
    y = ~tweets,
    type = 'scatter',
    mode = 'lines',
    name = "Tweets"
  ) %>%
  layout(
    yaxis = list(title = "Αριθμός tweets", rangemode = "nonnegative"),
    xaxis = list(
      title = "Ημερομηνία",
      type = "date",
      tickformat = "%d/%m/%y"
    )
  )

  p <- layout(p,
              font = list(color = "#FFFFFF"),
              paper_bgcolor = "#444B55",
              plot_bgcolor = "#444B55",
              yaxis = list(
                zerolinecolor = "#666666",
                linecolor = "#999999",
                gridcolor = "#666666"
              ),
              xaxis = list(
                zerolinecolor = "#666666",
                linecolor = "#999999",
                gridcolor = "#666666"
              )
  )
  return(p)
})
