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
  if(df$Unit == "MRC"){
    df = df %>%
      mutate(Unit = ifelse(Primary == "MRC Integrative Epidemiology Unit at the University of Bristol (MRC IEU)", "UoB", Unit))
    df$Unit[is.na(df$Unit)] <- "MRC"
  }
  
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
  if(pattern == "MRC"){
    df = df %>%
      mutate(Discipline = ifelse(Unit == "MRC", MRC_Taxonomy, Primary))
  } else if(pattern == "UoB"){
    df = df %>%
      mutate(Discipline = Primary)
  } else if(pattern == "Babraham"){
    df = df %>%
      mutate(Discipline = "Life Sciences")
  } else{
    df = df %>%
      mutate(Discipline = "ERROR")
  }
  
  df$Discipline <- replace(df$Discipline, grep("Life Sciences", df$Discipline), "Life Sciences")
  df$Discipline <- replace(df$Discipline, grep("Health Sciences", df$Discipline), "Health Sciences")
  df$Discipline <- replace(df$Discipline, grep("Physiological Systems", df$Discipline), "Life Sciences")
  df$Discipline <- replace(df$Discipline, grep("Molecular and Cellular", df$Discipline), "Life Sciences")
  df$Discipline <- replace(df$Discipline, grep("Population and Public Health", df$Discipline), "Health Sciences")
  
  return(df)
}