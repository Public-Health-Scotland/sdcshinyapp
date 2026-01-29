# ------------------------------------------------------------------------------
# Script Name : 1-02_sdc_theory_text.R
# Purpose     : Set up UI for SDC Theory Sub-Tab
# Last Update : 01 Aug 2025
# Author      : Robert Mitchell
# R Version   : 4.4.2
# ------------------------------------------------------------------------------

# SDC Theory Sub-Tab for Home Tab
shiny::tabPanel(
  "SDC Theory",
  shiny::fluidRow(
    shiny::mainPanel(
      shiny::h1("SDC Theory"),
      shiny::br(),

      # Rounding ----
      shiny::h2("Rounding"),
      shiny::p(
        "Rounding adjusts cell values to a specified base, introducing uncertainty while preserving overall structure. It protects against disclosure by differencing."
      ),
      shiny::br(),
      shiny::h4("Pros"),
      shiny::p("\u2022 Protects large tables without altering structure"),
      shiny::p("\u2022 Preserves zeroes"),
      shiny::p("\u2022 Maintains additivity"),
      shiny::br(),
      shiny::h4("Cons"),
      shiny::p("\u2022 Difficult to disguise small counts (e.g., 1 or 2)"),
      shiny::p("\u2022 Not suitable when exact counts are needed"),
      shiny::p("\u2022 Less effective for small populations"),
      shiny::p("\u2022 Sensitive to data revisions"),
      shiny::p("\u2022 May alter headline figures"),
      shiny::br(),

      # Record Swapping ----
      shiny::h2("Record Swapping"),
      shiny::p(
        "Swapping exchanges attributes (e.g., geography) between records to protect identities. It maintains internal consistency but alters geographic distributions."
      ),
      shiny::br(),
      shiny::h4("Pros"),
      shiny::p("\u2022 Protects against differencing"),
      shiny::p("\u2022 Flexible and targeted"),
      shiny::p("\u2022 Maintains additivity and consistency"),
      shiny::br(),
      shiny::h4("Cons"),
      shiny::p("\u2022 Lack of visible control may reduce transparency"),
      shiny::p("\u2022 Public may not perceive protection"),
      shiny::p("\u2022 Can distort distributions"),
      shiny::p("\u2022 High swap rates may be needed"),
      shiny::br(),

      # Suppression ----
      shiny::h2("Suppression"),
      shiny::p(
        "Suppresses unsafe cells by replacing them with a symbol. Secondary suppressions are added to prevent deduction from totals."
      ),
      shiny::br(),
      shiny::h4("Pros"),
      shiny::p("\u2022 Leaves safe data unchanged"),
      shiny::p("\u2022 Can protect zeroes"),
      shiny::p("\u2022 Maintains original table structure"),
      shiny::br(),
      shiny::h4("Cons"),
      shiny::p("\u2022 Suppressed information is lost"),
      shiny::p("\u2022 Secondary suppression may hide safe data"),
      shiny::p("\u2022 High information loss if many suppressions are needed"),
      shiny::br(),

      # Table Redesign ----
      shiny::h2("Table Redesign"),
      shiny::p(
        "Manual method not available in the app. Involves restructuring tables to reduce disclosure risk."
      ),
      shiny::br(),
      shiny::p("\u2022 Group or collapse categories"),
      shiny::p("\u2022 Aggregate to higher geographies or larger groups"),
      shiny::p("\u2022 Combine data across time periods"),
      shiny::br(),
      shiny::p(
        "Unsafe categories should be merged with similar ones to minimise data distortion. Consider consistency across tables and historical comparisons. Redesign can be applied selectively to sub-tables."
      )
    )
  )
)

# END OF SCRIPT ----
