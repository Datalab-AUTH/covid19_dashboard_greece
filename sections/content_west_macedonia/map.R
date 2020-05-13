library("htmltools")

addLabel_west_macedonia <- function(data) {
  data$label <- paste0(
    '<b>', data$hospital_name_el, '</b><br>
    <table style="width:120px;">
    <tr><td>Νοσηλεύονται:</td><td align="right">', data$hospitalized_current, '</td></tr>
    <tr><td>Σε κατ\'οίκον περιορισμό:</td><td align="right">', data$home_restriction_current, '</td></tr>',
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
    overlayGroups = c("Νοσηλεύονται",
                      "Σε κατ'οίκον περιορισμό")
  ) %>%
  addEasyButton(easyButton(
    icon    = "glyphicon glyphicon-globe", title = "Reset zoom",
    onClick = JS("function(btn, map){ map.setView([38, 23], 6); }")))

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
        radius       = ~log(hospitalized_current^(zoomLevel / 2)),
        stroke       = FALSE,
        color        = "#0F7A82",
        fillOpacity  = 0.5,
        label        = ~label,
        labelOptions = labelOptions(textsize = 15),
        group        = "Νοσηλεύονται"
      ) %>%
      addCircleMarkers(
        lng          = ~Long,
        lat          = ~Lat,
        radius       = ~log(home_restriction_current^(zoomLevel)),
        stroke       = FALSE,
        color        = "#00b3ff",
        fillOpacity  = 0.5,
        label        = ~label,
        labelOptions = labelOptions(textsize = 15),
        group        = "Σε κατ'οίκον περιορισμό"
      )
  } else {
    leafletProxy("overview_map_west_macedonia", data = data) %>%
      clearMarkers()
  }
})

output$overview_map_west_macedonia <- renderLeaflet(map_west_macedonia)


