
key_figures_west_macedonia <- reactive({
  data <- data_west_macedonia_total %>%
    slice(n())
  data_yesterday <- data_west_macedonia_total %>%
    slice(n() - 1)

  data_new <- list(
    new_confirmed = (data$confirmed - data_yesterday$confirmed) / data_yesterday$confirmed * 100,
    new_active    = (data$active - data_yesterday$active) / data_yesterday$active * 100,
    new_recovered = data$new_recoveries / (data$recoveries - data$new_recoveries) * 100,
    new_deaths    = (data$deaths - data_yesterday$deaths) / data_yesterday$deaths * 100,
    new_icu       = (data$icu - data_yesterday$icu) / data_yesterday$icu * 100,
    new_tests     = data$tests_new / (data$tests - data$tests_new) * 100,
    new_home      = (data$home_restriction_current - data_yesterday$home_restriction_current) / data_yesterday$home_restriction_current * 100,
    new_hospital  = (data$hospitalized_current - data_yesterday$hospitalized_current) / data_yesterday$hospitalized_current * 100
  )
  
  keyFigures <- list(
    "confirmed" = HTML(paste(format(data$confirmed, big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_confirmed))),
    "active"    = HTML(paste(format(data$active, big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_active))),
    "recovered" = HTML(paste(format(data$recoveries, big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_recovered))),
    "deceased"  = HTML(paste(format(data$deaths, big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_deaths))),
    "icu"       = HTML(paste(format(data$icu, big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_icu))),
    "tests"     = HTML(paste(format(data$tests, big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_tests))),
    "home"      = HTML(paste(format(data$home_restriction_current, big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_home))),
    "hospital"  = HTML(paste(format(data$hospitalized_current, big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_home))),
    "date"      = data$date
  )
  return(keyFigures)
})

output$valueBox_west_macedonia_confirmed <- renderValueBox({
  valueBox(
    key_figures_west_macedonia()$confirmed,
    subtitle = "Επιβεβαιωμενα κρούσματα",
    icon     = icon("file-medical"),
    color    = "light-blue",
    width    = NULL
  )
})

output$valueBox_west_macedonia_active <- renderValueBox({
  valueBox(
    key_figures_west_macedonia()$active,
    subtitle = "Ενεργά κρούσματα",
    icon     = icon("stethoscope"),
    color    = "light-blue",
    width    = NULL
  )
})

output$valueBox_west_macedonia_recovered <- renderValueBox({
  valueBox(
    key_figures_west_macedonia()$recovered,
    subtitle = "Αναρρώσεις",
    icon     = icon("heart"),
    color    = "light-blue"
  )
})

output$valueBox_west_macedonia_home <- renderValueBox({
  valueBox(
    key_figures_west_macedonia()$home,
    subtitle = "Σε κατ'οίκον περιορισμό",
    icon     = icon("home"),
    color    = "light-blue"
  )
})

output$valueBox_west_macedonia_hospital <- renderValueBox({
  valueBox(
    key_figures_west_macedonia()$hospital,
    subtitle = "Νοσηλευόμενοι",
    icon     = icon("hospital"),
    color    = "light-blue",
    width    = NULL
  )
})

output$valueBox_west_macedonia_deceased <- renderValueBox({
  valueBox(
    key_figures_west_macedonia()$deceased,
    subtitle = "Θάνατοι",
    icon     = icon("skull"),
    color    = "light-blue"
  )
})

output$valueBox_west_macedonia_icu <- renderValueBox({
  valueBox(
    key_figures_west_macedonia()$icu,
    subtitle = "Ασθενείς στη ΜΕΘ",
    icon     = icon("procedures"),
    color    = "light-blue"
  )
})

output$valueBox_west_macedonia_tests <- renderValueBox({
  valueBox(
    key_figures_west_macedonia()$tests,
    subtitle = "Έλεγχοι δειγμάτων",
    icon     = icon("vial"),
    color    = "light-blue"
  )
})

output$valueBox_west_macedonia_age_case <- renderValueBox({
  valueBox(
    key_figures_west_macedonia()$case_age,
    subtitle = "Μέση ηλικία επιβεβαιωμένων κρουσμάτων",
    icon     = icon("notes-medical"),
    color    = "light-blue"
  )
})

output$valueBox_west_macedonia_age_death <- renderValueBox({
  valueBox(
    key_figures_west_macedonia()$death_age,
    subtitle = "Μέση ηλικία θανάτων",
    icon     = icon("hospital"),
    color    = "light-blue"
  )
})

output$box_keyFigures_west_macedonia <- renderUI(box(
  title = paste0("Βασικά στοιχεία (", strftime(key_figures_west_macedonia()$date, format = "%d/%m/%Y"), ")"),
  fluidRow(
    column(
      valueBoxOutput("valueBox_west_macedonia_confirmed", width = 3),
      valueBoxOutput("valueBox_west_macedonia_active", width = 3),
      valueBoxOutput("valueBox_west_macedonia_recovered", width = 3),
      valueBoxOutput("valueBox_west_macedonia_deceased", width = 3),
      width = 12,
      style = "margin-left: -20px"
    )
  ),
  fluidRow(
    column(
      valueBoxOutput("valueBox_west_macedonia_icu", width = 3),
      valueBoxOutput("valueBox_west_macedonia_hospital", width = 3),
      valueBoxOutput("valueBox_west_macedonia_home", width = 3),
      valueBoxOutput("valueBox_west_macedonia_tests", width = 3),
      width = 12,
      style = "margin-left: -20px"
    )
  ),
  div(
    "Τελευταία ενημέρωση: ", strftime(changed_date, format = "%d/%m/%Y - %R %Z. "),
    "Τα δεδομένα παρέχονται από την εθελοντική δράση για την αντιμετώπιση της πανδημίας",
    tags$a(href = "https://www.covid19response.gr/",
           "COVID-19 Response Greece"),
    "σε συνεργασία με την",
    tags$a(href = "https://www.pdm.gov.gr/",
           "Περιφέρεια Δυτικής Μακεδονίας.")
      ),
  width = 12
))
