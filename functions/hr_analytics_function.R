
# Ajouter les fonctions spécifiques à l'application ici


# Function to plot data based on department
plot_department_data <- function(data, department) {
  dept_data <- filter(data, Department == department)
  
  if (department %in% c("Human Resources", "Sales")) {
    # Create a donut chart for Human Resources or Sales
    plot <- plot_ly(dept_data, labels = ~JobRole, values = ~nb_employees, type = 'pie', hole = 0.4,
                    textinfo = 'label+percent', insidetextorientation = 'radial'
                    ) %>%
      layout(title = paste('Distribution of Employees in', department, "by Job Role"),
             showlegend = TRUE)
  } else if (department == "Technology") {
    # Create an ordered bar chart for Technology
    plot <- plot_ly(dept_data, x = ~reorder(JobRole, -nb_employees), y = ~nb_employees, type = 'bar',
                    marker = list(color = 'rgba(55, 128, 191, 0.7)')
                    #text = ~nb_employees, textposition = 'auto'
                    ) %>%
      layout(title = 'Number of Employees in Technology by Job Role',
             xaxis = list(title = 'Job Role'),
             yaxis = list(title = 'Number of Employees'))
  }
  
  return(plot)
}


state_codes_to_names <- function(code) {
  state.name[match(tolower(code), tolower(state.abb))]
}

