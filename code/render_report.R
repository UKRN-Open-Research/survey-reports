# Load library
library(rmarkdown)

# Set code directory
code_dir <- "code" 
# Enter name of report to render and generate filepath
report_filename <- "survey_report.Rmd"
report_filename <- file.path(code_dir, report_filename)

# Create output directory
dir.create("output")
# Set output directory and generate file path
output_dir <- "output"
output <- file.path("..",output_dir)

# Choose the data to run the report on
choose <- c("all", "mrc", "uob", "babraham")[1]

# Conditionally generate output file name
if(choose == "all"){
  
  output_filename <- "survey_report_alldata.html"
  
} else if(choose == "mrc"){
  
  output_filename <- "survey_report_MRCdata.html"
  
} else if(choose == "uob"){
  
  output_filename <- "survey_report_Bristoldata.html"
  
} else if(choose == "babraham"){
  
  output_filename <- "survey_report_Babrahamdata.html"
  
}

# Generate html report
render(report_filename, output_dir = output_dir, params = list(output_dir = output), output_file = output_filename)
