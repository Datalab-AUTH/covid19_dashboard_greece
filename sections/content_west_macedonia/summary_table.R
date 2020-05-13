output$summary_table_west_macedonia <- renderUI({
  tabBox(
    tabPanel("Κρούσματα ανά Νοσοκομείο",
             div(
               dataTableOutput("summaryDT_west_macedonia"),
               style = "margin-top: -10px")
    ),
    width = 12
  )
})

output$summaryDT_west_macedonia <- renderDataTable(getSummaryDT_west_macedonia(data_atDate_west_macedonia("2020-05-11")))
proxy_summaryDT_west_macedonia  <- dataTableProxy("summaryDT_west_macedonia")

observeEvent(input$timeslider_west_macedonia, {
  data <- data_atDate_west_macedonia(input$timeslider_west_macedonia)
  replaceData(proxy_summaryDT_west_macedonia,
              summariseData_west_macedonia(data),
              rownames = FALSE)
}, ignoreInit = TRUE, ignoreNULL = TRUE)

summariseData_west_macedonia <- function(df) {
  df %>%
    ungroup() %>%
    select("hospital_name_el_short", "hospitalized_current", "home_restriction_current", "new_recoveries", "new_samples") %>%
    rename(
      "Νοσοκομείο" = "hospital_name_el_short",
      "Νοσηλευόμενοι" = "hospitalized_current",
      "Σε κατ'οίκον περιορισμό" = "home_restriction_current",
      "Εξιτήρια" = "new_recoveries",
      "Έλεγχοι δειγμάτων" = "new_samples"
      ) %>%
    as.data.frame()
}

getSummaryDT_west_macedonia <- function(data) {
  datatable(
    na.omit(summariseData_west_macedonia(data)),
    rownames  = FALSE,
    options   = list(
      order          = list(1, "desc"),
      scrollX        = TRUE,
      scrollY        = "37vh",
      scrollCollapse = T,
      dom            = 'ft',
      paging         = FALSE,
      searching      = FALSE
    ),
    selection = "none"
  )
}
