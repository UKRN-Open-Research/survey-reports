format_priority <- function(df){
  
  # Subset responses to priority questions
  df = df %>%
    select(Priority_OpenAccess, Priority_OpenCode, Priority_DataSharing, Priority_Preprints, Priority_Preregistration, randomID) %>%
    mutate_if(is.integer, as.character) %>%
    filter(!is.na(Priority_OpenAccess))
  
  # Group those ranked 6-8
  df$Priority_OpenAccess <- sub("6|7|8", "6-8", df$Priority_OpenAccess)
  df$Priority_OpenCode <- sub("6|7|8", "6-8", df$Priority_OpenCode)
  df$Priority_DataSharing <- sub("6|7|8", "6-8", df$Priority_DataSharing)
  df$Priority_Preprints <- sub("6|7|8", "6-8", df$Priority_Preprints)
  df$Priority_Preregistration <- sub("6|7|8", "6-8", df$Priority_Preregistration)
  
  # Wide to long format for plotting
  df = df %>%
    pivot_longer(!randomID, names_to = "OR_Area", values_to = "Rank")
  
  # Remove prefix
  df$OR_Area <- sub("Priority_", "", df$OR_Area)
  
  # Factor levels
  df$Rank <- factor(df$Rank,
                    levels = c("6-8",
                               "5",
                               "4",
                               "3",
                               "2",
                               "1"))
  
  return(df)
  
}