body_greece <- dashboardBody(
  tags$head(
    tags$style(type = "text/css", "#overview_map_greece {height: 95vh !important;}"),
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
    tags$style(type = "text/css", ".info.legend.leaflet-control { color: #222 !important; }"),
    tags$style(type = 'text/css', "body { color: #fff; }")
  ),
  fluidRow(
    fluidRow(
      withSpinner(uiOutput("box_keyFigures_greece"))
    ),
    fluidRow(
      class = "details",
      column(
        box(
          width = 12,
          withSpinner(leafletOutput("overview_map_greece"))
        ),
        class = "map",
        width = 7,
        style = 'padding:0px;'
      ),
      column(
        withSpinner(uiOutput("summary_table_greece")),
        class = "summary",
        width = 5,
        style = 'padding:0px;'
      )
    )
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
