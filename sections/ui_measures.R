body_measures <- dashboardBody(
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
  )
)

page_measures <- dashboardPage(
  title   = "Μέτρα",
  header  = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body    = body_measures
)
