format_priority <- function(df){
  
  # Subset responses to priority questions
  df = df %>%
    select(Priority_OpenAccess, Priority_OpenCode, Priority_OpenData, Priority_Preprints, Priority_Preregistration, Priority_Other1, Priority_Other1_TEXT, Priority_Other2, Priority_Other2_TEXT, Priority_Other3, Priority_Other3_TEXT, Other_Description_TEXT) %>%
    mutate_if(is.integer, as.character) %>%
    filter(!is.na(Priority_OpenAccess))
  
  # Create vector of OR Areas
  priority_areas <- c("OpenAccess", "OpenCode", "OpenData", "Preprints", "Preregistration")
  # Replicate
  priority_areas <- c(rep(priority_areas, each=6))
  
  # Create vector of ranks (6-8 are grouped)
  priority_rank <- c("1","2","3","4","5","6-8")
  #replicate
  priority_rank <- c(priority_rank,priority_rank,priority_rank,priority_rank,priority_rank)
  
  #Create vector of counts
  priority_count <- c(nrow(filter(df, Priority_OpenAccess == 1)),
                      nrow(filter(df, Priority_OpenAccess == 2)),
                      nrow(filter(df, Priority_OpenAccess == 3)),
                      nrow(filter(df, Priority_OpenAccess == 4)),
                      nrow(filter(df, Priority_OpenAccess == 5)),
                      nrow(filter(df, Priority_OpenAccess >= 6)),
                      nrow(filter(df, Priority_OpenCode == 1)),
                      nrow(filter(df, Priority_OpenCode == 2)),
                      nrow(filter(df, Priority_OpenCode == 3)),
                      nrow(filter(df, Priority_OpenCode == 4)),
                      nrow(filter(df, Priority_OpenCode == 5)),
                      nrow(filter(df, Priority_OpenCode >= 6)),
                      nrow(filter(df, Priority_OpenData == 1)),
                      nrow(filter(df, Priority_OpenData == 2)),
                      nrow(filter(df, Priority_OpenData == 3)),
                      nrow(filter(df, Priority_OpenData == 4)),
                      nrow(filter(df, Priority_OpenData == 5)),
                      nrow(filter(df, Priority_OpenData >= 6)),
                      nrow(filter(df, Priority_Preprints == 1)),
                      nrow(filter(df, Priority_Preprints == 2)),
                      nrow(filter(df, Priority_Preprints == 3)),
                      nrow(filter(df, Priority_Preprints == 4)),
                      nrow(filter(df, Priority_Preprints == 5)),
                      nrow(filter(df, Priority_Preprints >= 6)),
                      nrow(filter(df, Priority_Preregistration == 1)),
                      nrow(filter(df, Priority_Preregistration == 2)),
                      nrow(filter(df, Priority_Preregistration == 3)),
                      nrow(filter(df, Priority_Preregistration == 4)),
                      nrow(filter(df, Priority_Preregistration == 5)),
                      nrow(filter(df, Priority_Preregistration >= 6)))
  
  # Bind vectors into dataframe
  priority_main <- data.frame(priority_areas, priority_rank, priority_count)
  
  return(priority_main)
  
}
