output$summary_table_greece <- renderUI({
  tabBox(
    tabPanel(paste0(
              "Επιβεβαιωμένα κρούσματα ανά Περιφέρεια (",
              format(input$timeslider_greece, format="%d/%m/%Y"),
              ")"
            ),
             div(
               dataTableOutput("summaryDT_greece"),
               style = "margin-top: -10px")
    ),
    width = 12
  )
})

output$summaryDT_greece <- renderDataTable(getSummaryDT_greece(data_atDate_greece(input$timeslider_greece)))
proxy_summaryDT_greece  <- dataTableProxy("summaryDT_greece")

observeEvent(input$timeslider_greece, {
  data <- data_atDate_greece(input$timeslider_greece)
  replaceData(proxy_summaryDT_greece,
              summariseData_greece(data),
              rownames = FALSE)
}, ignoreInit = TRUE, ignoreNULL = TRUE)

summariseData_greece <- function(df) {
  df %>%
    select("region_gr_name", "confirmed", "confirmed_new", "confirmedPerCapita") %>%
    rename(
      "Περιφέρεια" = "region_gr_name",
      "Επιβεβαιωμένα κρούσματα" = "confirmed",
      "Νέα κρούσματα" = "confirmed_new",
      "Επιβ. κρούσματα / 100.000 κατοίκους" = "confirmedPerCapita"
      ) %>%
    as.data.frame()
}

getSummaryDT_greece <- function(data) {
  datatable(
    na.omit(summariseData_greece(data)),
    rownames  = FALSE,
    options   = list(
      order          = list(1, "desc"),
      scrollX        = TRUE,
      scrollY        = "37vh",
      scrollCollapse = T,
      dom            = 'ft',
      paging         = FALSE,
      language       = list(
        search = "Αναζήτηση:",
        zeroRecords  = "Δεν βρέθηκαν δεδομένα"
      )
    ),
    selection = "none"
  )
}
