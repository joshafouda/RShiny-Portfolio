
# Ajouter les sorties ici

# Variable réactive qui indique les différents marchés boursiers
market <- reactive({
  if (input$indice == 'France (CAC 40)') {
    cac40_ticker_name$NameOfStock
  } else if (input$indice == 'England (FTSE 100)') {
    ftse100_ticker_name$NameOfStock
  } else if (input$indice == 'Japan (Nikkei 225)') {
    nikkei_ticker_name$NameOfStock
  } else if (input$indice == 'Germany (DAX)') {
    dax_ticker_name$NameOfStock
  } else {
    sp500_ticker_name$NameOfStock
  }
})

output$MarketControl <- renderUI({
  selectInput('stock', 'Choose an Asset', 
              choices = market())
})


# Importation des données
df <- reactive({
  
  stock_data <- getSymbols(
    str_split(input$stock, pattern = ",")[[1]][2], 
    auto.assign = F,
    from = as.Date(input$period[1]), 
    to = as.Date(input$period[2])
  )
  
  names(stock_data) <- c("Open", "High", "Low", 
                         "Close", "Volume", "Adjusted")
  
  stock_data
  
})


# Calcul des rendements
returns <- reactive({
  dailyReturn(df()$Adjusted)
})

observeEvent(input$go, {
  # Evolution des Prix/Rendements
  output$lineplot <- renderPlotly({
    
    if (input$parameter == 'Price') {
      p <- ggplot(df(), aes(x = index(df()))) + 
        geom_line(aes(y = Adjusted, color = "Close")) +
        geom_line(aes(y = SMA(Adjusted, n = input$short), color = "Short MA")) +
        geom_line(aes(y = SMA(Adjusted, n = input$long), color = "Long MA")) +
        labs(x = "Date", y = "Adjusted Closed Price", color = "Legend", 
             title = paste("Compagny Name:", 
                           str_split(input$stock, pattern = ",")[[1]][1], 
                           " SYMBOL:", str_split(input$stock, pattern = ",")[[1]][2])
        ) +
        scale_color_manual(values = colors) +
        theme_bw()
      
      ggplotly(p)
      
    } else {
      r <- ggplot(returns(), aes(x = index(df()))) + 
        geom_line(aes(y = daily.returns)) +
        labs(x = "Date", y = "Daily Returns", 
             title = paste("Compagny Name:", 
                           str_split(input$stock, pattern = ",")[[1]][1], 
                           " SYMBOL:", str_split(input$stock, pattern = ",")[[1]][2])
        ) +
        theme_bw() +
        theme(legend.position = "none") 
      
      ggplotly(r)
    }
    
  })
  
  
  # Boîte à moustache
  output$boxplot <- renderPlotly({
    if (input$parameter == 'Price') {
      box1 <- ggplot(df()) +
        geom_boxplot(aes(y = Adjusted, fill = "red")) +
        labs(y = "Adjusted Closed Price",
             title = paste("Compagny Name:", 
                           str_split(input$stock, pattern = ",")[[1]][1], 
                           " SYMBOL:", str_split(input$stock, pattern = ",")[[1]][2]),
        ) +
        theme_minimal() +
        theme(legend.position = "none")
      ggplotly(box1)
      
    } else {
      box2 <- ggplot(returns()) +
        geom_boxplot(aes(y = daily.returns, fill = "red")) +
        labs(y = "Daily Returns",
             title = paste("Compagny Name:", 
                           str_split(input$stock, pattern = ",")[[1]][1], 
                           " SYMBOL:", str_split(input$stock, pattern = ",")[[1]][2]),
        ) +
        theme_minimal() +
        theme(legend.position = "none")
      ggplotly(box2)
    }
  })
  
  
  # Histogramme
  output$hist <- renderPlotly({
    if (input$parameter == 'Price') {
      histo <- ggplot(df()) +
        geom_histogram(aes(x = Adjusted, fill = "red")) +
        labs(x = "Adjusted Closed Price",
             title = paste("Compagny Name:", 
                           str_split(input$stock, pattern = ",")[[1]][1], 
                           " SYMBOL:", str_split(input$stock, pattern = ",")[[1]][2]),
        ) +
        theme_minimal() +
        theme(legend.position = "none")
      ggplotly(histo)
      
    } else {
      histo2 <- ggplot(returns()) +
        geom_histogram(aes(x = daily.returns, fill = "red")) +
        labs(x = "Daily Returns",
             title = paste("Compagny Name:", 
                           str_split(input$stock, pattern = ",")[[1]][1], 
                           " SYMBOL:", str_split(input$stock, pattern = ",")[[1]][2]),
        ) +
        theme_minimal() +
        theme(legend.position = "none")
      ggplotly(histo2)
    }
  })
  
  
  # Tableau des données à montrer 
  data_to_show <- reactive({
    if (input$parameter == 'Price') {
      df()
    } else {
      returns()
    }
  })
  
  
  output$StockData <- renderDT({
    if (input$ShowData) {
      datatable(
        as.data.frame(data_to_show()),
        extensions = 'Buttons', 
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          pageLength = input$Nrows
        ),
        style = "bootstrap", rownames = T
      )
    } else {
      NULL
    }
  })
})




# chartSeries
output$Chart <- renderPlot({
  chartSeries(
    df(),
    subset = as.character(input$yearsubset),
    TA = c(addBBands(), addRSI(), addEMA(), addMACD()),
    theme = chartTheme("black"),
    name = paste("Compagny Name:", 
                 str_split(input$stock, pattern = ",")[[1]][1], 
                 " SYMBOL:", str_split(input$stock, pattern = ",")[[1]][2])
  )
})