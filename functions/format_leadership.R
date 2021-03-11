format_leadership <- function(df, MajorLeadershipRole){
  
  # Mutate new column
  df <- mutate(df, Leadership = MajorLeadershipRole)
  
  # Column factors
  dat$Discipline <- as.factor(dat$Discipline)
  dat$MRC_Taxonomy <- as.factor(dat$MRC_Taxonomy)
  
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
  
  return(df)
  
}