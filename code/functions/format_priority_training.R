# Requires format_priority and format_training = YES functions to have been previously run.
format_priority_training <- function(priority, dat_training){
  
  # Filter responses where training was wanted by OR area
  training_openaccess = filter(dat_training, OR_Area == "OpenAccess")
  training_opencode = filter(dat_training, OR_Area == "OpenCode")
  training_datasharing = filter(dat_training, OR_Area == "DataSharing")
  training_preprints = filter(dat_training, OR_Area == "Preprints")
  training_preregistration = filter(dat_training, OR_Area == "Preregistration")

  # Map these back to the priority rankings to only get responses from those who would find training useful
  priority_openaccess = filter(priority, randomID %in% training_openaccess$randomID, OR_Area == "OpenAccess")
  priority_opencode = filter(priority, randomID %in% training_opencode$randomID, OR_Area == "OpenCode")
  priority_datasharing = filter(priority, randomID %in% training_datasharing$randomID, OR_Area == "DataSharing")
  priority_preprints = filter(priority, randomID %in% training_preprints$randomID, OR_Area == "Preprints")
  priority_preregistration = filter(priority, randomID %in% training_preregistration$randomID, OR_Area == "Preregistration")  
  
  # Bind back into one dataframe
  priority_training <- rbind(priority_openaccess, priority_opencode, priority_datasharing, priority_preprints, priority_preregistration)
  
  return(priority_training)
  
}