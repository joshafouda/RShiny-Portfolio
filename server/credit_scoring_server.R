
# Ajouter les sorties ici

observeEvent(input$go, {
  
  # Create a connection from the URL
  url_model_connection <- url("https://raw.githubusercontent.com/joshafouda/data_formations/main/credit_scoring_rf_model.rds", "rb")
  
  # Read the RDS file from the URL
  model <- readRDS(url_model_connection)
  
  # Close the connection
  close(url_model_connection)
  
  new_data <- reactive({
    data.frame(
      "person_age" = input$var1,
      "person_income" = input$var2,
      "person_home_ownership" = input$var3,
      "person_emp_length" = input$var4,
      "loan_intent" = input$var5,
      "loan_grade" = input$var6,
      "loan_amnt" = input$var7,
      "loan_int_rate" = input$var8,
      "loan_percent_income" = input$var9,
      "cb_person_default_on_file" = input$var10,
      "cb_person_cred_hist_length" = input$var11
    )
  })
  
  prediction <- reactive({
    predict(model, newdata = new_data())
  })
  
  
  prediction_label <- reactive({
    ifelse(prediction() == "0", "Eligible au Crédit", "Non Eligible au Crédit")
  })
  
  
  prediction_prob <- reactive({
    predict(model, newdata = new_data(), type = "prob")
  })
  
  
  prediction_color <- reactive({
    ifelse(prediction() == "0", "green", "red")
  })
  

  output$score_prediction <- renderValueBox({
    
    valueBox(
      value = paste(round(100*prediction_prob()$`1`, 1), "%"),
      subtitle = prediction_label(),
      color = prediction_color(),
      icon = icon("hand-holding-usd")
    )
    
  })
})