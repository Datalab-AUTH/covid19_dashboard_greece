
key_figures_greece <- reactive({
  data <- data_greece_all %>%
    filter(date == max(date))
  data_yesterday <- data_greece_all %>%
    filter(date == max(date) - 1)
  
  data_sandbird <- data_sandbird_cases %>%
    filter(date == max(date))
  
  data_diff <- list(
    confirmed = data_sandbird$new_cases,
    deaths    = data_sandbird$new_deaths,
    icu       = data$icu - data_yesterday$icu,
    tests     = data_sandbird$new_tests
  )
  
  data_new <- list(
    new_icu       = data_diff$icu / data_yesterday$icu * 100
  )
  
  keyFigures <- list(
    "confirmed" = HTML(paste(format(data$confirmed, big.mark = " "), sprintf("<h4>%+i</h4>", data_diff$confirmed))),
    "deceased"  = HTML(paste(format(data$deaths, big.mark = " "), sprintf("<h4>%+i</h4>", data_diff$deaths))),
    "icu"       = HTML(paste(format(data$icu, big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_icu))),
    "tests"     = HTML(paste(format(data$tests, big.mark = " "), sprintf("<h4>%+i</h4>", data_diff$tests))),
    "case_age"  = HTML(paste(format(data_greece_age_averages[["case"]], big.mark = " "), sprintf("<h4>έτη</h4>"))),
    "death_age" = HTML(paste(format(data_greece_age_averages[["death"]], big.mark = " "), sprintf("<h4>έτη</h4>"))),
    "date"      = data_sandbird$date
  )
  
  if (is.infinite(data_new$new_icu)) keyFigures$icu = HTML(paste(format(data$icu, big.mark = " "), "<h4>(όλοι νέοι)</h4>"))
  if (is.nan(data_new$new_icu) || data_new$new_icu == 0) keyFigures$icu = HTML(paste(format(data$icu, big.mark = " "), "<h4>(καμία αλλαγή)</h4>"))

  return(keyFigures)
})

output$valueBox_greece_confirmed <- renderValueBox({
  valueBox(
    key_figures_greece()$confirmed,
    subtitle = "Επιβεβαιωμενα κρούσματα",
    icon     = icon("file-medical"),
    color    = "light-blue",
    width    = NULL
  )
})

output$valueBox_greece_deceased <- renderValueBox({
  valueBox(
    key_figures_greece()$deceased,
    subtitle = "Θάνατοι",
    icon     = icon("skull"),
    color    = "light-blue"
  )
})

output$valueBox_greece_icu <- renderValueBox({
  valueBox(
    key_figures_greece()$icu,
    subtitle = "Ασθενείς στη ΜΕΘ",
    icon     = icon("procedures"),
    color    = "light-blue"
  )
})

output$valueBox_greece_tests <- renderValueBox({
  valueBox(
    key_figures_greece()$tests,
    subtitle = "Έλεγχοι δειγμάτων",
    icon     = icon("vial"),
    color    = "light-blue"
  )
})

output$valueBox_greece_age_case <- renderValueBox({
  valueBox(
    key_figures_greece()$case_age,
    subtitle = "Μέση ηλικία ασθενών",
    icon     = icon("notes-medical"),
    color    = "light-blue"
  )
})

output$valueBox_greece_age_death <- renderValueBox({
  valueBox(
    key_figures_greece()$death_age,
    subtitle = "Μέση ηλικία θανόντων",
    icon     = icon("hospital"),
    color    = "light-blue"
  )
})

output$box_keyFigures_greece <- renderUI(box(
  title = paste0("Βασικά στοιχεία (", strftime(key_figures_greece()$date, format = "%d/%m/%Y"), ")"),
  fluidRow(
    column(
      valueBoxOutput("valueBox_greece_confirmed", width = 2),
      valueBoxOutput("valueBox_greece_deceased", width = 2),
      valueBoxOutput("valueBox_greece_icu", width = 2),
      valueBoxOutput("valueBox_greece_tests", width = 2),
      valueBoxOutput("valueBox_greece_age_case", width = 2),
      valueBoxOutput("valueBox_greece_age_death", width = 2),
      width = 12,
      style = "margin-left: -20px"
    )
  ),
  div("Τελευταία ενημέρωση: ", strftime(changed_date, format = "%d/%m/%Y - %R %Z. ")),
  width = 12
))
