makeImportSideBar = function(type) {
  imptype.sel.input = sidebarMenu(
    menuItem("Type"),
    selectInput("import.type", "", selected = type,
      choices = c("CSV", "ARFF"))
  )
  switch(type,

    CSV = list(
      imptype.sel.input,
      sidebarMenu(
        menuItem("Import"),
      fileInput("import.csv", "Choose CSV File",
        accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
      checkboxInput("import.header", "Header", TRUE),
      selectInput("import.sep", "Separator", selected = ",",
        choices = c(Comma = ",", Semicolon = ";", Tab = "\t")),
      selectInput("import.quote", "Quote", selected = '"',
        choices = c(None = "", "Double Quote" = '"', "Single Quote" = "'"))
      )
    ),
    ARFF = list(
      imptype.sel.input,
      sidebarMenu(
        menuItem("Choose ARFF File"),
        fileInput("import.arff", "", accept = c(".arff"))
      )
    )
  )
}

