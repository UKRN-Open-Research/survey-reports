# Open Research Training Survey Reports
Automatically generate summary reports of UKRN Open Research Training survey data.

## Scripts and other files

| File / folder name  | Description                                                                     |
| ------------------- | ------------------------------------------------------------------------------- |
| datacleaning.R      | R script for merging and cleaning raw survey data prior to upload at data.bris  |
| data-helpers        | Folder containing csv files to help with data cleaning                          |
| survey_report.Rmd   | RMarkdown file used to generate a report of clean data. Outputs HTML            |
| functions           | Folder containing R scripts used to clean or transform data for analysis        |

## Generating reports
This code allows the generation of four reports from the same RMarkdown file. You can select which report you would like to generate using `choose <- c("all", "mrc", "uob", "babraham")[1]` where `1` is the index number of the character string in the vector `choose`.

  * `choose == "all"` generates a report of all data
  * `choose == "mrc"` generates a report of data from researchers working at Medical Research Council (MRC)-funded institutes only
  * `choose == "uob"` generates a report of data from researchers working at The University of Bristol only
  * `choose == "babraham"` generates a report of data from researchers working at The Babraham Institute only
  
It is important to note that researchers from the MRC Integrative Epidemiology Unit at the University of Bristol (MRC IEU) are categorised as University of Bristol researchers, as opposed to MRC researchers. You can see how this was done using the code in `datacleaning.R` and `functions/read_survey.R`.