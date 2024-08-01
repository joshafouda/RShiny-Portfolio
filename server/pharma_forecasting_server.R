
# Ajouter les sorties ici

# Dataframe réactive où se trouve les 5 meilleurs produits dans une même catégorie
getSalesData <- reactive({
  if(input$forecastmetric == "Quantity") {
    productdb %>%
      filter(BNFNAME %in% getTop5(input$categ)) %>%
      select(month, BNFNAME, QUANTITY) %>%
      rename(Month = month, Product = BNFNAME, Metric = QUANTITY)
  } else if(input$forecastmetric == "Sales Revenue") {
    productdb %>%
      filter(BNFNAME %in% getTop5(input$categ)) %>%
      select(month, BNFNAME, ACTCOST) %>%
      rename(Month = month, Product = BNFNAME, Metric = ACTCOST)
  }
})

# Graphique montrant les 5 meilleurs produits dans une même catégorie
output$top5plot <- renderPlotly({
  
  plot_ly(
    getSalesData(),
    x = ~ Month,
    y = ~ Metric,
    color = ~ Product,
    type = 'scatter',
    mode = 'lines',
    text = ~ paste("Product: ", Product)
  ) %>%
    layout(title = paste("Top 5 Products in the ", input$categ, "Category"))
  
})

# Dataframe filtrée du produit(médicament) sélectionné par l'utilisateur
getProdData <- reactive({
  if(input$forecastmetric == "Quantity") {
    productdb %>%
      filter(BNFNAME == input$prods) %>%
      mutate(Date = ymd(paste(month, "20", sep = "-"))) %>%
      select(month, QUANTITY, Date) %>%
      rename(Metric = QUANTITY)
  } else if(input$forecastmetric == "Sales Revenue") {
    productdb %>%
      filter(BNFNAME == input$prods) %>%
      mutate(Date = ymd(paste(month, "20", sep = "-"))) %>%
      select(month, ACTCOST, Date) %>%
      rename(Metric = ACTCOST)
  }
})

# Création d'un objet ts (Série temporelle du Produit sélectionné par l'utilisateur)
ts_data <- reactive({
  ts(
    data = getProdData()$Metric,
    start = c(year(min(getProdData()$Date)), month(min(getProdData()$Date))),
    frequency = 12
  )
})

# Affichage de la série temporelle du Produit sélectionné par l'utilisateur
output$actual_ts <- renderPlotly({
  if(input$decompose) {
    ts_decompose(ts_data())
  } else {
    ts_plot(ts_data(), title = input$prods)
  }
})

#Dataframe pour la prévision avec Facebook prophet
prophet_df <- reactive({
  getProdData() %>%
    select(Date, Metric) %>%
    rename(ds = Date, y = Metric)
})

# Modèle Prophet
md1 <- reactive({
  prophet(prophet_df())
})

# Modèle Auto Arima
md2 <- reactive({
  forecast(auto.arima(ts_data()))
})

# Modèle TBATS
md3 <- reactive({
  forecast(tbats(ts_data()))
})

# Modèle ETS
md4 <- reactive({
  forecast(ts_data())
})

# Modèle Holt-Winters
md5 <- reactive({
  forecast(HoltWinters(ts_data()))
})

# Affichage des prévisions dans un graphique
output$autoplotforecast <- renderPlot({
  # "Auto","Holt-Winters","TBATS","Auto ARIMA"
  if (input$forecastmodel == "fbpro"){
    plot(
      md1(),
      predict(
        md1(),
        make_future_dataframe(
          md1(),
          periods = 6, freq = "month"
        )
      )
    )
  } else if (input$forecastmodel == "autoarima"){
    autoplot(md2())
  } else if (input$forecastmodel == "tbats"){
    autoplot(md3())
  } else if (input$forecastmodel == "auto"){
    autoplot(md4())
  } else if (input$forecastmodel == "hw"){
    autoplot(md5())
  }
})

# Affichage des résultats de prévision dans une table
output$forecastdata <- renderDT({
  
  if (input$forecastmodel == "fbpro"){
    predict(
      md1(),
      make_future_dataframe(
        md1(),
        periods = input$horizon, freq = "month"
      )
    )
  } else if (input$forecastmodel == "autoarima"){
    as.data.frame(forecast(md2(), h = input$horizon))
  } else if (input$forecastmodel == "tbats"){
    as.data.frame(forecast(md3(), h = input$horizon))
  } else if (input$forecastmodel == "auto"){
    as.data.frame(forecast(md4(), h = input$horizon))
  } else if (input$forecastmodel == "hw"){
    as.data.frame(forecast(md5(), h = input$horizon))
  }
  
})