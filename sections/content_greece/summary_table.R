output$summary_table_greece <- renderUI({
  tabBox(
    tabPanel(paste0(
              "Επίπεδο μέτρων ανά Περιφέρεια"
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
  data_greece_areas %>%
    select("area_short_gen", "level_text", "level") %>%
    rename(
      "Περιφέρεια" = "area_short_gen",
      "Επίπεδο μέτρων" = "level_text"
      ) %>%
    as.data.frame()
}

getSummaryDT_greece <- function() {
  table_data <- summariseData_greece()
  my_levels = na.omit(unique(table_data$level))
  datatable(
    na.omit(table_data),
    rownames  = FALSE,
    options   = list(
      order          = list(1, "desc"),
      scrollX        = TRUE,
      scrollY        = "84vh",
      scrollCollapse = T,
      dom            = 'ft',
      paging         = FALSE,
      language       = list(
        search = "Αναζήτηση:",
        zeroRecords  = "Δεν βρέθηκαν δεδομένα"
      ),
      columnDefs = list(list(visible = FALSE, targets = c(2)))
    ),
    selection = "none"
  ) %>%
    formatStyle(columns = "level", target = "row",
                backgroundColor = styleEqual(1:2, c("#F6BC26",
                                                    "#AC242A")),
                color = "#222")
}
