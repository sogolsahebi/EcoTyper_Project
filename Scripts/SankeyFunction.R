
# Load the summary table
# Ensure the table has the following columns: Dataset, Cancer_Type, Clinical_Endpoints, Patients, Treatments

# Example structure of `summary_table`:
# Dataset                        Cancer_Type  Clinical_Endpoints      Patients  Treatments
# 1     Ascierto__Kidney__PD-(L)1      Kidney  Response (R vs NR)         11     PD-1/PD-L1
# 2    Auslander__Melanoma__CTLA4    Melanoma  Response (R vs NR)          6           CTLA4
# 3 Auslander__Melanoma__IO+combo    Melanoma  Response (R vs NR)          4        IO+combo
# 4  Auslander__Melanoma__PD-(L)1    Melanoma  Response (R vs NR)         27     PD-1/PD-L1
# 5     Cloughesy__Brain__PD-(L)1       Brain              PFS/OS         28     PD-1/PD-L1
# 6    Damrauer__Bladder__PD-(L)1     Bladder              PFS/OS         90     PD-1/PD-L1


# Function to generate a Sankey diagram with percentages and save it
generate_and_save_sankey <- function(data) {
  library(networkD3)
  library(dplyr)
  
  # Calculate total patients
  total_patients <- sum(data$Patients, na.rm = TRUE)
  
  # Summarize data for Sankey diagram
  summary_sankey <- data %>%
    group_by(Cancer_Type, Treatments, Clinical_Endpoints) %>%
    summarise(Total_Patients = sum(Patients, na.rm = TRUE), .groups = "drop")
  
  # Prepare Nodes with counts and percentages
  nodes <- data.frame(
    name = c(
      paste0("Total Patients\n(n=", total_patients, ", 100%)"),
      paste0(unique(summary_sankey$Cancer_Type), "\n(n=", 
             sapply(unique(summary_sankey$Cancer_Type), function(ct) sum(summary_sankey$Total_Patients[summary_sankey$Cancer_Type == ct])), 
             ", ", 
             round(sapply(unique(summary_sankey$Cancer_Type), function(ct) 
               sum(summary_sankey$Total_Patients[summary_sankey$Cancer_Type == ct]) / total_patients * 100), 2), 
             "%)"),
      paste0(unique(summary_sankey$Treatments), "\n(n=", 
             sapply(unique(summary_sankey$Treatments), function(t) sum(summary_sankey$Total_Patients[summary_sankey$Treatments == t])), 
             ", ", 
             round(sapply(unique(summary_sankey$Treatments), function(t) 
               sum(summary_sankey$Total_Patients[summary_sankey$Treatments == t]) / total_patients * 100), 2), 
             "%)"),
      paste0(unique(summary_sankey$Clinical_Endpoints), "\n(n=", 
             sapply(unique(summary_sankey$Clinical_Endpoints), function(ce) sum(summary_sankey$Total_Patients[summary_sankey$Clinical_Endpoints == ce])), 
             ", ", 
             round(sapply(unique(summary_sankey$Clinical_Endpoints), function(ce) 
               sum(summary_sankey$Total_Patients[summary_sankey$Clinical_Endpoints == ce]) / total_patients * 100), 2), 
             "%)")
    )
  )
  
  # Prepare Links
  # First layer: Total Patients to Cancer Types
  links <- summary_sankey %>%
    group_by(Cancer_Type) %>%
    summarise(Total_Patients = sum(Total_Patients)) %>%
    mutate(
      source = 0, # First node (Total Patients)
      target = match(paste0(Cancer_Type, "\n(n=", 
                            sapply(Cancer_Type, function(ct) sum(summary_sankey$Total_Patients[summary_sankey$Cancer_Type == ct])), 
                            ", ", 
                            round(sapply(Cancer_Type, function(ct) 
                              sum(summary_sankey$Total_Patients[summary_sankey$Cancer_Type == ct]) / total_patients * 100), 2), 
                            "%)"), nodes$name) - 1,
      value = Total_Patients
    ) %>%
    select(source, target, value)
  
  # Second layer: Cancer Types to Treatments
  links <- links %>%
    bind_rows(
      summary_sankey %>%
        mutate(
          source = match(paste0(Cancer_Type, "\n(n=", 
                                sapply(Cancer_Type, function(ct) sum(summary_sankey$Total_Patients[summary_sankey$Cancer_Type == ct])), 
                                ", ", 
                                round(sapply(Cancer_Type, function(ct) 
                                  sum(summary_sankey$Total_Patients[summary_sankey$Cancer_Type == ct]) / total_patients * 100), 2), 
                                "%)"), nodes$name) - 1,
          target = match(paste0(Treatments, "\n(n=", 
                                sapply(Treatments, function(t) sum(summary_sankey$Total_Patients[summary_sankey$Treatments == t])), 
                                ", ", 
                                round(sapply(Treatments, function(t) 
                                  sum(summary_sankey$Total_Patients[summary_sankey$Treatments == t]) / total_patients * 100), 2), 
                                "%)"), nodes$name) - 1,
          value = Total_Patients
        ) %>%
        select(source, target, value)
    )
  
  # Third layer: Treatments to Clinical Endpoints
  links <- links %>%
    bind_rows(
      summary_sankey %>%
        mutate(
          source = match(paste0(Treatments, "\n(n=", 
                                sapply(Treatments, function(t) sum(summary_sankey$Total_Patients[summary_sankey$Treatments == t])), 
                                ", ", 
                                round(sapply(Treatments, function(t) 
                                  sum(summary_sankey$Total_Patients[summary_sankey$Treatments == t]) / total_patients * 100), 2), 
                                "%)"), nodes$name) - 1,
          target = match(paste0(Clinical_Endpoints, "\n(n=", 
                                sapply(Clinical_Endpoints, function(ce) sum(summary_sankey$Total_Patients[summary_sankey$Clinical_Endpoints == ce])), 
                                ", ", 
                                round(sapply(Clinical_Endpoints, function(ce) 
                                  sum(summary_sankey$Total_Patients[summary_sankey$Clinical_Endpoints == ce]) / total_patients * 100), 2), 
                                "%)"), nodes$name) - 1,
          value = Total_Patients
        ) %>%
        select(source, target, value)
    )
  
  # Create Sankey Diagram
  sankey <- sankeyNetwork(
    Links = links, Nodes = nodes,
    Source = "source", Target = "target",
    Value = "value", NodeID = "name",
    units = "Patients", fontSize = 12, nodeWidth = 30,
    nodePadding = 10
  )
  
  # Save the Sankey Diagram
  saveNetwork(sankey, file = output_path)
  
  # Return the Sankey Diagram
  return(sankey)
}

# Usage Example
sankey_before <- generate_and_save_sankey(summary_table)
sankey_after <- generate_and_save_sankey(summary_table_after)

# Display the Sankey diagrams
sankey_before
sankey_after


# saveNetwork(sankey_befor, file = "~/BHK lab/EcoTyper_Project/outputs/Dataprocessing_outputs/Plots/Sankey_Cancer_Treatments_Endpoints_Before.html")
# saveNetwork(sankey_after, file = "~/BHK lab/EcoTyper_Project/outputs/Dataprocessing_outputs/Plots/Sankey_Cancer_Treatments_Endpoints_After.html")