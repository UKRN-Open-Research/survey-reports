# Open Research Training Survey Reports
Automatically generate summary reports of UKRN Open Research Training survey data.

## Project / file structure
The R Project should be set up as follows:

survey-reports.Rproj
    / code /
        / data /
            2021-03-12_Open_Research_Survey_Data_Sheet.csv
            2021-03-12_Open_Research_Survey_Data_Dictionary.csv
        / data-helpers /
            colOrder.csv
            mrcTaxonomy.csv
        / functions /
            format_leadership.R
            format_priority.R
            format_priority_training.R
            format_training.R
            plots.R
            read_survey.R
        data.cleaning.R
        render-report.R
        survey-report.Rmd
    / output /
        survey_report_alldata.html
        survey_report_Babrahamdata.html
        survey_report_Bristoldata.html
        survey_report_MRCdata.html
.gitignore
LICENSE.md
README.md

| File name                                           | Description                                                                      |
| --------------------------------------------------- | -------------------------------------------------------------------------------- |
| survey-reports.Rproj                                | R Project file                                                                   |
| 2021-03-12_Open_Research_Survey_Data_Sheet.csv      | Cleaned survey data                                                              |
| 2021-03-12_Open_Research_Survey_Data_Dictionary.csv | Metadata for data sheet                                                          |
| colOrder.csv                                        | For data cleaning only. Assigns clean, easy to read column names                 |
| mrcTaxonomy.csv                                     | For data cleaning only. Assigns MRC research domain to each MRC-funded institute |
| format_leadership.R                                 | Function for generating report. Formats data for Figure 1                        |
| format_priority.R                                   | Function for generating report. Formats data for Figure 5                        |
| format_priority_training.R                          | Function for generating report. Formats data for Figure 6                        |
| format_training.R                                   | Function for generating report. Formats training data (Figure 3 + 4)             |
| plots.R                                             | Function for generating report. Formats plots                                    |
| read_survey.R                                       | Function for data cleaning only. Reads in raw survey data                        |
| data.cleaning.R                                     | Code to merge raw survey data and format for deposit in data.bris                |
| render-report.R                                     | Code to render the RMarkdown report (use this instead of knit to HTML button)    |
| survey-report.Rmd                                   | RMarkdown report code  . Outputs to HTML                                         |
| survey_report_alldata.html                          | HTML report generated from running all data (`choose == "all`)                   |
| survey_report_Babrahamdata.html                     | HTML report generated from running all data (`choose == "babraham`)              |
| survey_report_Bristoldata.html                      | HTML report generated from running all data (`choose == "uob`)                   |
| survey_report_MRCdata.html                          | HTML report generated from running all data (`choose == "mrc`)                   |
| .gitignore                                          | Specifies files GitHub should ignore                                             |
| LICENSE.md                                          | License for code (CC-BY)                                                         |
| README.md                                           | README for Project (this file)                                                   |

## Generating reports
Use the file `/ code / render_report.R` to knit the RMarkdown file `/ code / survey_report.Rmd` to HTML. Four different reports can be generated from the same RMarkdown file depending on which data is of interest. In `/ code / render_report.R` use `choose <- c("all", "mrc", "uob", "babraham")[1]` where `1` is the index number of the character string in the vector `choose`, to determine which data you would like the report to display.

  * `choose == "all"` generates a report of all data
  * `choose == "mrc"` generates a report of data from researchers working at Medical Research Council (MRC)-funded institutes only
  * `choose == "uob"` generates a report of data from researchers working at The University of Bristol only
  * `choose == "babraham"` generates a report of data from researchers working at The Babraham Institute only
  
It is important to note that researchers from the MRC Integrative Epidemiology Unit at the University of Bristol (MRC IEU) are categorised as University of Bristol researchers, as opposed to MRC researchers. You can see how this was done using the code in `/ code / datacleaning.R` and `/ code / functions / read_survey.R`.
