output$measures <- renderPlotly({

  p <- vistime(data_measures,
               col.event = "blank",
               col.start = "date",
               col.end = "date",
               col.group = "category_el",
               show_labels = FALSE,
               col.tooltip = "event_el",
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

output$oxford_indices <- renderPlotly({
  
  p <- plot_ly(data = data_oxford,
               x = ~Date,
               y = ~value,
               color = ~name,
               type = 'scatter',
               mode = 'lines') %>%
    layout(
      xaxis = list(
        title = "Ημερομηνία",
        type = "date",
        tickformat = "%d/%m/%y"
      ),
      yaxis = list (
        title = "Τιμή"
      ),
      legend =  list(
        title = list(text = "<b>Δείκτης</b>")
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

output$measures_areas <- renderPlotly({
  data <- data_greece_areas$color %>%
    table() %>%
    as.data.frame()
  p <- plot_ly(
    data = data,
    y = ~Freq,
    x = ~.,
    type = 'bar',
    marker = list(
      color = map_pal(~color)
    )
  ) %>%
    layout(
      xaxis = list(title = "Επίπεδο μέτρων"),
      yaxis = list(title = "Αριθμός περιφερειών")
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

output$measures_areas_population <- renderPlotly({
  if (input$checkbox_measures_areas_population_pct) {
    p <- plot_ly(
      data = data_greece_areas_population,
      y = ~percent,
      x = ~level_text,
      type = 'bar',
      marker = list(
        color = c("#F6BC26", "#AC242A", "#605F69")
      )
    ) %>%
      layout(
        xaxis = list(title = "Επίπεδο μέτρων"),
        yaxis = list(title = "Ποσοστό πληθυσμού (%)")
      )
  } else {
    p <- plot_ly(
      data = data_greece_areas_population,
      y = ~pop_sum,
      x = ~level_text,
      type = 'bar',
      marker = list(
        color = c("#F6BC26", "#AC242A", "#605F69")
      )
    ) %>%
      layout(
        xaxis = list(title = "Επίπεδο μέτρων"),
        yaxis = list(title = "Πληθυσμός")
      )
  }

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
