format_training <- function(df, training){
  
  if(training == "Yes"){
    
    # Subset responses of those who want training
    df = df %>%
      select(OpenAccess, OpenCode, OpenData, Preprints, Preregistration, Primary, Unit, randomID) %>%
      pivot_longer(cols = OpenAccess:Preregistration, names_to = "OR_Area", values_to = "Response") %>%
      filter(grepl("I would find training on this useful", Response))
    
    # Format text responses by familiarity
    df$Response <- replace(df$Response, grep("I already engage with this practice", df$Response), "Already engage")
    df$Response <- replace(df$Response, grep("I am familiar with this concept", df$Response), "Familiar")
    df$Response <- replace(df$Response, grep("I am NOT familiar with this concept", df$Response), "Not familiar")
    df$Response <- replace(df$Response, grep("I would find training on this useful", df$Response), "Unknown familiarity")
    df$Response <- replace(df$Response, grep("I think my organisation already provides sufficient training on this", df$Response), "Unknown familiarity")
    
    return(df)
    
  } else if(training == "No"){
    
    # Subset responses of those who dont mention wanting training
    df <- df %>%
      select(OpenAccess, OpenCode, OpenData, Preprints, Preregistration, Primary, Unit, randomID) %>%
      pivot_longer(cols = OpenAccess:Preregistration, names_to = "OR_Area", values_to = "Response") %>%
      filter(!grepl("I would find training on this useful", Response)) %>%
      filter(!Response == "Not Reported")
    
    # Format text responses by organisation provides and/or familiarity
    df$Response <- replace(df$Response, grep("I think my organisation already provides sufficient training on this", df$Response), "Training provided")
    df$Response <- replace(df$Response, grep("I already engage with this practice", df$Response), "Already engage")
    df$Response <- replace(df$Response, grep("I am familiar with this concept", df$Response), "Familiar")
    df$Response <- replace(df$Response, grep("I am NOT familiar with this concept", df$Response), "Not familiar")
    
    return(df)
    
  } else{
    print("Error: please select either training = \"Yes\" or \"No\"")
  }
  
}