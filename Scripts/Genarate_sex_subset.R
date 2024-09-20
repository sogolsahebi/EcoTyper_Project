library(SummarizedExperiment)

# Define the output directory
output_dir <- "data_sex/"

# Ensure the output directory exists
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# List all .rda files in the data_dir
files <- list.files(path = "data/", pattern = "\\.rda$", full.names = TRUE)

# Loop through each .rda file
for (file in files) {

  # Load the file (assuming it loads a single object into the environment)
  obj_name <- load(file)
  obj <- get(obj_name)

  # Convert colData to a data frame
  clin <- as.data.frame(colData(obj))

  # Extract the base name without the .rda extension
  base_name <- sub("\\.rda$", "", basename(file))

  # Check if 'sex' column exists and if it has any non-NA values
  if (!all(is.na(clin$sex))) {

    # Filter female patients
    clin_F <- clin[clin$sex == "F",]

    # If clin_F is not empty, save it
    if (nrow(clin_F) > 0) {
      # Construct a new file name for females with the full base name
      new_file_F <- paste0(output_dir, base_name, "_F.rda")
      save(clin_F, file = new_file_F)
    }

    # Filter male patients
    clin_M <- clin[clin$sex == "M",]

    # If clin_M is not empty, save it
    if (nrow(clin_M) > 0) {
      # Construct a new file name for males with the full base name
      new_file_M <- paste0(output_dir, base_name, "_M.rda")
      save(clin_M, file = new_file_M)
    }

  }

}
