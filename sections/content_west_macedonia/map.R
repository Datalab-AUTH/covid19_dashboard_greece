library("htmltools")

addLabel_west_macedonia <- function(data) {
  data$label <- paste0(
    '<b>', data$hospital_name_el, '</b><br>
    <table style="width:120px;">
    <tr><td>Νοσηλευόμενοι:</td><td align="right">', data$hospitalized_current, '</td></tr>
    <tr><td>Νοσηλευόμενοι (θετικοί):</td><td align="right">', data$hospitalized_positive, '</td></tr>
    <tr><td>Νοσηλευόμενοι (αρνητικοί):</td><td align="right">', data$hospitalized_negative, '</td></tr>
    <tr><td>Νοσηλευόμενοι σε αναμονή αποτελεσμάτων:</td><td align="right">', data$hospitalized_pending_result, '</td></tr>
    <tr><td>Σε κατ\'οίκον περιορισμό:</td><td align="right">', data$home_restriction_current, '</td></tr>
    <tr><td>Ελεγχοι δειγμάτων:</td><td align="right">', data$new_samples, '</td></tr>
    <tr><td>Εξιτήρια:</td><td align="right">', data$new_recoveries, '</td></tr>',
    '</table>'
  )
  data$label <- lapply(data$label, HTML)
  
  return(data)
}

map_west_macedonia <- leaflet(addLabel_west_macedonia(data_west_macedonia_hospitals)) %>%
  setMaxBounds(-180, -90, 180, 90) %>%
  setView(21.5, 40.45, zoom = 9) %>%
  addProviderTiles(providers$CartoDB.DarkMatter, group = "Dark") %>%
  addLayersControl(
    overlayGroups = c("Νοσηλευόμενοι",
                      "Νοσηλευόμενοι (θετικοί)",
                      "Νοσηλευόμενοι (αρνητικοί)",
                      "Νοσηλευόμενοι σε αναμονή αποτελεσμάτων",
                      "Σε κατ'οίκον περιορισμό",
                      "Έλεγχοι δειγμάτων",
                      "Εξιτήρια")
  ) %>%
  hideGroup("Νοσηλευόμενοι (θετικοί)") %>%
  hideGroup("Νοσηλευόμενοι (αρνητικοί)") %>%
  hideGroup("Νοσηλευόμενοι σε αναμονή αποτελεσμάτων") %>%
  hideGroup("Σε κατ'οίκον περιορισμό") %>%
  hideGroup("Έλεγχοι δειγμάτων") %>%
  hideGroup("Εξιτήρια") %>%
  addEasyButton(easyButton(
    icon    = "glyphicon glyphicon-globe", title = "Reset zoom",
    onClick = JS("function(btn, map){ map.setView([40.45, 21.5], 6); }")))

observe({
  req(input$timeslider_west_macedonia)
  zoomLevel <- input$overview_map_west_macedonia_zoom
  data <- data_west_macedonia_hospitals %>%
    filter(date == input$timeslider_west_macedonia) %>%
    addLabel_west_macedonia()
  req(data)
  
  if (nrow(data) > 0) {
    leafletProxy("overview_map_west_macedonia", data = data) %>%
      clearMarkers() %>%
      addCircleMarkers(
        lng          = ~Long,
        lat          = ~Lat,
        radius       = ~log((1.1 * hospitalized_current)^(zoomLevel * 1.5)),
        stroke       = FALSE,
        color        = "#386cb0",
        fillOpacity  = 0.5,
        label        = ~label,
        labelOptions = labelOptions(textsize = 20),
        group        = "Νοσηλευόμενοι"
      ) %>%
      addCircleMarkers(
        lng          = ~Long,
        lat          = ~Lat,
        radius       = ~log((1.5 * hospitalized_positive)^(zoomLevel)),
        stroke       = FALSE,
        color        = "#f0027f",
        fillOpacity  = 0.5,
        label        = ~label,
        labelOptions = labelOptions(textsize = 20),
        group        = "Νοσηλευόμενοι (θετικοί)"
      ) %>%
      addCircleMarkers(
        lng          = ~Long,
        lat          = ~Lat,
        radius       = ~log((1.5* hospitalized_negative)^(zoomLevel)),
        stroke       = FALSE,
        color        = "#ffff99",
        fillOpacity  = 0.5,
        label        = ~label,
        labelOptions = labelOptions(textsize = 20),
        group        = "Νοσηλευόμενοι (αρνητικοί)"
      ) %>%
      addCircleMarkers(
        lng          = ~Long,
        lat          = ~Lat,
        radius       = ~log((1.5 * hospitalized_pending_result)^(zoomLevel)),
        stroke       = FALSE,
        color        = "#fdc086",
        fillOpacity  = 0.5,
        label        = ~label,
        labelOptions = labelOptions(textsize = 20),
        group        = "Νοσηλευόμενοι σε αναμονή αποτελεσμάτων"
      ) %>%
      addCircleMarkers(
        lng          = ~Long,
        lat          = ~Lat,
        radius       = ~log((1.5 * home_restriction_current)^(zoomLevel)),
        stroke       = FALSE,
        color        = "#bf5b17",
        fillOpacity  = 0.5,
        label        = ~label,
        labelOptions = labelOptions(textsize = 20),
        group        = "Σε κατ'οίκον περιορισμό"
      ) %>%
      addCircleMarkers(
        lng          = ~Long,
        lat          = ~Lat,
        radius       = ~log((1.5 * new_samples)^(zoomLevel)),
        stroke       = FALSE,
        color        = "#beaed4",
        fillOpacity  = 0.5,
        label        = ~label,
        labelOptions = labelOptions(textsize = 20),
        group        = "Έλεγχοι δειγμάτων"
      ) %>%
      addCircleMarkers(
        lng          = ~Long,
        lat          = ~Lat,
        radius       = ~log((1.5 * new_recoveries)^(zoomLevel)),
        stroke       = FALSE,
        color        = "#7fc97f",
        fillOpacity  = 0.5,
        label        = ~label,
        labelOptions = labelOptions(textsize = 15),
        group        = "Εξιτήρια"
      )
  } else {
    leafletProxy("overview_map_west_macedonia", data = data) %>%
      clearMarkers()
  }
})

output$overview_map_west_macedonia <- renderLeaflet(map_west_macedonia)


