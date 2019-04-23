tabpanel.report = fluidPage(theme = shinytheme("united"),
  sidebarLayout(
    sidebarPanel(width = 3,
      sidebarMenu(
        menuItem("Document Format"),
        selectInput("report.format", "",
          choices = c("PDF", "HTML"), selected = "PDF"),
        menuItem("title"),
        textInput("report.title", label = "", value = "PdM report"),
        menuItem("subtitle"),
        textInput("report.subtitle", label = "",
          value = "Your data analysis and predictive maintenance experiment summary"),
        menuItem("authors"),
        textInput("report.authors", label = "", value = "Cuong Sai, Maxim Shcherbakov"),
        div(align = "center", downloadButton("report", "Generate report"))
      )
    ),
    mainPanel(width = 9,
      fluidRow(
        htmlOutput("report.text")
      ),
      fluidRow(
        makeReportConfigUI("Data summary", "data",
        # passage = "Summary of your data:"
        ),
        makeReportConfigUI("Task", "task",
          # passage = "Here's your task:"
        ),
        makeReportConfigUI("Models", "learners",
          # passage = "You constructed these learners:"
        ),
        makeReportConfigUI("Tuning", "tuning",
          # passage = "Tuning result:"
        ),
        makeReportConfigUI("Train and Predict", "modelling",
          # passage = "Summary of modelling section:"
        )
        )
      )
    )
  )

