
# Ajouter les sorties ici

observeEvent(input$go, {
  df <- reactive({
    df_clean <- read.csv(input$file, header = input$header)
    df_clean <- df_clean[, !sapply(df_clean, is.character)]
    df_clean <- df_clean[complete.cases(df_clean), ]
    df_clean
  })
  # Essai
  output$dataframe <- renderDT({
    #input$go
    #isolate({
      #df()
      datatable(df(), rownames = FALSE, 
                extensions = 'Buttons', options = list(
                  dom = 'Bfrtip',
                  buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
                ),
                filter = 'top', style = 'bootstrap')
    #})
  })
  
  output$download_clean_data <- downloadHandler(
    filename <- function() {
      paste("clean_data_", Sys.Date(), ".csv", sep=",")
    },
    content <- function(file) {
      write.csv(df(), file)
    }
  )
  
  data <- reactive({
    
    if (input$scaled_met == 'Normalisation') {
      normalize(df())
    } else if (input$scaled_met == 'Standardisation') {
      as.data.frame(scale(df()))
    } else if (input$scaled_met == 'None') {
      df()
    }
    
  })
  
  # PCA Model
  
  model_pca <- reactive({
    prcomp(data(), scale = FALSE, center = FALSE)
  })
  
  # PCA Scree Plot
  
  output$pca_screeplot <- renderPlot({
    #input$go
    #isolate({
      fviz_screeplot(model_pca(), ncp = ncol(data()))
    #})
  })
  
  # PCA Biplot
  
  output$pca_biplot <- renderPlot({
    #input$go
    #isolate({
      plot(model_pca()$x[, 1:2])
    #})
  })
  
  # PCA Data
  
  output$table_pca <- renderDT({
    #input$go
    #isolate({
      #as.data.frame(model_pca()$x[, 1:input$first_cp])
      datatable(as.data.frame(model_pca()$x[, 1:input$first_cp]), 
                rownames = FALSE, 
                extensions = 'Buttons', options = list(
                  dom = 'Bfrtip',
                  buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
                ),
                filter = 'top', style = 'bootstrap')
    #})
  })
  
  # Save PCA Data
  
  output$save_pca_data <- downloadHandler(
    filename <- function() {
      paste("pca_data_", Sys.Date(), ".csv", sep=",")
    },
    content <- function(file) {
      write.csv(as.data.frame(model_pca()$x[, 1:input$first_cp]), file)
    }
  )
  
  # TSNE model
  model_tsne <- reactive({
    Rtsne(data(), pca = input$pca_tsne, dims = 2, 
          check_duplicates = FALSE, max_iter = input$n_iter)
  })
  
  # Costs Plot for TSNE
  
  output$tsne_costs_plot <- renderPlot({
    #input$go
    #isolate({
      plot(model_tsne()$costs, type = 'l', ylab = 'Costs')
    #})
  })
  
  # TSNE 2 dim data
  output$tsne_data <- renderDT({
    #input$go
    #isolate({
      ####
      datatable(data.frame(tsne_x = model_tsne()$Y[, 1], 
                           tsne_y =model_tsne()$Y[, 2]), 
                rownames = FALSE, 
                extensions = 'Buttons', options = list(
                  dom = 'Bfrtip',
                  buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
                ),
                filter = 'top', style = 'bootstrap')
      ####
      
    #})
  })
  
  # TSNE scatter plot
  output$tsne_biplot <- renderPlot({
    #input$go
    #isolate({
      plot(data.frame(tsne_x = model_tsne()$Y[, 1], 
                      tsne_y =model_tsne()$Y[, 2]))
    #})
  })
  
  # Save TSNE Data
  
  output$save_tsne_data <- downloadHandler(
    filename <- function() {
      paste("tsne_data_", Sys.Date(), ".csv", sep=",")
    },
    content <- function(file) {
      write.csv(data.frame(tsne_x = model_tsne()$Y[, 1], 
                           tsne_y =model_tsne()$Y[, 2]), file)
    }
  )
  
  
  output$scaled <- renderDT({
    
    #input$go
    #isolate({
      #####
      datatable(data(), 
                rownames = FALSE, 
                extensions = 'Buttons', options = list(
                  dom = 'Bfrtip',
                  buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
                ),
                filter = 'top', style = 'bootstrap')
      #####
      
    #})
    
  })
  
  output$download_stand_data <- downloadHandler(
    filename <- function() {
      paste("scaled_or_norm_data_", Sys.Date(), ".csv", sep=",")
    },
    content <- function(file) {
      write.csv(data(), file)
    }
  )
  
  output$elbow <- renderPlotly({
    #input$go
    #isolate({
      fviz_nbclust(data(), FUNcluster = kmeans, method = "wss")
    #})
  })
  
  output$silhouette <- renderPlotly({
    #input$go
    #isolate({
      fviz_nbclust(data(), FUNcluster = kmeans, method = "silhouette")
    #})
  })
  
  # K-Means Model
  
  model <- reactive({
    kmeans(data(), centers = input$n_clusters, nstart = 20)
  })
  
  data_selected <- reactive({
    cbind(data()[input$varx], data()[input$vary])
  })
  
  output$scatter_plot <- renderPlot({
    
    #input$go
    #isolate({
      plot(data_selected(), col = as.factor(model()$cluster), pch = 20, cex = 3)
    #})
    
  })
})

