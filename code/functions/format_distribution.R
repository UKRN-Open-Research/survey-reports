format_distribution <- function(df, pattern){
  
  # Create dataframe of responses to each topic
  df = df %>%
    select(Primary, Unit, OpenAccess, OpenCode, OpenData, Preprints, Preregistration) %>%
    mutate_at(c(2:6), ~replace(., is.na(.), 0)) # Replace any NAs with 0 so it doesn't affect count
  
  # Replace any cell containing pattern with the string "COUNT"
  df[] = lapply(df, function(x) replace(x, grep(pattern = pattern, x), "COUNT"))
  
  # Create column for sum of counts
  df$count = rowSums(df == "COUNT")
  
  # Select only count column
  df = select(df, Primary, Unit, count)
  
  return(df)
  
}