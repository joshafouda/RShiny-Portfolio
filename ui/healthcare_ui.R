
# identification interne tabItem (ne pas modifier)
nom_tab <- "tabItem_healthcare"

# Ajout menu ITEM
liste_menuitems <- append(liste_menuitems, list(menuItem("Healthcare Dashboard", tabName = nom_tab, icon = icon("medkit"))), after = 5 - 1)

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab, # identification interne du panneau
    fluidRow(
      tabsetPanel(
        # tabPanel("Home", icon = icon("home"),
        #    
        # ),
        tabPanel("Hospital Profile", icon = icon("hospital"),
           fluidRow(
             column(width = 4,
               box(width = 12, selectInput("hospital_name", "Select a Hospital:", 
                                           choices = unique(hospital$facility_name), 
                                           selected = "Westchester Medical Center"))
             ),
             column(width = 8,
               uiOutput("hospitalProfileText")
             )
           ),
           fluidRow(
             column(width = 4,
               fluidRow(
                 box(width = 12,
                     valueBoxOutput("AvgLOS", width = 6), 
                     valueBoxOutput("AvgLOSAll", width = 6)
                 )
               ),
               fluidRow(
                 box(width = 12,
                     valueBoxOutput("AvgCost", width = 6), 
                     valueBoxOutput("AvgCostAll", width = 6)
                 )
               ),
               fluidRow(
                 box(width = 12,
                     valueBoxOutput("ReadmissionRate", width = 6), 
                     valueBoxOutput("ReadmissionRateAll", width = 6)
                 )
               ),
               fluidRow(
                 box(width = 12,
                     valueBoxOutput("MortalityRate", width = 6), 
                     valueBoxOutput("MortalityRateAll", width = 6)
                 )
               ),
               fluidRow(
                 box(width = 12,
                     valueBoxOutput("TotalDisch", width = 6), 
                     valueBoxOutput("TotalDischAll", width = 6)
                 )
               ),
               fluidRow(
                 box(width = 12,
                     valueBoxOutput("TotalReadmi", width = 6), 
                     valueBoxOutput("TotalReadmiAll", width = 6)
                 )
               )
             ),
             column(width = 4,
                fluidRow(
                  box(width = 12, title = "Total Discharges by Severity Level of the disease", status = "primary", solidHeader = TRUE, 
                      plotlyOutput("SeverityPlot")),
                  box(width = 12, title = "Total Discharges by Mortality Risk Level", status = "primary", solidHeader = TRUE, 
                      plotlyOutput("MortalityRiskPlot"))
                )     
             ),
             column(width = 4,
                fluidRow(
                  box(width = 12, title = "Total Discharges by Diagnostic Description", status = "primary", solidHeader = TRUE, 
                      plotlyOutput("DiagnosisPlot")),
                  box(width = 12, title = "Total Discharges by Patient Status at Discharge", status = "primary", solidHeader = TRUE, 
                      plotlyOutput("PatientDispositionPlot"))
                )   
             )
           )
        ),
        tabPanel("LOS and Cost Comparison", icon = icon("bar-chart"),
                 fluidRow(
                   column(
                     width = 3,
                     box(width = 12, selectInput("health_service_area", "Health Service Area:", 
                                                 choices = c("All", unique(hospital$health_service_area))))
                   ),
                   column(width = 9,
                          box(width = 12,
                              valueBoxOutput("TotalSurgeons", width = 3), 
                              valueBoxOutput("AverageLOSDays", width = 3), 
                              valueBoxOutput("TotalHospitals", width = 3), 
                              valueBoxOutput("TotalDischarges", width = 3)
                          )
                   )
                   
                 ),
                 fluidRow(
                   column(width = 7,
                          box(width = 12, title = "Average LOS Days and Total Discharges by top 15 Hospitals", status = "primary", solidHeader = TRUE, 
                              plotlyOutput("AvgLOSdaysTotalDischPlot", height = "400px"))
                   ),
                   column(width = 5,
                          fluidRow(
                            box(width = 12, title = "Top 3: Highest Avg LOS Days", status = "primary", solidHeader = TRUE, 
                                plotlyOutput("HighAvgLOSPlot", height = "150px")),
                            box(width = 12, title = "Bottom 3: Lowest Avg LOS Days", status = "primary", solidHeader = TRUE, 
                                plotlyOutput("LowAvgLOSPlot", height = "150px"))
                          )
                   )
                 ),
                 fluidRow(
                   column(width = 7,
                          box(width = 12, title = "Average LOS vs Average Cost per Discharge by Hospital", status = "primary", solidHeader = TRUE, 
                              plotlyOutput("ScatterPlot", height = "400px"))
                   ),
                   column(width = 5,
                          fluidRow(
                            box(width = 12, title = "Top 3: Highest Avg Cost per Discharge", status = "primary", solidHeader = TRUE, 
                                plotlyOutput("HighAvgCostPlot", height = "150px")),
                            box(width = 12, title = "Bottom 3: Lowest Avg Cost per Discharge", status = "primary", solidHeader = TRUE, 
                                plotlyOutput("LowAvgCostPlot", height = "150px"))
                          )
                   )
                 )
        ),
        tabPanel(
          "Read Me",
          icon = icon("book-open"),
          includeMarkdown("./readme/healthcare_dashboard.md")
        )
      )
    )
  )), after = 5 - 1)

