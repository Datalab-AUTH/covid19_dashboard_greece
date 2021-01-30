body_plots <- dashboardBody(
  fluidRow(
    fluidRow(
      box(
        title = "Επιβεβαιωμένα κρούσματα",
        withSpinner(plotlyOutput("confirmed_greece")),
        column(
          checkboxInput("checkbox_log_confirmed_greece", label = "Άξονας Υ (Συνολικός αριθμός) σε λογαριθμική κλίμακα", value = FALSE),
          width = 4,
          style = "float: right; padding: 10px; margin-right: 50px"
        ),
        width = 6
      ),
      box(
        column(
          uiOutput("confirmed_greece_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
    fluidRow(
      box(
        title = "Θάνατοι",
        withSpinner(plotlyOutput("deaths_greece")),
        column(
          checkboxInput("checkbox_log_deaths_greece", label = "Άξονας Υ (Συνολικός αριθμός) σε λογαριθμική κλίμακα", value = FALSE),
          width = 4,
          style = "float: right; padding: 10px; margin-right: 50px"
        ),
        width = 6
      ),
      box(
        column(
          uiOutput("deaths_greece_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
    fluidRow(
      box(
        title = "Ασθενείς στις ΜΕΘ",
        withSpinner(plotlyOutput("icu_greece")),
        width = 6
      ),
      box(
        column(
          uiOutput("icu_greece_text"),
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
        title = "Εμβολιασμοί",
        withSpinner(plotlyOutput("vaccinations")),
        width = 6
      ),
      box(
        column(
          uiOutput("vaccinations_text"),
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
