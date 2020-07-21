output$measures <- renderPlotly({

  p <- vistime(data_measures,
               events = "blank",
               start = "date",
               end = "date",
               groups = "category_el",
               show_labels = FALSE,
               tooltips = "event_el",
               background_lines = 0
               ) %>%
    layout(
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