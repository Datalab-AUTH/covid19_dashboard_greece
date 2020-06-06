body_west_macedonia <- dashboardBody(
  tags$head(
    tags$style(type = "text/css", "#overview_map_west_macedonia {height: 50vh !important;}"),
    tags$style(type = 'text/css', ".slider-animate-button { font-size: 20pt !important; }"),
    tags$style(type = 'text/css', ".slider-animate-container { text-align: left !important; }"),
    tags$style(type = "text/css", "@media (max-width: 991px) { .details { display: flex; flex-direction: column; } }"),
    tags$style(type = "text/css", "@media (max-width: 991px) { .details .map { order: 1; width: 100%; } }"),
    tags$style(type = "text/css", "@media (max-width: 991px) { .details .summary { order: 2; width: 100%; } }"),
    tags$style(type = "text/css", "@media (max-width: 991px) { .details .slider { order: 2; width: 100%; } }"),
    tags$style(type = 'text/css', ".row { background-color: #444b55; }"),
    tags$style(type = 'text/css', ".box { background-color: #444b55; border-top: 3px solid #444b55;}"),
    tags$style(type = 'text/css', ".content-wrapper { background-color: #444b55; }"),
    tags$style(type = 'text/css', ".bg-light-blue { background-color: #0F7A82 !important; }"),
    tags$style(type = 'text/css', ".irs-bar, .irs-bar-edge { border-top: 1px solid #0F7A82;
                                              border-bottom: 1px solid #0F7A82;
                                              background: #0F7A82;}"),
    tags$style(type = 'text/css', ".irs-min, .irs-max { color: #fff; }"),
    tags$style(type = 'text/css', ".irs-from, .irs-to, .irs-single { background: none; }"),
    tags$style(type = 'text/css', ".play { color: #0F7A82; }"),
    tags$style(type = 'text/css', ".pause { color: #0F7A82; }"),
    tags$style(type = 'text/css', "body { color: #fff; }")
  ),
  fluidRow(
    fluidRow(
      withSpinner(uiOutput("box_keyFigures_west_macedonia"))
    ),
    fluidRow(
      class = "details",
      column(
        box(
          width = 12,
          withSpinner(leafletOutput("overview_map_west_macedonia"))
        ),
        class = "map",
        width = 5,
        style = 'padding:0px;'
      ),
      column(
        withSpinner(uiOutput("summary_table_west_macedonia")),
        class = "summary",
        width = 7,
        style = 'padding:0px;'
      ),
      column(
        sliderInput(
          "timeslider_west_macedonia",
          label      = "Επιλογή ημερομηνίας",
          min        = min(data_west_macedonia_hospitals$date),
          max        = max(data_west_macedonia_hospitals$date),
          value      = max(data_west_macedonia_hospitals$date),
          width      = "100%",
          timeFormat = "%d.%m.%Y",
          animate    = animationOptions(interval = 1000, loop = TRUE)
        ),
        class = "slider",
        width = 12,
        style = 'padding-left:15px; padding-right:15px;'
      )
    ),
    fluidRow(
      box(
        title = "Εξέλιξη των κρουσμάτων",
        withSpinner(plotlyOutput("case_evolution_west_macedonia")),
        column(
          checkboxInput("checkbox_logCaseEvolution_west_macedonia", label = "Άξονας Υ σε λογαριθμική κλίμακα", value = FALSE),
          width = 4,
          style = "float: right; padding: 10px; margin-right: 50px"
        ),
        width = 6
      ),
      box(
        column(
          uiOutput("case_evolution_west_macedonia_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
    fluidRow(
      box(
        title = "Νοσηλευόμενοι",
        withSpinner(plotlyOutput("hospitalized_west_macedonia")),
        column(
          checkboxInput("checkbox_logHospitalized_west_macedonia", label = "Άξονας Υ σε λογαριθμική κλίμακα", value = FALSE),
          width = 4,
          style = "float: right; padding: 10px; margin-right: 50px"
        ),
        width = 6
      ),
      box(
        column(
          uiOutput("hospitalized_west_macedonia_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
    fluidRow(
      box(
        title = "Εξιτήρια",
        withSpinner(plotlyOutput("discharges_by_hospital_west_macedonia")),
        width = 6
      ),
      box(
        column(
          uiOutput("discharges_by_hospital_west_macedonia_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
    fluidRow(
      box(
        title = "Σε κατ'οίκον περιορισμό",
        withSpinner(plotlyOutput("home_restriction_west_macedonia")),
        width = 6
      ),
      box(
        column(
          uiOutput("home_restriction_west_macedonia_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
    fluidRow(
      box(
        title = "Έλεγχοι δειγμάτων COVID-19",
        withSpinner(plotlyOutput("tests_west_macedonia")),
        column(
          checkboxInput("checkbox_log_tests_west_macedonia", label = "Άξονας Υ (Συνολικός αριθμός) σε λογαριθμική κλίμακα", value = FALSE),
          width = 4,
          style = "float: right; padding: 10px; margin-right: 50px"
        ),
        width = 6
      ),
      box(
        column(
          uiOutput("tests_west_macedonia_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
    fluidRow(
      withSpinner(uiOutput("box_keyFigures_west_macedonia_deaths"))
    ),
    fluidRow(
      box(
        title = "Κατανομή θανάτων ανά φύλο",
        withSpinner(plotlyOutput("deaths_age_west_macedonia")),
        width = 6
      ),
      box(
        column(
          uiOutput("deaths_age_west_macedonia_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
    fluidRow(
      box(
        title = "Ηλικιακή κατανομή θανάτων (ιστόγραμμα)",
        withSpinner(plotlyOutput("deaths_histogram_west_macedonia")),
        width = 6,
        column(
          uiOutput("select_west_macedonia_deaths_histogram_variable"),
          width = 3
        ),
      ),
      box(
        column(
          uiOutput("deaths_histogram_west_macedonia_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
    fluidRow(
      box(
        title = "Ηλικιακή κατανομή θανάτων (θηκόγραμμα)",
        withSpinner(plotlyOutput("deaths_age_boxplot_west_macedonia")),
        width = 6,
      ),
      box(
        column(
          uiOutput("deaths_age_boxplot_west_macedonia_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
    fluidRow(
      box(
        title = "Θάνατοι ανά ημέρα",
        withSpinner(plotlyOutput("deaths_by_date_west_macedonia")),
        width = 6
      ),
      box(
        column(
          uiOutput("deaths_by_date_west_macedonia_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
    fluidRow(
      box(
        title = "Θάνατοι ανά Δήμο",
        withSpinner(plotlyOutput("deaths_by_municipality_west_macedonia")),
        width = 6
      ),
      box(
        column(
          uiOutput("deaths_by_municipality_west_macedonia_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    ),
  ),
  tags$style(type = 'text/css', ".nav-tabs-custom { background: #444b55; }"),
  tags$style(type = 'text/css', ".nav-tabs-custom > .nav-tabs > li > a {color: #fff;}"),
  tags$style(type = 'text/css', ".nav-tabs-custom .nav-tabs {border-bottom-color: #444b55; }
      .nav-tabs-custom .nav-tabs li {background: #2F333B; color: #fff;}
      .nav-tabs-custom .nav-tabs li a {color: #fff;}
      .nav-tabs-custom .nav-tabs li.active {border-top-color: #0F7A82;}
      .nav-tabs-custom .nav-tabs li.active a {background: #0F7A82; color: #fff;}
      label {color: #fff; }
      .nav-tabs-custom .tab-content {background: #444b55;}
      table.dataTable.stripe tbody tr.odd, table.dataTable.display tbody tr.odd {background-color: #444b55;}
             table.dataTable.stripe tbody tr.even, table.dataTable.display tbody tr.even {background-color: #2F333B;}
      table.dataTable tr.selected { color: #000 }
      .legend {color: #fff; }"),
  tags$style(type = 'text/css', ".leaflet-control-layers-expanded { background: #444b55; }"),
  tags$style(type = 'text/css', ".selectize-control.multi .selectize-input div { background: #0F7A82; color: #fff;}")
)

page_west_macedonia <- dashboardPage(
  title   = "Δυτ. Μακεδονία",
  header  = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body    = body_west_macedonia
)
