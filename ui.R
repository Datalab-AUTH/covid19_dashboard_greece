library("shinythemes")

source("sections/ui_about.R", local = TRUE)
source("sections/ui_greece.R", local = TRUE)
source("sections/ui_plots.R", local = TRUE)
source("sections/ui_twitter.R", local = TRUE)

datalab_logo_html <- '<div style="float:left">
                       <a href="https://datalab.csd.auth.gr/">
                       <img id="logo" src="datalab_logo.png" alt="Datalab"
                          style="float:left;width:48px;padding-top:10px;margin-top:-25px;margin-right:10px">
                       </a>
                       <span style="font-weight: bold">CovidDEXP Ελλάδα</span>
                       </div>'

csd_auth_logos_html <- '\'<div style="float:right"><img id="csd_auth_logos" src="csd_auth_logos.png" alt="School of Informatics, Aristotle University of Thessaloniki" usemap="#logosmap" style="float:right;margin-top:-50px;margin-right:-10px"></div><map name="logosmap"><area shape="rect" coords="63,1,108,46" alt="School of Informatics" href="https://www.csd.auth.gr"><area shape="rect" coords="124,1,169,46" alt="Aristotle University of Thessaloniki" href="https://www.auth.gr/"></map>\''

ui <- fluidPage(
  theme = shinytheme("cyborg"),
  title = "CovidDEXP - Εξερεύνηση δεδομένων σχετικά με τον COVID-19 στην Ελλάδα",
  tags$head(
    tags$link(rel = "shortcut icon", type = "image/png", href = "datalab_logo.png"),
    tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Roboto&display=swap"),
    tags$style(
      HTML('.wrapper {height: auto !important; position:relative; overflow-x:hidden; overflow-y:hidden}')
      ),
    includeHTML("google-analytics.html")
  ),
  tags$style(type = "text/css", "@media (max-width: 760px) { #csd_auth_logos { display: none; } }"),
  tags$style(type = "text/css", ".container-fluid {padding-left: 0px; padding-right: 0px !important;}"),
  tags$style(type = "text/css", ".navbar {margin-bottom: 0px;}"),
  tags$style(type = "text/css", ".content {padding: 0px;}"),
  tags$style(type = "text/css", ".row {margin-left: 0px; margin-right: 0px;}"),
  tags$style(HTML(".col-sm-12 { padding: 5px; margin-bottom: -15px; }")),
  tags$style(HTML(".col-sm-6 { padding: 5px; margin-bottom: -15px; }")),
  tags$style(HTML("input { color: #FFFFFF; background: #444B55; background-color: #444B55 }")),
  tags$style(HTML(".selectized { background-color: #444B55 }")),
  tags$style(HTML(".selectize-control { background: #444B55; background-color: #444B55 }")),
  tags$style(HTML(".selectize-control * { background: #444B55; background-color: #444B55 }")),
  tags$style(HTML(".selectize-control.single { background: #444B55; background-color: #444B55 }")),
  tags$style(HTML(".selectize-input { color: #FFFFFF; background: #444B55; background-color: #444B55 }")),
  tags$style(HTML(".selectize-input * { color: #FFFFFF; background: #444B55; background-color: #444B55 }")),
  tags$style(HTML(".selectize-input.full { color: #FFFFFF; background: #444B55; background-color: #444B55 }")),
  tags$style(HTML(".selectize-input.input-active { color: #FFFFFF; background: #444B55; background-color: #444B55 !important }")),
  tags$style(HTML(".selectize-dropdown-content { color: #FFFFFF; background: #444B55; background-color: #444B55 }")),
  tags$style(HTML(".leaflet-tooltip { color: #FFFFFF; background-color: #181818}")),
  navbarPage(
    title       = div(HTML(datalab_logo_html), style = "padding-left: 10px"),
    id          = "navbar_set_panel",
    collapsible = TRUE,
    fluid       = TRUE,
    tabPanel("Συνοπτικά", page_greece, value = "page-greece"),
    tabPanel("Γραφήματα", page_plots, value = "page-plots"),
    tabPanel("Twitter", page_twitter, value = "page-twitter"),
    
    tabPanel(HTML("Σχετικά με την ιστοσελίδα</a></li>
                  <li>
                  <a href='https://covid19.csd.auth.gr' target='_blank' style='padding-top:10px;padding-bottom:8px'>
                  <img src='world.png'
                  alt='Κόσμος'>"), page_about, value = "page-about"),
    tags$script(HTML(paste0("var header = $('.navbar > .container-fluid');",
      "header.append(",
      csd_auth_logos_html,
      ")"))
    )
  )
)
