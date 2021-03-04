format_training <- function(df, training){
  
  if(training == "Yes"){
    
    # Subset responses of those who want training
    df = df %>%
      select(OpenAccess, OpenCode, OpenData, Preprints, Preregistration, Primary, Unit, randomID) %>%
      pivot_longer(cols = OpenAccess:Preregistration, names_to = "OR_Area", values_to = "Response") %>%
      filter(grepl("I would find training on this useful", Response))
    
    # Format text responses by familiarity
    df$Response <- replace(df$Response, grep("I already engage with this practice", df$Response), "Already engage in OR area")
    df$Response <- replace(df$Response, grep("I am familiar with this concept", df$Response), "Familiar with OR area")
    df$Response <- replace(df$Response, grep("I am NOT familiar with this concept", df$Response), "NOT familiar with OR area")
    df$Response <- replace(df$Response, grep("I would find training on this useful", df$Response), "Unknown Familiarity")
    df$Response <- replace(df$Response, grep("I think my organisation already provides sufficient training on this", df$Response), "Unknown Familiarity")
    
    return(df)
    
  } else if(training == "No"){
    
    # Subset responses of those who dont mention wanting training
    df <- df %>%
      select(OpenAccess, OpenCode, OpenData, Preprints, Preregistration, Primary, Unit, randomID) %>%
      pivot_longer(cols = OpenAccess:Preregistration, names_to = "OR_Area", values_to = "Response") %>%
      filter(!grepl("I would find training on this useful", Response)) %>%
      filter(!Response == "Not Reported")
    
    # Format text responses by organisation provides and/or familiarity
    df$Response <- replace(df$Response, grep("I think my organisation already provides sufficient training on this", df$Response), "Organisation provides sufficient training")
    df$Response <- replace(df$Response, grep("I already engage with this practice", df$Response), "Already engage with OR area")
    df$Response <- replace(df$Response, grep("I am familiar with this concept", df$Response), "I am familiar with this concept")
    df$Response <- replace(df$Response, grep("I am NOT familiar with this concept", df$Response), "NOT familiar with OR area")
    
    return(df)
    
  } else{
    print("Error: please select either training = \"Yes\" or \"No\"")
  }
  
}