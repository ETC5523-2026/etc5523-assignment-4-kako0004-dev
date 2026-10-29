ui <- shiny::fluidPage(
  shiny::titlePanel("Healthcare-associated infection burden"),

  shiny::p(
    "Explore how Germany's estimated burden compares with the EU/EEA.",
    "Designed for public-health analysts exploring historical estimates."
  ),

  shiny::selectInput(
    "measure",
    "Which measure do you want to compare?",
    choices = c(
      "Healthy years lost (DALYs)" = "dalys",
      "Infections" = "infections",
      "Attributable deaths" = "deaths"
    ),
    selected = "dalys"
  ),

  shiny::selectInput(
    "sample",
    "Which German sample?",
    choices = c(
      "Representative sample" = "DE_repr",
      "Convenience sample" = "DE_conv"
    ),
    selected = "DE_repr"
  ),

  shiny::p(
    "Estimates and their 95% uncertainty limits are annual rates",
    "per 100,000 population. A ratio above 1 indicates a higher",
    "German point estimate."
  ),

  shiny::tableOutput("comparison_table"),

  shiny::p(
    "DALYs means disability-adjusted life years.",
    "The German samples are alternative estimates and are not combined."
  ),

  shiny::p(
    "Source: Zacher et al. (2019), Table 2.",
    "Survey data: Germany 2011; EU/EEA 2011–2012.",
    "These model-based estimates do not describe current conditions.",
    "Differences and rankings do not establish statistical significance."
  )
)

server <- function(input, output, session) {

  output$comparison_table <- shiny::renderTable({

    result <- haiburden::compare_burden(
      measure = input$measure,
      sample_id = input$sample
    )

    displayed <- result[c(
      "infection_name",
      "germany_estimate",
      "germany_lower",
      "germany_upper",
      "eu_estimate",
      "eu_lower",
      "eu_upper",
      "difference",
      "ratio",
      "germany_rank",
      "eu_rank"
    )]

    names(displayed) <- c(
      "Infection",
      "Germany",
      "Germany lower",
      "Germany upper",
      "EU/EEA",
      "EU/EEA lower",
      "EU/EEA upper",
      "Difference",
      "Ratio",
      "German rank",
      "EU/EEA rank"
    )

    displayed
  }, digits = 2, striped = TRUE)
}

shiny::shinyApp(ui = ui, server = server)
