body_measures <- dashboardBody(
  fluidRow(
    fluidRow(
      box(
        title = "Δείκτες λήψης μέτρων",
        withSpinner(plotlyOutput("oxford_indices")),
        width = 6
      ),
      box(
        column(
          uiOutput("oxford_indices_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    )
  ),
  fluidRow(
    box(
      title = "Επίπεδο προληπτικών μέτρων",
      withSpinner(plotlyOutput("measures_areas")),
      width = 6
    ),
    box(
      column(
        uiOutput("measures_areas_text"),
        width = 12,
        style = "padding: 50px;"
      ),
      width = 6
    )
  ),
  fluidRow(
    box(
      title = "Επίπεδο προληπτικών μέτρων σε σχέση με τον πληθυσμό",
      withSpinner(plotlyOutput("measures_areas_population")),
      width = 6,
      column(
        checkboxInput("checkbox_measures_areas_population_pct", label = "Εμφάνιση ποσοστών", value = FALSE),
        width = 3,
        style = "float: right; padding: 10px; margin-right: 50px"
      )
    ),
    box(
      column(
        uiOutput("measures_areas_population_text"),
        width = 12,
        style = "padding: 50px;"
      ),
      width = 6
    )
  ),
  fluidRow(
    fluidRow(
      box(
        title = "Λήψη/Απελευθέρωση μέτρων",
        withSpinner(plotlyOutput("measures")),
        width = 6
      ),
      box(
        column(
          uiOutput("measures_text"),
          width = 12,
          style = "padding: 50px;"
        ),
        width = 6
      )
    )
  ),
)

page_measures <- dashboardPage(
  title   = "Μέτρα",
  header  = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body    = body_measures
)
