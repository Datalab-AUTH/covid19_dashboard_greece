body_plots <- dashboardBody(
  fluidRow(
    fluidRow(
      box(
        title = "Εξέλιξη των κρουσμάτων",
        withSpinner(plotlyOutput("case_evolution_greece")),
        column(
          checkboxInput("checkbox_logCaseEvolution_greece", label = "Άξονας Υ σε λογαριθμική κλίμακα", value = FALSE),
          width = 4,
          style = "float: right; padding: 10px; margin-right: 50px"
        ),
        width = 6
      ),
      box(
        column(
          uiOutput("case_evolution_greece_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
    fluidRow(
      box(
        title = "Νέα κρούσματα",
        withSpinner(plotlyOutput("cases_per_day_greece")),
        width = 6
      ),
      box(
        column(
          uiOutput("cases_per_day_greece_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
    fluidRow(
      box(
        title = "Έλεγχοι δειγμάτων COVID-19",
        withSpinner(plotlyOutput("tests_greece")),
        column(
          checkboxInput("checkbox_log_tests_greece", label = "Άξονας Υ (Συνολικός αριθμός) σε λογαριθμική κλίμακα", value = FALSE),
          width = 4,
          style = "float: right; padding: 10px; margin-right: 50px"
        ),
        width = 6
      ),
      box(
        column(
          uiOutput("tests_greece_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
    fluidRow(
      box(
        title = "Ηλικιακή κατανομή",
        withSpinner(plotlyOutput("age_greece")),
        column(
          uiOutput("select_age_var_greece"),
          width = 4,
        ),
        column(
          checkboxInput("checkbox_age_pct_greece", label = "Εμφάνιση ποσοστών", value = FALSE),
          width = 3,
          style = "float: right; padding: 10px; margin-right: 50px"
        ),
        width = 6
      ),
      box(
        column(
          uiOutput("age_greece_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
    fluidRow(
      box(
        title = "Κατανομή φύλων",
        withSpinner(plotlyOutput("gender_greece")),
        width = 6
      ),
      box(
        column(
          uiOutput("gender_greece_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    )
  )
)

page_plots <- dashboardPage(
  title   = "Γραφήματα",
  header  = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body    = body_plots
)
