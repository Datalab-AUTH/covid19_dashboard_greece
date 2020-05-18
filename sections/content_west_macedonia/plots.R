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

output$home_restriction_west_macedonia <- renderPlotly({
  data <- data_west_macedonia_hospitals
  
  p <- plot_ly(data = data, x = ~date, y = ~home_restriction_current, color = ~hospital_name_el_short, type = 'bar') %>%
    layout(
      yaxis = list(title = "Αριθμός ατόμων"),
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

output$select_west_macedonia_deaths_histogram_variable <- renderUI({
  selectizeInput(
    "select_west_macedonia_deaths_histogram_variable",
    label    = "Επιλογή φύλου",
    choices  = list("Και τα δύο" = "all",
                    "Άνδρες" = "Άνδρες",
                    "Γυναίκες" = "Γυναίκες"),
    multiple = FALSE
  )
})

output$deaths_histogram_west_macedonia <- renderPlotly({
  req(input$select_west_macedonia_deaths_histogram_variable)

  if (input$select_west_macedonia_deaths_histogram_variable == "all") {
    data <- data_west_macedonia_deaths
    bar_color <- "#7570b3"
  } else if (input$select_west_macedonia_deaths_histogram_variable == "Άνδρες") {
    data <- data_west_macedonia_deaths %>%
      filter(sex == "Άνδρες")
    bar_color <- "#d95f02"
  } else {
    data <- data_west_macedonia_deaths %>%
      filter(sex == "Γυναίκες")
    bar_color <- "#1b9e77"
  }

  p <- plot_ly(data = data, x = ~age, type = "histogram", marker = list(color = bar_color)) %>%
    layout(
      yaxis = list(title = "Αριθμός θανάτων"),
      xaxis = list(
        title = "Ηλικία"
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
  return (p)
})

output$deaths_age_west_macedonia <- renderPlotly({
  data <- data_west_macedonia_deaths %>%
    select(sex) %>%
    table() %>%
    as_tibble()
  p <- plot_ly(data = data, labels = ~., values = ~n, type = 'pie')
  
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

output$deaths_by_date_west_macedonia <- renderPlotly({
  data <- data_west_macedonia_deaths %>%
    group_by(date) %>%
    summarise(freq = n())
  p <- plot_ly(data = data, x = ~date, y = ~freq, type = 'bar', name = "Νοσηλευόμενοι") %>%
    layout(
      yaxis = list(title = "Αριθμός θανάτων", rangemode = "nonnegative"),
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