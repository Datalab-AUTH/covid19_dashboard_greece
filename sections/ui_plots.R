body_plots <- dashboardBody(

)

page_plots <- dashboardPage(
  title   = "Γραφήματα",
  header  = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body    = body_plots
)
