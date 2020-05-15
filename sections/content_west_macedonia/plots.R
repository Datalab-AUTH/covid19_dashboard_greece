output$case_evolution_west_macedonia <- renderPlotly({
  data <- data_west_macedonia_total
  p <- plot_ly(data = data, x = ~date, y = ~active, type = 'scatter', mode = 'lines', name = "Ενεργά") %>%
    add_trace(data = data, x = ~date, y = ~confirmed, type = 'scatter', mode = 'lines', name = "Επιβεβαιωμένα") %>%
    add_trace(data = data, x = ~date, y = ~recoveries, type = 'scatter', mode = 'lines', name = "Αναρρώσεις") %>%
    add_trace(data = data, x = ~date, y = ~deaths, type = 'scatter', mode = 'lines', name = "Θάνατοι") %>%
    add_trace(data = data, x = ~date, y = ~icu, type = 'scatter', mode = 'lines', name = "ΜΕΘ") %>%
    layout(
      yaxis = list(title = "Αριθμός κρουσμάτων", rangemode = "nonnegative"),
      xaxis = list(
        title = "Ημερομηνία",
        type = "date",
        tickformat = "%d/%m/%y"
      )
    )
  
  if (input$checkbox_logCaseEvolution_west_macedonia) {
    p <- layout(p, yaxis = list(type = "log"))
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

output$hospitalized_west_macedonia <- renderPlotly({
  data <- data_west_macedonia_total
  p <- plot_ly(data = data, x = ~date, y = ~hospitalized_current, type = 'scatter', mode = 'lines', name = "Νοσηλευόμενοι") %>%
    add_trace(data = data, x = ~date, y = ~hospitalized_positive, type = 'scatter', mode = 'lines', name = "Νοσ/νοι (θετικοί)") %>%
    add_trace(data = data, x = ~date, y = ~hospitalized_negative, type = 'scatter', mode = 'lines', name = "Νοσ/νοι (αρνητικοί)") %>%
    add_trace(data = data, x = ~date, y = ~hospitalized_pending_result, type = 'scatter', mode = 'lines', name = "Νοσ/νοι (αναμονή αποτελεσμάτων)") %>%
    layout(
      yaxis = list(title = "Αριθμός", rangemode = "nonnegative"),
      xaxis = list(
        title = "Ημερομηνία",
        type = "date",
        tickformat = "%d/%m/%y"
      )
    )
  
  if (input$checkbox_logHospitalized_west_macedonia) {
    p <- layout(p, yaxis = list(type = "log"))
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

output$tests_west_macedonia <- renderPlotly({
  data <- data_west_macedonia_total
  p <- plot_ly(data = data, x = ~date, y = ~tests_new, type = 'bar', name = "Νέοι έλεγχοι δειγμάτων") %>%
    add_trace(data = data, x = ~date, y = ~tests, type = 'scatter', mode = 'lines', name = "Συνολικός αριθμός", yaxis = "y2") %>%
    layout(
      yaxis = list(title = "Έλεγχοι δειγμάτων", rangemode = "nonnegative"),
      yaxis2 = list(
        overlaying = "y",
        side = "right",
        title = "Συνολικός αριθμός δειγμάτων"
      ),
      xaxis = list(
        title = "Ημερομηνία",
        type = "date",
        tickformat = "%d/%m/%y"
      )
    )
  
  if (input$checkbox_log_tests_west_macedonia) {
    p <- layout(p, yaxis2 = list(type = "log"))
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


output$discharges_by_hospital_west_macedonia <- renderPlotly({
  data <- data_west_macedonia_hospitals
  
  p <- plot_ly(data = data, x = ~date, y = ~new_recoveries, color = ~hospital_name_el_short, type = 'bar') %>%
    layout(
      yaxis = list(title = "Αριθμός εξιτηρίων"),
      xaxis = list(
        title = "Ημερομηνία",
        type = "date",
        tickformat = "%d/%m/%y"
      ),
      legend = list(title=list(text='<b>Νοσοκομείο</b>'))
    )
  p <- layout(p,
              barmode = "stack",
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
  return (p)
})
