
key_figures_greece <- reactive({
  data <- data_greece_all %>%
    slice(n())
  data_yesterday <- data_greece_all %>%
    slice(n() - 1)
  
  data_diff <- list(
    confirmed = data$confirmed - data_yesterday$confirmed,
    deaths    = data$deaths - data_yesterday$deaths,
    icu       = data$icu - data_yesterday$icu,
    tests     = data$tests - data_yesterday$tests
  )
  
  data_new <- list(
    new_confirmed = data_diff$confirmed / data_yesterday$confirmed * 100,
    new_deaths    = data_diff$deaths / data_yesterday$deaths * 100,
    new_icu       = data_diff$icu / data_yesterday$icu * 100,
    new_tests     = data_diff$tests / data_yesterday$tests * 100
  )
  
  keyFigures <- list(
    "confirmed" = HTML(paste(format(data$confirmed, big.mark = " "), sprintf("<h4>%+i (%+.1f %%)</h4>", data_diff$confirmed, data_new$new_confirmed))),
    "deceased"  = HTML(paste(format(data$deaths, big.mark = " "), sprintf("<h4>%+i (%+.1f %%)</h4>", data_diff$deaths, data_new$new_deaths))),
    "icu"       = HTML(paste(format(data$icu, big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_icu))),
    "tests"     = HTML(paste(format(data$tests, big.mark = " "), sprintf("<h4>%+i (%+.1f %%)</h4>", data_diff$tests, data_new$new_tests))),
    "case_age"  = HTML(paste(format(data_greece_age_averages[["case"]], big.mark = " "), sprintf("<h4>έτη</h4>"))),
    "death_age" = HTML(paste(format(data_greece_age_averages[["death"]], big.mark = " "), sprintf("<h4>έτη</h4>"))),
    "date"      = data$date
  )
  
  if (is.infinite(data_new$new_icu)) keyFigures$icu = HTML(paste(format(data$icu, big.mark = " "), "<h4>(όλοι νέοι)</h4>"))
  if (data_new$new_confirmed == 0) keyFigures$confirmed = HTML(paste(format(data$confirmed, big.mark = " "), "<h4>(καμία αλλαγή)</h4>"))
  if (data_new$new_deaths == 0) keyFigures$deceased = HTML(paste(format(data$deaths, big.mark = " "), "<h4>(καμία αλλαγή)</h4>"))
  if (is.nan(data_new$new_icu) || data_new$new_icu == 0) keyFigures$icu = HTML(paste(format(data$icu, big.mark = " "), "<h4>(καμία αλλαγή)</h4>"))
  if (data_new$new_tests == 0) keyFigures$tests = HTML(paste(format(data$tests_new, big.mark = " "), "<h4>(καμία αλλαγή)</h4>"))

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
  div(
    "Τελευταία ενημέρωση: ", strftime(changed_date, format = "%d/%m/%Y - %R %Z. "),
    "Τα δεδομένα παρέχονται από την εθελοντική δράση για την αντιμετώπιση της πανδημίας",
    tags$a(href = "https://www.covid19response.gr/",
           "COVID-19 Response Greece.")
      ),
  width = 12
))
