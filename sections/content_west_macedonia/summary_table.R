output$summary_table_west_macedonia <- renderUI({
  tabBox(
    tabPanel(paste0(
      "Κρούσματα ανά Νοσοκομείο (",
      format(input$timeslider_west_macedonia, format="%d/%m/%Y"),
      ")"
      ),
             div(
               dataTableOutput("summaryDT_west_macedonia"),
               style = "margin-top: -10px")
    ),
    width = 12
  )
})

output$summaryDT_west_macedonia <- renderDataTable(getSummaryDT_west_macedonia(data_atDate_west_macedonia(input$timeslider_west_macedonia)))
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
    select(
      "hospital_name_el_short",
      "new_samples",
      "hospitalized_current",
      "hospitalized_positive",
      "hospitalized_negative",
      "hospitalized_pending_result",
      "home_restriction_current",
      "new_recoveries"
      ) %>%
    rename(
      "Νοσοκομείο" = "hospital_name_el_short",
      "Έλεγχοι δειγμάτων" = "new_samples",
      "Νοσηλευόμενοι" = "hospitalized_current",
      "Νοσηλευόμενοι (θετικοί)" = "hospitalized_positive",
      "Νοσηλευόμενοι (αρνητικοί)" = "hospitalized_negative",
      "Νοσηλευόμενοι (εν αναμονή αποτελεσμάτων)" = "hospitalized_pending_result",
      "Σε κατ'οίκον περιορισμό" = "home_restriction_current",
      "Εξιτήρια" = "new_recoveries"
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
      searching      = FALSE,
      language       = list(
        zeroRecords  = "Δεν βρέθηκαν δεδομένα"
      )
    ),
    selection = "none"
  )
}
