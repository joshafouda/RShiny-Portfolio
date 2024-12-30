
# identification interne tabItem (ne pas modifier)
nom_tab <- "tabItem_hr_analytics"

# Ajout menu ITEM
liste_menuitems <- append(liste_menuitems, list(menuItem("HR Analytics Dashboard", tabName = nom_tab, icon = icon("user-tie"))), after = 7 - 1)

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab, # identification interne du panneau
    fluidRow(
      tabsetPanel(
        tabPanel("Overview", icon = icon("users-cog"),
          fluidRow(
            box(width = 12,
                valueBoxOutput("TotalEmployees", width = 3), 
                valueBoxOutput("ActiveEmployees", width = 3), 
                valueBoxOutput("InactiveEmployees", width = 3), 
                valueBoxOutput("GloablAttritionRate", width = 3)
            )
          ),
          fluidRow(
            column(width = 5,
                   fluidRow(box(width = 12, title = "Employee Hiring Trends", status = "primary", solidHeader = TRUE,
                       plotlyOutput("EmployeeHiringTrends", height = "220px"))),
                   fluidRow(
                     box(width = 12, title = "Active Employees by Department and Job Role", status = "primary", solidHeader = TRUE, 
                         selectInput("department", "Select a Department", choices = c("Human Resources", "Sales", "Technology")), 
                         plotlyOutput("ActiveEmployeesDepartmentJobRole", height = "300px"))
                   )
                   
            ),
            column(width = 7,
              fluidRow(
                box(width = 12, title = "Active Employees by Department", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("ActiveEmployeesDepartment", height = "150px"))
              ),
              fluidRow(
                box(width = 12, title = "Attrition Rate by State and Education Field", status = "primary", solidHeader = TRUE, 
                    highchartOutput("TreeMap", height = "450px"))
              )
            )
          )
        ),
        tabPanel("Demographics", icon = icon("address-book"),
          fluidRow(
            column(width = 6,
                   fluidRow(
                     box(width = 12,
                         valueBoxOutput("YoungestEmployee", width = 6), 
                         valueBoxOutput("OldestEmployee", width = 6)
                     )
                   ),
                   fluidRow(
                     box(width = 12, title = "Employees by Age", status = "primary", solidHeader = TRUE, 
                         plotlyOutput("EmployeesByAge", height = "200px"))
                   ),
                   fluidRow(
                     box(width = 12, title = "Employees by Age and Gender", status = "primary", solidHeader = TRUE, 
                         plotlyOutput("EmployeesByAgeAndGender"))
                   )
            ),
            column(width = 6,
              fluidRow(
                box(width = 12, title = "Employees by Marital Status", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("EmployeesByMarital", height = "350px"))
              ),
              fluidRow(
                box(width = 12, title = "Employees by Ethnicity and Average Salary", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("EmployeesEthnicitySalary"))
              )
            )
          )
        ),
        tabPanel("Performance Tracker", icon = icon("tachometer-alt"),
          fluidRow(
            column(width = 3,
              fluidRow(box(width = 12, selectInput("select_employee", "Select Employee", choices = ""))),
              fluidRow(box(width = 12, valueBoxOutput("StartDate", width = 12))),
              fluidRow(box(width = 12, valueBoxOutput("LastReview", width = 12))),
              fluidRow(box(width = 12, valueBoxOutput("NextReview", width = 12))),
              fluidRow(box(width = 12, radioButtons("legend_perf", " ", choices = c("Satisfaction", "Rating"), inline = TRUE), 
                           tableOutput("legend_perf_table")))
            ),
            column(width = 3,
                   fluidRow(
                     box(width = 12, title = "Job Satisfaction", status = "primary", solidHeader = TRUE, 
                         plotlyOutput("JobSatisfaction", height = "350px"))
                   ),
                   fluidRow(
                     box(width = 12, title = "Environment Satisfaction", status = "primary", solidHeader = TRUE, 
                         plotlyOutput("EnvironmentSatisfaction", height = "350px"))
                   )
            ),
            column(width = 3,
                   fluidRow(
                     box(width = 12, title = "Relationship Satisfaction", status = "primary", solidHeader = TRUE, 
                         plotlyOutput("RelationshipSatisfaction", height = "350px"))
                   ),
                   fluidRow(
                     box(width = 12, title = "Work Life Balance", status = "primary", solidHeader = TRUE, 
                         plotlyOutput("WorkLifeBalance", height = "350px"))
                   )     
            ),
            column(width = 3,
                   fluidRow(
                     box(width = 12, title = "Self Rating", status = "primary", solidHeader = TRUE, 
                         plotlyOutput("SelfRating", height = "350px"))
                   ),
                   fluidRow(
                     box(width = 12, title = "Manager Rating", status = "primary", solidHeader = TRUE, 
                         plotlyOutput("ManagerRating", height = "350px"))
                   )     
            )
          )       
        ),
        tabPanel("Attrition", icon = icon("sign-out-alt"),
          column(width = 6,
             fluidRow(box(width = 12, valueBoxOutput("GlobalAttrition2", width = 12))),
             fluidRow(
               box(width = 12, title = "% Attrition Rate by Department and Job Role", status = "primary", solidHeader = TRUE, 
                   plotlyOutput("AttritionByDepartJob"))
             ),
             fluidRow(
               box(width = 12, title = "Attrition by Hire Date", status = "primary", solidHeader = TRUE, 
                   plotlyOutput("AttritionByHireDate", height = "200px"))
             )
          ),
          column(width = 6,
             fluidRow(
               box(width = 12, title = "Attrition by Travel Frequency", status = "primary", solidHeader = TRUE, 
                   plotlyOutput("AttritionByTravel", height = "250px"))
             ),
             fluidRow(
               box(width = 12, title = "Attrition by Overtime Requirement", status = "primary", solidHeader = TRUE, 
                   plotlyOutput("AttritionRequirement", height = "200px"))
             ),
             fluidRow(
               box(width = 12, title = "% Attrition by Tenure", status = "primary", solidHeader = TRUE, 
                   plotlyOutput("AttritionByTenure", height = "250px"))
             )
          )
        ),
        tabPanel(
          "Read Me",
          icon = icon("book-open"),
          includeMarkdown("./readme/hr_analytics_dashboard.md")
        )
      )
    )
  )), after = 7 - 1)

