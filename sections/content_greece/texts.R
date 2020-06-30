output$timeslider_greece_note <- renderText(
  paste(
    em(paste("ΣΗΜΕΙΩΣΗ: Ανά περιοχή ιστορικά δεδομένα είναι διαθέσιμα μόνο από",
             format(min(data_greece_region_timeline$date), format="%d/%m/%Y"),
             "και μόνο για επιβεβαιωμένα κρούσματα.")
    )
  )
)