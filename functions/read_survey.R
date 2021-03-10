# Assumes only latest data in in data-latest folder
read_survey <- function(path, pattern){
  
  fp = paste0(path, "/", list.files(path = path, pattern = pattern))
  df =  read.delim(fp, skip = 3, header = F, stringsAsFactors = FALSE, fileEncoding = 'UTF-16LE', na.strings = c("", NA)) %>%
    mutate(Unit = pattern)
  
  # Babraham data has one less column
  if(df$Unit == "Babraham"){
    df = df %>%
      mutate(Q2.1 = "Babraham") %>%
      select(1:11, 43, 12:42)
    
    # Tidy column names added
    colnames(df) <- col_order$cleanText
  } else{
    colnames(df) <- col_order$cleanText
  }
  
  # Remove trailing white space from Primary column
  df$Primary = trimws(df$Primary, which = "right", whitespace = "[ \t\r\n]")
  
  # Remove previews, incomplete and spam from responses
  df = df %>% filter(Progress == 100 & Status != "Survey Preview" & Status != "Spam")
  
  # Change MRC data from Bristol school to UoB
  df = df %>%
    mutate(Unit = ifelse(Primary == "MRC Integrative Epidemiology Unit at the University of Bristol (MRC IEU)", "UoB", Unit))
  
  # Format UoB list rest
  df$Primary <- sub("MRC Integrative Epidemiology Unit at the University of Bristol \\(MRC IEU\\)", "Health Sciences - Population Health Sciences", df$Primary)
  
  # Add MRC taxonomy column
  if(df$Unit == "MRC"){
    df = df %>%
      merge(mrc_group, by = "Primary", all.x = TRUE) %>%
      select(2:12, 1, 13:44) %>%
      rename(MRC_Taxonomy = UnitClean)
  } else{
    df = df %>%
      mutate(MRC_Taxonomy = NA)
  }
  
  # Format research discipline
  df = df %>%
    mutate(Discipline = NA) %>%
    mutate(Discipline = ifelse(MRC_Taxonomy == "Physiological Systems" | MRC_Taxonomy == "Molecular and Cellular" | Primary == "Babraham" | Primary == "Life Sciences - School of Biological Sciences" | Primary == "Life Sciences - School of Biochemistry" | Primary == "Life Sciences - School of Psychological Science", "Life Sciences",
                               ifelse(MRC_Taxonomy == "Population and Public Health" | Primary == "Health Sciences - Translational Health Sciences" | Primary == "Health Sciences - Bristol Medical School" | Primary == "Health Sciences - Bristol Dental School" | Primary == "Health Sciences - Bristol Veterinary School" | Primary == "Health Sciences - Population Health Sciences", "Health Sciences", NA)))
  
  return(df)
}