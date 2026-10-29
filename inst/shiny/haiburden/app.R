# Labels used throughout the app
measure_labels <- c(
  infections = "Infections",
  deaths = "Attributable deaths",
  dalys = "Disability-adjusted life years (DALYs)"
)

sample_labels <- c(
  DE_repr = "German representative sample",
  DE_conv = "German convenience sample"
)

infection_choices <- c(
  "Pneumonia (HAP)" = "HAP",
  "Urinary tract infection (UTI)" = "UTI",
  "Bloodstream infection (BSI)" = "BSI",
  "Surgical-site infection (SSI)" = "SSI",
  "Clostridioides difficile infection (CDI)" = "CDI"
)

source_doi <- paste0(
  "https://doi.org/",
  "10.2807/1560-7917.ES.2019.24.46.1900135"
)

# User interface
ui <- shiny::fluidPage(
  shiny::tags$head(
    shiny::tags$style(
      shiny::HTML("
        body {
          background: #f3f6fa;
          color: #183449;
          font-family: 'Segoe UI', Arial, sans-serif;
          font-size: 15px;
          line-height: 1.55;
        }

        .container-fluid {
          max-width: 1440px;
          padding: 22px;
        }

        .hero {
          background: linear-gradient(120deg, #17384d, #155c65);
          color: white;
          padding: 20px 26px;
          border-radius: 14px;
          margin-bottom: 22px;
          border-left: 6px solid #62d4c3;
        }

        .hero h1 {
          margin: 0 0 8px;
          font-size: 28px;
        }

        .hero h2 {
          font-size: 20px;
          margin: 10px 0;
          line-height: 1.4;
        }

        .hero p {
          color: #e4f1f3;
          margin-bottom: 6px;
        }

        .metadata,
        .summary-note {
          font-size: 13px;
        }

        .summary-note {
          color: #526579;
        }

        .well,
        .panel-card {
          background: white;
          border: 1px solid #dce5ec;
          border-radius: 12px;
          padding: 20px;
          margin-bottom: 18px;
          box-shadow: 0 3px 12px rgba(24, 52, 73, 0.04);
        }

        h2 {
          font-size: 21px;
          margin-top: 0;
        }

        h3 {
          font-size: 18px;
        }

        .well h2 {
          font-size: 19px;
        }

        .control-label {
          font-size: 14px;
          font-weight: 700;
        }

        .help-block {
          font-size: 13px;
          color: #526579;
          margin-bottom: 20px;
        }

        .checkbox {
          font-size: 14px;
          padding: 3px 0;
        }

        input[type='checkbox'] {
          accent-color: #007f86;
        }

        .selectize-input {
          font-size: 14px;
          border-radius: 8px;
        }

        .selection-context {
          background: #edf3f7;
          color: #29465b;
          padding: 10px 14px;
          border-radius: 8px;
          margin: 14px 0;
          font-size: 14px;
          font-weight: 600;
        }

        .finding {
          border-left: 4px solid #007f86;
          background: #edf8f6;
          padding: 14px 18px;
          border-radius: 0 8px 8px 0;
          margin: 16px 0;
        }

        .finding h3 {
          margin: 0 0 8px;
        }

        .finding p:last-child {
          margin-bottom: 0;
        }

        .nav-tabs {
          border-bottom: 1px solid #ccdbe5;
        }

        .nav-tabs > li > a {
          color: #365267;
          font-weight: 600;
        }

        .nav-tabs > li.active > a,
        .nav-tabs > li.active > a:focus,
        .nav-tabs > li.active > a:hover {
          color: #006b72;
          border-top: 3px solid #007f86;
        }

        .tab-content {
          padding-top: 20px;
        }

        .table-scroll {
          overflow-x: auto;
          margin: 16px 0;
        }

        .table {
          font-size: 13px;
        }

        .table > thead > tr > th {
          background: #edf3f7;
          padding: 12px;
        }

        .table > tbody > tr > td {
          padding: 12px;
          vertical-align: middle;
        }

        .table td:not(:first-child) {
          white-space: nowrap;
          font-variant-numeric: tabular-nums;
        }

        .btn-default {
          border-color: #007f86;
          color: #006b72;
          border-radius: 7px;
          white-space: normal;
        }

        .btn-default:hover {
          background: #edf8f6;
        }

        a {
          color: #006b72;
        }

        a:focus-visible,
        button:focus-visible {
          outline: 3px solid #007f86;
          outline-offset: 3px;
        }

        .shiny-output-error-validation {
          color: #704800;
          background: #fff5df;
          border-left: 4px solid #c48a16;
          padding: 16px;
          border-radius: 8px;
        }
        #comparison_plot.shiny-output-error-validation {
        height: auto !important;
        min-height: 0 !important;
        }

        @media (max-width: 767px) {
          .container-fluid {
            padding: 12px;
          }

          .hero {
            padding: 18px;
          }

          .hero h1 {
            font-size: 25px;
          }
        }
      ")
    )
  ),

  shiny::div(
    class = "hero",

    shiny::h1("HAI Burden Explorer"),

    shiny::h2(
      "How does infection burden differ between Germany and the EU/EEA?"
    ),

    shiny::p(
      "For public-health analysts comparing healthcare-associated",
      "infections (HAIs), attributable deaths and healthy years lost."
    ),

    shiny::p(
      class = "metadata",
      "EU/EEA: European Union/European Economic Area.",
      "Historical survey data: Germany 2011; EU/EEA 2011-2012."
    )
  ),

  shiny::sidebarLayout(
    shiny::sidebarPanel(
      width = 3,

      shiny::h2("Choose your comparison"),

      shiny::selectInput(
        inputId = "measure",
        label = "1. Burden measure",
        choices = c(
          "Healthy years lost (DALYs)" = "dalys",
          "Infections" = "infections",
          "Attributable deaths" = "deaths"
        ),
        selected = "dalys"
      ),

      shiny::helpText(
        "Switch measures to examine whether the most frequent",
        "infections also cause the greatest health loss."
      ),

      shiny::selectInput(
        inputId = "sample",
        label = "2. German survey sample",
        choices = c(
          "Representative sample" = "DE_repr",
          "Convenience sample" = "DE_conv"
        ),
        selected = "DE_repr"
      ),

      shiny::helpText(
        "Start with the representative sample (46 hospitals).",
        "Switch to the convenience sample (132 hospitals) to",
        "examine how findings depend on sample choice.",
        "Larger does not automatically mean more representative.",
        "The samples are never combined."
      ),

      shiny::checkboxGroupInput(
        inputId = "infections",
        label = "3. Infection types",
        choices = infection_choices,
        selected = unname(infection_choices)
      ),

      shiny::helpText(
        "Select several infections to compare them,",
        "or one for a focused view.",
        "These filters apply across all tabs."
      ),

      shiny::actionButton(
        inputId = "reset",
        label = "Reset comparison"
      ),

      shiny::helpText(
        "Restores DALYs, the representative sample",
        "and all five infections."
      )
    ),

    shiny::mainPanel(
      width = 9,

      shiny::div(
        class = "panel-card",

        shiny::tabsetPanel(
          id = "main_tabs",

          shiny::tabPanel(
            title = "Explore burden",
            value = "explore",

            shiny::h2("Compare estimates and uncertainty"),

            shiny::div(
              class = "selection-context",
              shiny::textOutput("context_plot")
            ),

            shiny::uiOutput("comparison_summary"),

            shiny::plotOutput(
              outputId = "comparison_plot",
              height = "420px"
            ),

            shiny::p(
              "Symbols show published median estimates;",
              "lines show 95% uncertainty intervals.",
              "Infections are ordered by the selected German estimate.",
              "Abbreviations match the infection controls."
            ),

            shiny::p(
              class = "summary-note",
              "Longer intervals indicate greater absolute uncertainty.",
              "The intervals are not a formal test of differences.",
              "All estimates are annual rates per 100,000 population."
            )
          ),

          shiny::tabPanel(
            title = "Exact values",
            value = "values",

            shiny::h2("Read and download your comparison"),

            shiny::div(
              class = "selection-context",
              shiny::textOutput("context_table")
            ),

            shiny::div(
              class = "table-scroll",
              shiny::tableOutput("comparison_table")
            ),

            shiny::p(
              "Bracketed values are 95% uncertainty limits (UI).",
              "Difference = Germany minus EU/EEA, in the selected",
              "measure per 100,000 population.",
              "Ratio = Germany divided by EU/EEA."
            ),

            shiny::p(
              "A ratio of 1 indicates equal point estimates;",
              "2 means twice as high and 0.5 means half as high.",
              "Original uncertainty limits do not describe",
              "the calculated difference or ratio."
            ),

            shiny::uiOutput("download_control"),

            shiny::p(
              class = "summary-note",
              "The CSV includes your selected estimates, uncertainty",
              "limits, sample, survey periods, units, source citation",
              "and licence. Ranks in the export refer to all five",
              "infections in each population."
            )
          ),

          shiny::tabPanel(
            title = "About the data",
            value = "about",

            shiny::h2("Understand the measures"),

            shiny::tags$ul(
              shiny::tags$li(
                shiny::strong("Infections: "),
                "estimated new infection episodes during a year."
              ),

              shiny::tags$li(
                shiny::strong("Attributable deaths: "),
                "deaths estimated to result from these infections."
              ),

              shiny::tags$li(
                shiny::strong("DALYs: "),
                "disability-adjusted life years: healthy years lost",
                "through premature death and time lived with disability."
              )
            ),

            shiny::div(
              class = "finding",
              "Rates are per 100,000 population.",
              "They are not percentages of hospital patients",
              "or estimates of an individual's infection risk."
            ),

            shiny::h3("Why compare two German samples?"),

            shiny::p(
              "The representative German point prevalence survey",
              "(PPS) included 9,626 patients in 46 hospitals",
              "selected by hospital size.",
              "The convenience sample included 41,539 patients",
              "in 132 hospitals and was not representative",
              "by hospital size."
            ),

            shiny::p(
              "Changing the sample helps assess whether the main",
              "findings depend on the sample used.",
              "It is a sensitivity comparison, not a trend over time,",
              "and the two estimates must not be combined."
            ),

            shiny::h3("Limits of interpretation"),

            shiny::p(
              "These historical, model-based estimates do not",
              "describe current hospital conditions.",
              "The EU/EEA is a pooled comparison, not",
              "individual-country data.",
              "Point-estimate differences and rankings do not",
              "establish conclusive differences.",
              "The five infections do not cover every HAI,",
              "and the app does not estimate prevention effects",
              "or recommend funding allocations."
            ),

            shiny::h3("Source and reproducibility"),

            shiny::p(
              "Data: Zacher et al. (2019), Table 2.",
              "Published values and 95% uncertainty limits",
              "were transcribed and reformatted.",
              "The preparation script is data-raw/hai-burden.R",
              "in the repository.",
              "The app uses data included in the installed",
              "haiburden package."
            ),

            shiny::p(
              shiny::tags$a(
                href = source_doi,
                "Read the original study",
                target = "_blank",
                rel = "noopener"
              ),

              " | Source article licence: ",

              shiny::tags$a(
                href = "https://creativecommons.org/licenses/by/4.0/",
                "CC BY 4.0",
                target = "_blank",
                rel = "noopener"
              )
            )
          )
        )
      )
    )
  )
)

# Server: connect selections to outputs
server <- function(input, output, session) {

  # Reset all comparison controls.
  shiny::observeEvent(input$reset, {
    shiny::updateSelectInput(
      session = session,
      inputId = "measure",
      selected = "dalys"
    )

    shiny::updateSelectInput(
      session = session,
      inputId = "sample",
      selected = "DE_repr"
    )

    shiny::updateCheckboxGroupInput(
      session = session,
      inputId = "infections",
      selected = unname(infection_choices)
    )
  })

  # Share the selected comparison across outputs.
  comparison_data <- shiny::reactive({

    shiny::validate(
      shiny::need(
        length(input$infections) > 0,
        paste(
          "No infections selected.",
          "Choose at least one infection,",
          "or click Reset comparison."
        )
      )
    )

    result <- haiburden::compare_burden(
      measure = input$measure,
      sample_id = input$sample
    )

    result <- result[
      result$infection %in% input$infections,
      ,
      drop = FALSE
    ]

    shiny::validate(
      shiny::need(
        nrow(result) > 0,
        paste(
          "No matching estimates are available.",
          "Change your selections or reset."
        )
      )
    )

    result
  })

  # Show the current selections on the chart and table tabs.
  selection_context <- shiny::reactive({

    number_selected <- length(input$infections)

    paste(
      unname(measure_labels[input$measure]),
      "per 100,000 |",
      unname(sample_labels[input$sample]),
      "|",
      number_selected,
      if (number_selected == 1L) "infection" else "infections"
    )
  })

  output$context_plot <- shiny::renderText({
    selection_context()
  })

  output$context_table <- shiny::renderText({
    selection_context()
  })

  # Explain the highest German point estimate among selections.
  output$comparison_summary <- shiny::renderUI({

    shiny::req(length(input$infections) > 0)

    result <- comparison_data()
    leading <- result[1, ]
    ratio <- leading$ratio

    comparison_text <- if (!is.finite(ratio)) {
      paste(
        "A percentage comparison is unavailable",
        "because the reference estimate is zero."
      )
    } else if (abs((ratio - 1) * 100) < 0.5) {
      "German and EU/EEA point estimates are approximately equal."
    } else {
      sprintf(
        "German point estimate about %.0f%% %s than the EU/EEA.",
        abs((ratio - 1) * 100),
        if (ratio > 1) "higher" else "lower"
      )
    }

    shiny::div(
      class = "finding",

      shiny::h3(leading$infection_name),

      shiny::p(
        shiny::strong(comparison_text)
      ),

      shiny::p(
        sprintf(
          "%.1f versus %.1f %s per 100,000 population.",
          leading$germany_estimate,
          leading$eu_estimate,
          tolower(unname(measure_labels[input$measure]))
        )
      ),

      shiny::p(
        class = "summary-note",
        "Highlighted because it has the highest German point",
        "estimate among your selections.",
        "Based on medians; uncertainty is shown below.",
        "The percentage comparison is not a significance test."
      )
    )
  })

  # Existing comparison graph
  output$comparison_plot <- shiny::renderPlot({

    result <- comparison_data()

    plot_data <- rbind(
      data.frame(
        infection = result$infection,
        population = "Germany",
        estimate = result$germany_estimate,
        lower = result$germany_lower,
        upper = result$germany_upper
      ),

      data.frame(
        infection = result$infection,
        population = "EU/EEA",
        estimate = result$eu_estimate,
        lower = result$eu_lower,
        upper = result$eu_upper
      )
    )

    # Put the highest German estimate at the top.
    plot_data$infection <- factor(
      plot_data$infection,
      levels = rev(result$infection)
    )

    ggplot2::ggplot(
      plot_data,
      ggplot2::aes(
        x = infection,
        y = estimate,
        colour = population,
        shape = population,
        group = population
      )
    ) +
      ggplot2::geom_pointrange(
        ggplot2::aes(
          ymin = lower,
          ymax = upper
        ),
        position = ggplot2::position_dodge(width = 0.5)
      ) +
      ggplot2::coord_flip() +
      ggplot2::scale_colour_manual(
        values = c(
          "Germany" = "#007F86",
          "EU/EEA" = "#A84B00"
        )
      ) +
      ggplot2::scale_y_continuous(
        limits = c(0, NA)
      ) +
      ggplot2::labs(
        x = NULL,
        y = paste(
          unname(measure_labels[input$measure]),
          "per 100,000 population"
        ),
        colour = NULL,
        shape = NULL
      ) +
      ggplot2::theme_minimal(base_size = 14) +
      ggplot2::theme(
        legend.position = "top",
        panel.grid.minor = ggplot2::element_blank()
      )
  })

  # Table of estimates and comparisons
  output$comparison_table <- shiny::renderTable(
    {
      result <- comparison_data()

      data.frame(
        Infection = result$infection_name,

        `Germany (95% UI)` = sprintf(
          "%.1f [%.1f, %.1f]",
          result$germany_estimate,
          result$germany_lower,
          result$germany_upper
        ),

        `EU/EEA (95% UI)` = sprintf(
          "%.1f [%.1f, %.1f]",
          result$eu_estimate,
          result$eu_lower,
          result$eu_upper
        ),

        Difference = result$difference,
        Ratio = result$ratio,
        check.names = FALSE
      )
    },
    digits = 2,
    striped = TRUE,
    rownames = FALSE
  )

  # Offer the download only when infections are selected.
  output$download_control <- shiny::renderUI({

    if (length(input$infections) == 0L) {
      shiny::p(
        "Select at least one infection to enable the download."
      )
    } else {
      shiny::downloadButton(
        outputId = "download_selected",
        label = "Download selected data (CSV)"
      )
    }
  })

  # Export numeric values and the context needed to interpret them.
  output$download_selected <- shiny::downloadHandler(
    filename = function() {
      paste0(
        "haiburden_",
        input$sample,
        "_",
        input$measure,
        ".csv"
      )
    },

    content = function(file) {

      exported <- comparison_data()

      exported$german_sample_label <- unname(
        sample_labels[input$sample]
      )

      exported$reference_population <- "EU/EEA"

      exported$measure_label <- unname(
        measure_labels[input$measure]
      )

      exported$unit <- paste(
        unname(measure_labels[input$measure]),
        "per 100,000 population"
      )

      exported$german_survey_period <- "2011"
      exported$eu_survey_period <- "2011-2012"
      exported$estimate_type <- "Published median"

      exported$interval_type <- paste(
        "95% uncertainty interval for each original estimate"
      )

      exported$comparison_definition <- paste(
        "Difference: Germany minus EU/EEA;",
        "ratio: Germany divided by EU/EEA"
      )

      exported$ranking_scope <- paste(
        "All five infection types within each population"
      )

      exported$source_citation <- paste(
        "Zacher et al. (2019), Eurosurveillance",
        "24(46), 1900135, Table 2"
      )

      exported$source_doi <- source_doi
      exported$source_licence <- "CC BY 4.0"

      exported$source_licence_url <- paste0(
        "https://creativecommons.org/licenses/by/4.0/"
      )

      exported$data_changes <- paste(
        "Transcribed and reformatted;",
        "differences, ratios and ranks calculated from medians"
      )

      utils::write.csv(
        exported,
        file = file,
        row.names = FALSE,
        na = ""
      )
    }
  )
}

# Start the application
shiny::shinyApp(ui = ui, server = server)
