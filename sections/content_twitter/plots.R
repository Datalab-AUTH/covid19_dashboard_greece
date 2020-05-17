output$twitter_hashtags <- renderWordcloud2({
  w <- data_twitter_hashtags_total %>%
    wordcloud2a(fontFamily = "Arial",
               color = "random-light",
               backgroundColor = "#444B55")
  return(w)
})
