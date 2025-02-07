### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 1-02_sdc_theory_text.R
#Purpose: To set up UI for SDC Theory Sub Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###


### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Stores Text for SDC Theory Page ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

shiny::tabPanel("SDC Theory",

                shiny::fluidRow(

                  ### ### ### ### ### ### ### ### ### ### ### ### ### ###
                  ## 1. Main panel for displaying all text ----
                  ### ### ### ### ### ### ### ### ### ### ### ### ### ###

                  shiny::mainPanel(

                    ### ### ### ### ### ### ### ###
                    ### 1. Main Page Title ----
                    ### ### ### ### ### ### ### ###

                    shiny::h1("SDC Theory"),

                    shiny::br(),

                    ### ### ### ### ### ### ### ###
                    ### 2. Rounding Theory ----
                    ### ### ### ### ### ### ### ###

                    shiny::h2("Rounding"),

                    shiny::p("Rounding involves adjusting the values in all cells in a table to a specified base so as to create uncertainty
                              about the real value for any cell while adding a small but acceptable amount of distortion to the data. A major
                              advantage of rounding is that it offers protection from disclosure by differencing since the difference between
                              two rounded tables will also be rounded."),

                    shiny::br(),

                    shiny::h4("Pros"),

                    shiny::p("\U2022 If the number of unsafe cells is large then the table can be protected while still providing counts for all cells and without altering the design of the table"),
                    shiny::p("\U2022 Will protect zeroes without removing them"),
                    shiny::p("\U2022 Cells rounded to a common base in such a way as to preserve additivity to totals within table"),

                    shiny::br(),

                    shiny::h4("Cons"),

                    shiny::p("\U2022 Difficulties in disguising cells in which the count is 1 or 2"),
                    shiny::p("\U2022 If user requires exact counts rounded values would not be appropriate"),
                    shiny::p("\U2022 If population size is small then rounding may not offer enough protection"),
                    shiny::p("\U2022 May be prone to effects of data revisions"),
                    shiny::p("\U2022 Totals may be adjusted, thereby altering ‘headline’ figures"),

                    shiny::br(),

                    ### ### ### ### ### ### ### ###
                    ### 3. Swapping Theory ----
                    ### ### ### ### ### ### ### ###

                    shiny::h2("Record Swapping"),

                    shiny::p("This involves swapping characteristics between pairs of records. Typically, in order to satisfy edit checks,
                              swapping alters the geographic locations attached to the records, but leaves all other aspects unchanged.
                              The effect on tabulations produced from the record-swapped data is that some of the data will be counted in
                              the table for a different geographical location, depending on the level of geography chosen."),

                    shiny::br(),

                    shiny::h4("Pros"),

                    shiny::p("\U2022 Protects against disclosure by differencing"),
                    shiny::p("\U2022 Swapping rates are flexible"),
                    shiny::p("\U2022 Can target risky records"),
                    shiny::p("\U2022 Tables can be made to be additive"),
                    shiny::p("\U2022 Consistent totals between tables"),

                    shiny::br(),

                    shiny::h4("Cons"),

                    shiny::p("\U2022 Table not visibly controlled – so users need clear explanations to ensure transparency"),
                    shiny::p("\U2022 Public may perceive that no SDC has been applied"),
                    shiny::p("\U2022 May introduce some bias by distorting distributions in the data"),
                    shiny::p("\U2022 High level of swapping may be required in order to disguise unsafe cells"),

                    shiny::br(),

                    ### ### ### ### ### ### ### ###
                    ### 4. Suppression Theory ----
                    ### ### ### ### ### ### ### ###

                    shiny::h2("Suppression"),
                    shiny::p("A method of protecting unsafe cells in tables is cell suppression. This means that unsafe cells are not published – they
                              are suppressed and replaced by a special character. Such suppressions are called primary suppressions. To
                              make sure the primary suppressions cannot be derived by subtractions from published marginal totals, the next
                              numerically lowest numbers are selected for secondary suppression."),

                    shiny::br(),

                    shiny::h4("Pros"),

                    shiny::p("\U2022 Original counts in the data that are not suppressed are not adjusted"),
                    shiny::p("\U2022 Can provide protection for zeros"),
                    shiny::p("\U2022 Allows original/requested structure to be maintained"),

                    shiny::br(),

                    shiny::h4("Cons"),

                    shiny::p("\U2022 Most of the information about suppressed cells will be lost"),
                    shiny::p("\U2022 Secondary suppressions will hide information in safe cells (this could include totals)"),
                    shiny::p("\U2022 Information loss may be high if more than a few suppressions are required"),

                    shiny::br(),

                    ### ### ### ### ### ### ### ###
                    ### 5. Table Redesign Theory ----
                    ### ### ### ### ### ### ### ###

                    shiny::h2("Table Redesign"),

                    shiny::p("Another method to consider, which is not available in the app and should be done manually, is Table Redesign. Examples of table redesign include:-"),

                    shiny::br(),

                    shiny::p("\U2022 Grouping or collapsing categories within a table"),
                    shiny::p("\U2022 Aggregating to a higher level geography or for a larger population sub-group"),
                    shiny::p("\U2022 Aggregating tables across a number of years/quarters/months"),

                    shiny::br(),

                    shiny::p("Categories with unsafe cells should be selected and combined where possible with similar categories.
                              Two smaller similar categories might be combined to form a larger one, but if they are dissimilar,
                              each should be combined with a different larger category to minimise the relative data damage. It
                              is important to take into account how the proposed change will affect the consistency between tables
                              and historic comparisons. Collapsing categories does not necessarily have to be implemented across a whole table
                              but can be applied to sub-tables.")

                    )

                  )

                )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
