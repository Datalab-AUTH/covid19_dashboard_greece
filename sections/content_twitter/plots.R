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
