format_leadership <- function(df, MajorLeadershipRole){
  
  # Mutate new column
  df <- mutate(df, Leadership = MajorLeadershipRole)
  
  # Replace NA
  df$Discipline <- as.character(df$Discipline)
  df$Discipline[is.na(df$Discipline)] <- "Not Reported"
  
  # Replace NA
  df$MRC_Taxonomy <- as.character(df$MRC_Taxonomy)
  df$MRC_Taxonomy[is.na(df$MRC_Taxonomy)] <- "Not Reported"
  
  # Replace NA
  df$Leadership <- as.character(df$Leadership)
  df$Leadership[is.na(df$Leadership)] <- "Not Reported"
  
  # Group
  df$Leadership <- sub("I do not have a major leadership role,Other", "No", df$Leadership)
  df$Leadership <- sub("I do not have a major leadership role", "No", df$Leadership)
  df$Leadership <- sub("I run a lab or group,I direct the organisation", "Yes", df$Leadership)
  df$Leadership <- sub("I run a lab or group,Other", "Yes", df$Leadership)
  df$Leadership <- sub("I run a lab or group", "Yes", df$Leadership)
  df$Leadership <- sub("I direct the School", "Yes", df$Leadership)
  df$Leadership <- sub("I direct the organisation", "Yes", df$Leadership)
  df$Leadership <- sub("Other", "Yes", df$Leadership)
  df$Leadership <- sub("Not Reported", "No", df$Leadership)
  
  # Change factor levels
  df$Leadership <- factor(df$Leadership,
                          levels = c("Yes",
                                     "No"))
  
  # Set levels for MRC
  if (choose == "mrc"){
    df$MRC_Taxonomy <- factor(df$MRC_Taxonomy,
                               levels = c("Molecular and Cellular",
                                          "Physiological Systems",
                                          "Population and Public Health",
                                          "Not Reported"))
  }
  
  return(df)
  
}