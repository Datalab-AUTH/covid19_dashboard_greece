output$summary_table_greece <- renderUI({
  tabBox(
    tabPanel(paste0(
              "Επιβεβαιωμένα κρούσματα ανά Περιφέρεια"
            ),
             div(
               dataTableOutput("summaryDT_greece"),
               style = "margin-top: -10px")
    ),
    width = 12
  )
})

output$summaryDT_greece <- renderDataTable(getSummaryDT_greece())
proxy_summaryDT_greece  <- dataTableProxy("summaryDT_greece")

summariseData_greece <- function() {
  data_sandbird_map %>%
    select("area_short_gen", "cases", "rollsum_pop", "color") %>%
    rename(
      "Περιφερειακή Ενότητα" = "area_short_gen",
      "Νέα κρούσματα" = "cases",
      "Κρούσματα τελευταίων 7 ημερών \n/ 100.000 κατοίκους" = "rollsum_pop"
      ) %>%
    as.data.frame()
}

getSummaryDT_greece <- function() {
  table_data <- summariseData_greece()
  my_levels = na.omit(unique(table_data$color))
  datatable(
    na.omit(table_data),
    rownames  = FALSE,
    options   = list(
      order          = list(2, "desc"), # sort by 3rd column (7-day cases/100000)
      scrollX        = TRUE,
      scrollY        = "84vh",
      scrollCollapse = T,
      dom            = 'ft',
      paging         = FALSE,
      language       = list(
        search = "Αναζήτηση:",
        zeroRecords  = "Δεν βρέθηκαν δεδομένα"
      ),
      columnDefs = list(list(visible = FALSE, targets = c(3))) # hide 4th column
    ),
    selection = "none"
  ) %>%
    formatStyle(columns = "color", target = "row",
                backgroundColor = styleEqual(0:7, map_pal(0:7)),
                color = "#222" # text color
                )
}
