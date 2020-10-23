
output$confirmed_greece <- renderPlotly({
  data <- data_greece_all
  p <- plot_ly(data = data, x = ~date, y = ~confirmed_new, type = 'bar', name = "Νέα κρούσματα") %>%
    add_trace(data = data, x = ~date, y = ~confirmed, type = 'scatter', mode = 'lines', name = "Συνολικός αριθμός", yaxis = "y2") %>%
    layout(
      yaxis = list(title = "Νέα κρούσματα", rangemode = "nonnegative"),
      yaxis2 = list(
        overlaying = "y",
        side = "right",
        title = "Συνολικός αριθμός κρουσμάτων"
      ),
      xaxis = list(
        title = "Ημερομηνία",
        type = "date",
        tickformat = "%d/%m/%y"
      )
    )
  
  if (input$checkbox_log_confirmed_greece) {
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

output$deaths_greece <- renderPlotly({
  data <- data_greece_all
  p <- plot_ly(data = data, x = ~date, y = ~deaths_new, type = 'bar', name = "Νέοι θάνατοι") %>%
    add_trace(data = data, x = ~date, y = ~deaths, type = 'scatter', mode = 'lines', name = "Συνολικός αριθμός", yaxis = "y2") %>%
    layout(
      yaxis = list(title = "Νέοι θάνατοι", rangemode = "nonnegative"),
      yaxis2 = list(
        overlaying = "y",
        side = "right",
        title = "Συνολικός αριθμός θανάτων"
      ),
      xaxis = list(
        title = "Ημερομηνία",
        type = "date",
        tickformat = "%d/%m/%y"
      )
    )
  
  if (input$checkbox_log_deaths_greece) {
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

output$icu_greece <- renderPlotly({
  data <- data_greece_all
  p <- plot_ly(data = data, x = ~date, y = ~icu, type = 'scatter', mode = 'lines') %>%
    layout(
      yaxis = list(title = "Αριθμός ασθενών", rangemode = "nonnegative"),
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

output$tests_greece <- renderPlotly({
  data <- data_sandbird_cases
  p <- plot_ly(data = data, x = ~date, y = ~new_tests, type = 'bar', name = "Νέοι έλεγχοι δειγμάτων (RT-PCR)") %>%
    add_trace(data = data, x = ~date, y = ~new_ag_tests, type = 'bar', name = "Νέοι έλεγχοι Rapid Ag") %>%
    add_trace(data = data, x = ~date, y = ~total_tests, type = 'scatter', mode = 'lines', name = "Σύνολο RT-PCR", yaxis = "y2") %>%
    add_trace(data = data, x = ~date, y = ~ag_tests, type = 'scatter', mode = 'lines', name = "Σύνολο Rapid Ag", yaxis = "y2") %>%
    add_trace(data = data, x = ~date, y = ~total_tests_pcr_ag, type = 'scatter', mode = 'lines', name = "Γενικό σύνολο", yaxis = "y2") %>%
    layout(
      yaxis = list(title = "Έλεγχοι δειγμάτων", rangemode = "nonnegative"),
      yaxis2 = list(
        overlaying = "y",
        side = "right",
        title = "Συνολικός αριθμός δειγμάτων",
        rangemode = "nonnegative"
      ),
      xaxis = list(
        title = "Ημερομηνία",
        type = "date",
        tickformat = "%d/%m/%y"
      ),
      barmode = "stack"
    )
  
  if (input$checkbox_log_tests_greece) {
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

output$gender_greece <- renderPlotly({
  deaths <- data_greece_all %>%
    slice(n()) %>%
    pull(deaths)
  # this may not be completely accurate, but only available data is percentages
  # and total number of deaths
  data <- data_greece_gender %>%
    mutate(deaths = round({deaths} * Percentage / 100, 0))
  p <- plot_ly(data = data, labels = ~Gender, values = ~deaths, type = 'pie')
  
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

output$age_greece <- renderPlotly({
  req(input$age_var_greece)
  if (input$age_var_greece == "cases") {
    bar_color <- "#1F77B4"
  } else if (input$age_var_greece == "critical") {
    bar_color <- "#E78AC3"
  } else {
    bar_color <- "#FC8D62"
  }
  data <- data_greece_age_distribution %>%
    filter(var == input$age_var_greece)
  
  if (input$checkbox_age_pct_greece) {
    y_label <- "Ποσοστό"
    y_values <- data$pct
  } else {
    y_label <- "Αριθμός ατόμων"
    y_values <- data$value
  }
  
  p <- plot_ly(
              data = data,
              x = ~group,
              y = y_values,
              type = 'bar',
              marker = list(color = bar_color)
      ) %>%
      layout(
        xaxis = list(title = "Ηλικιακή ομάδα"),
        yaxis = list(title = y_label)
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

output$select_age_var_greece <- renderUI((
  selectizeInput(
    "age_var_greece",
    label = "Επιλογή μεταβλητής",
    choices = list("Επιβεβαιωμένα κρούσματα" = "cases", "Σε κρίσιμη κατάσταση" = "critical", "Θάνατοι" = "deaths"),
    selected = "cases",
    multiple = FALSE
  )
))