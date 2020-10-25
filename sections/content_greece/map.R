
greece_map <- leaflet() %>% 
  addProviderTiles(providers$CartoDB.DarkMatter, group = "Dark") %>%
  setView(24.3, 38.2, zoom = 7) %>%
  addPolygons(data = data_greece_spdf,
              stroke = TRUE, color = "black", weight = 1,
              smoothFactor = 0.2, fillOpacity = 0.7,
              fillColor = ~map_pal(data_greece_areas$color),
              popup = paste("<b>", data_greece_spdf$LEKTIKO, "</b><br>",
                            "Επίπεδο: ", data_greece_areas$level, "<br>")) %>%
  addLegend(position = "bottomleft", values = data_greece_areas$color,
            colors = c("#A5CB81", "#F6BC26", "#E5712A", "#AC242A"),
            labels = c("1. Ετοιμότητας", "2. Επιτήρησης", "3. Αυξημένης επιτήρησης", "4. Αυξημένου κινδύνου"),
            title = "Επίπεδο μέτρων",
            opacity = 1)
  
output$overview_map_greece <- renderLeaflet(greece_map)
