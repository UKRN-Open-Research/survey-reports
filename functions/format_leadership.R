format_leadership <- function(df, MajorLeadershipRole){
  
  # Correct formatting
  df$MajorLeadershipRole <- sub("I do not have a major leadership role,Other", "I do not have a major leadership role", df$MajorLeadershipRole)
  df$MajorLeadershipRole <- sub("I run a lab or group,I direct the organisation", "Run lab/group and direct organisation", df$MajorLeadershipRole)
  df$MajorLeadershipRole <- sub("I run a lab or group,Other", "I run a lab or group", df$MajorLeadershipRole)
  df$MajorLeadershipRole <- sub("I do not have a major leadership role", "No major leadership role", df$MajorLeadershipRole)
  df$MajorLeadershipRole <- sub("I run a lab or group", "Run lab/group", df$MajorLeadershipRole)
  df$MajorLeadershipRole <- sub("I direct the School", "Direct school/organisation", df$MajorLeadershipRole)
  df$MajorLeadershipRole <- sub("I direct the organisation", "Direct school/organisation", df$MajorLeadershipRole)
  
  # Replace NA
  df$MajorLeadershipRole[is.na(df$MajorLeadershipRole)] <- "Not reported"
  
  # Change factor levels
  df$MajorLeadershipRole <- factor(df$MajorLeadershipRole, 
                                    levels = c("No major leadership role",
                                               "Run lab/group",
                                               "Direct school/organisation",
                                               "Run lab/group and direct organisation",
                                               "Other",
                                               "Not reported"))
  
  return(df)
  
}