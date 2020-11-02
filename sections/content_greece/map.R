
greece_map <- leaflet() %>% 
  addProviderTiles(providers$CartoDB.DarkMatter, group = "Dark") %>%
  setView(24.3, 38.2, zoom = 7) %>%
  addPolygons(data = data_greece_spdf,
              stroke = TRUE, color = "black", weight = 1,
              smoothFactor = 1, fillOpacity = 0.7,
              fillColor = ~map_pal(data_greece_areas$color),
              popup = paste("<b>", data_greece_spdf$LEKTIKO, "</b><br>",
                            "Επίπεδο: ", data_greece_areas$level_text, "<br>")) %>%
  addLegend(position = "bottomleft", values = data_greece_areas$color,
            colors = c("#F6BC26", "#AC242A", "#605F69"),
            labels = c("A. Επιτήρησης", "B. Αυξημένου κινδύνου", "Γ. Συναγερμού"),
            title = "Επίπεδο μέτρων",
            opacity = 1)
  
output$overview_map_greece <- renderLeaflet(greece_map)
