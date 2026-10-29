measure_labels <- c(
  infections = "Infections",
  deaths = "Attributable deaths",
  dalys = "Disability-adjusted life years (DALYs)"
)

sample_labels <- c(
  DE_repr = "German representative sample",
  DE_conv = "German convenience sample"
)

ui <- shiny::fluidPage(

  shiny::tags$head(
    shiny::tags$style(shiny::HTML("
      body {
        background: #f4f7fa;
        color: #203047;
        font-family: 'Segoe UI', Arial, sans-serif;
        font-size: 16px;
        line-height: 1.6;
      }
      .container-fluid {
        max-width: 1400px;
        padding: 24px;
      }
      .hero {
        background: #143d52;
        color: white;
        padding: 26px;
        border-radius: 12px;
        margin-bottom: 22px;
      }
      .hero h1 { margin-top: 0; font-size: 32px; }
      .hero p { max-width: 950px; }
      .well {
        background: white;
        border: 1px solid #d6e0e8;
        border-radius: 12px;
        box-shadow: none;
      }
      .panel-card {
        background: white;
        padding: 22px;
        border: 1px solid #d6e0e8;
        border-radius: 12px;
        margin-bottom: 20px;
      }
      h2 { font-size: 23px; margin-top: 0; }
      h3 { font-size: 19px; }
      .context-note {
        border-left: 5px solid #007f86;
        background: #eaf5f5;
        padding: 16px;
        margin-bottom: 18px;
      }
      .table-scroll { overflow-x: auto; }
      table { font-size: 14px; }
      th { background: #eaf0f5; }
      a { color: #006b77; text-decoration: underline; }
      .shiny-output-error-validation {
        color: #744600;
        background: #fff4db;
        padding: 16px;
        border-radius: 8px;
      }
    "))
  ),

  shiny::div(
    class = "hero",
    shiny::h1("HAI Burden Explorer"),
    shiny::p(
      "For public-health analysts comparing historical estimates",
      "of healthcare-associated infection (HAI) burden."
    ),
    shiny::h2(
      "How do infection burden and rankings differ",
      "between Germany and the EU/EEA?"
    ),
    shiny::p(
      "Compare infections, deaths and healthy years lost.",
      "Survey data: Germany 2011; EU/EEA 2011–2012."
    )
  ),

  shiny::sidebarLayout(

    shiny::sidebarPanel(
      width = 3,

      shiny::h2("Choose your comparison"),

      shiny::selectInput(
        "measure",
        "1. Burden measure",
        choices = c(
          "Healthy years lost (DALYs)" = "dalys",
          "Infections" = "infections",
          "Attributable deaths" = "deaths"
        ),
        selected = "dalys"
      ),

      shiny::helpText(
        "Switch measures to see whether the most frequent",
        "infections also cause the greatest health loss."
      ),

      shiny::selectInput(
        "sample",
        "2. German survey sample",
        choices = c(
          "Representative sample" = "DE_repr",
          "Convenience sample" = "DE_conv"
        ),
        selected = "DE_repr"
      ),

      shiny::helpText(
        "The representative sample included 46 hospitals;",
        "the larger convenience sample included 132.",
        "They are alternative estimates and are never combined."
      ),

      shiny::checkboxGroupInput(
        "infections",
        "3. Infection types",
        choices = c(
          "Pneumonia (HAP)" = "HAP",
          "Urinary tract infection (UTI)" = "UTI",
          "Bloodstream infection (BSI)" = "BSI",
          "Surgical-site infection (SSI)" = "SSI",
          "C. difficile infection (CDI)" = "CDI"
        ),
        selected = c("HAP", "UTI", "BSI", "SSI", "CDI")
      ),

      shiny::helpText(
        "Keep several infections selected to compare their",
        "burden, or select one for a focused comparison."
      )
    ),

    shiny::mainPanel(
      width = 9,

      shiny::div(
        class = "panel-card",
        shiny::h2("Your selected comparison"),
        shiny::uiOutput("comparison_summary")
      ),

      shiny::div(
        class = "panel-card",
        shiny::h2("Compare estimates and uncertainty"),
        shiny::plotOutput(
          "comparison_plot",
          height = "420px"
        ),
        shiny::p(
          "Dots show published median estimates;",
          "lines show 95% uncertainty intervals.",
          "Infections are ordered by the selected German estimate."
        ),
        shiny::p(
          "Compare positions to examine relative burden.",
          "Longer intervals indicate greater uncertainty.",
          "These intervals do not provide a formal test",
          "of differences between populations."
        )
      ),

      shiny::div(
        class = "panel-card",
        shiny::h2("Read the exact values"),

        shiny::div(
          class = "table-scroll",
          shiny::tableOutput("comparison_table")
        ),

        shiny::p(
          "Bracketed values are 95% uncertainty limits.",
          "Difference = Germany minus EU/EEA, in the selected",
          "measure per 100,000 population."
        ),

        shiny::p(
          "Ratio = Germany divided by EU/EEA.",
          "A ratio of 1 means equal point estimates;",
          "2 means the German estimate is twice as high;",
          "0.5 means it is half as high."
        )
      ),

      shiny::div(
        class = "panel-card",
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
            "healthy years lost through premature death",
            "and time lived with disability."
          )
        ),

        shiny::div(
          class = "context-note",
          "All chart and table estimates are annual rates per",
          "100,000 population. They are not percentages of",
          "hospital patients and should not be interpreted",
          "as an individual's infection risk."
        ),

        shiny::h3("Limits of this comparison"),

        shiny::p(
          "These historical, model-based estimates do not",
          "describe current hospital conditions.",
          "The EU/EEA is a pooled comparison, not a list",
          "of individual countries.",
          "A higher point estimate does not by itself",
          "establish a conclusive difference.",
          "The five infections shown do not cover every HAI."
        ),

        shiny::p(
          "Source: Zacher et al. (2019), Table 2. ",
          shiny::tags$a(
            href = paste0(
              "https://doi.org/",
              "10.2807/1560-7917.ES.2019.24.46.1900135"
            ),
            "Read the original study",
            target = "_blank",
            rel = "noopener"
          ),
          ". Published data transcribed and reformatted;",
          "source article licensed under CC BY 4.0."
        )
      )
    )
  )
)

server <- function(input, output, session) {

  # Share one comparison across the summary, plot and table.
  comparison_data <- shiny::reactive({

    shiny::validate(
      shiny::need(
        length(input$infections) > 0,
        paste(
          "No infections selected.",
          "Choose at least one infection in the left panel",
          "to display a comparison."
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
        "No matching estimates are available. Change your selections."
      )
    )

    result
  })

  output$comparison_summary <- shiny::renderUI({

    result <- comparison_data()
    leading <- result[1, ]

    shiny::tagList(
      shiny::p(
        shiny::strong(unname(measure_labels[input$measure])),
        "per 100,000 population:",
        unname(sample_labels[input$sample]),
        "compared with the EU/EEA."
      ),

      shiny::p(
        "Among your selected infections,",
        shiny::strong(leading$infection_name),
        "has the highest German point estimate:",
        sprintf("%.1f", leading$germany_estimate),
        "compared with",
        sprintf("%.1f", leading$eu_estimate),
        "for the EU/EEA."
      ),

      shiny::p(
        "Change the measure to explore whether the ranking changes.",
        "This summary describes point estimates, not a",
        "statistically established ranking."
      )
    )
  })

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

    # Display the highest German estimate at the top.
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
        ggplot2::aes(ymin = lower, ymax = upper),
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

  output$comparison_table <- shiny::renderTable({

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
  }, digits = 2, striped = TRUE, rownames = FALSE)
}

shiny::shinyApp(ui = ui, server = server)
