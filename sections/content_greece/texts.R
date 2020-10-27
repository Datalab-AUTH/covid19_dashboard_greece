output$covid19_gov_gr_text <- renderText(
  paste(
    paste("Για περισσότερες πληροφορίες σχετικά με τα επίπεδα μέτρων και
             τους περιορισμούς που αντιστοιχούν σε αυτά, μπορείτε να
             επισκευτείτε την αντίστοιχη ιστοσελίδα της Ελληνικής κυβέρνησης ",
             tags$a(href = "https://covid19.gov.gr/covid-map",
                    "covid19.gov.gr/covid-map"))
  )
)
