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
  
  # Add MRC taxonomy to replace Primary column
  if(df$Unit == "MRC"){
    df = df %>%
      merge(mrc_group, by = "Primary", all.x = TRUE) %>%
      select(2:12, 44, 13:43) %>%
      rename(Primary = UnitClean)
  }
  
  # Remove previews, incomplete or spam from responses
  df = df %>% filter(Progress == 100 & Status != "Survey Preview" & Status != "Spam")
  
  return(df)
}