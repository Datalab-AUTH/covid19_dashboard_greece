body_greece <- dashboardBody(
  tags$head(
    tags$style(type = "text/css", "#overview_map_greece {height: 50vh !important;}"),
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
    tags$style(type = 'text/css', "body { color: #fff; }")
  ),
  fluidRow(
    fluidRow(
      withSpinner(uiOutput("box_keyFigures_greece"))
    ),
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

page_greece <- dashboardPage(
  title   = "Ελλάδα",
  header  = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body    = body_greece
)
