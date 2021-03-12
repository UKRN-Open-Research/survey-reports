plot_responsesovertime <- function(df){
  
  df$RecordedDate <- as.Date(df$RecordedDate)
  
  p1 <- count(df, RecordedDate) %>%
    ggplot(aes(x = RecordedDate, y = n)) +
    geom_bar(aes(fill = n), stat="identity") +
    labs(x="Date", y = "Number of responses") +
    scale_fill_gradient(low = "#6e6fb5", high = "#28295B") +
    theme(legend.title = element_blank())
  
  return(p1)
  
}

plot_discipline <- function(df){
  
  if(choose == "all"){
    
    p2_a <- df %>% group_by(Discipline) %>% count(Unit) %>%
      ggplot(aes(x = Unit, y = n, label = n)) +
      geom_bar(aes(fill = Discipline), stat = "identity") +
      scale_fill_manual(values = c("#28295B", "#4E4F86", "#6e6e6e")) +
      ylim(0, nrow(df)) +
      theme(legend.position="right", legend.text = element_text(size = 7)) +
      xlab("Organisation\n(a)") + ylab("Number of Responses") +
      geom_text(aes(group = Discipline), size = 3, position = position_stack(vjust = 0.5), color = "white") +
      theme(plot.title = element_text(hjust = 0.5))
    
  } else if(choose == "mrc"){
    
    p2_a <- df %>% group_by(Discipline) %>% count(MRC_Taxonomy) %>%
      ggplot(aes(x = MRC_Taxonomy, y = n, label = n)) +
      geom_bar(aes(fill = Discipline), stat = "identity") +
      scale_fill_manual(values = c("#28295B", "#4E4F86", "#6e6e6e")) +
      ylim(0, nrow(df)) +
      theme(legend.position="right", legend.text = element_text(size = 7)) +
      xlab("Research Domain Taxonomy\n(a)") + ylab("Number of Responses") +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) +
      geom_text(aes(group = Discipline), size = 3, position = position_stack(vjust = 0.5), color = "white") +
      theme(plot.title = element_text(hjust = 0.5))
    
  } else if(choose == "uob"){
    
    p2_a <- count(df, Discipline) %>%
      ggplot(aes(x = Discipline, y = n, label = n)) +
      geom_bar(aes(fill = Discipline), stat = "identity") +
      scale_fill_manual(values = c("#28295B", "#4E4F86", "#6e6e6e")) +
      ylim(0, nrow(df)) +
      theme(legend.position="none", legend.text = element_text(size = 7)) +
      xlab("Research Discipline\n(a)") + ylab("Number of Responses") +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) +
      geom_text(aes(group = Discipline), size = 3, position = position_stack(vjust = 0.5), color = "white") +
      theme(plot.title = element_text(hjust = 0.5))
    
  } else{
    
    p2_a <- NULL
    
  }
  
  return(p2_a)
  
}

plot_leadership <- function(df){
  
  if(choose == "babraham"){
    
    p2_b <- count(df, Leadership) %>%
      ggplot(aes(x = Leadership, y = n, label = n)) +
      geom_bar(fill = "#13A89E", stat = "identity") +
      ylim(0, nrow(df)) +
      xlab("Leadership role") + ylab("Number of Responses") +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) +
      geom_text(size = 3, position = position_stack(vjust = 0.5), color = "white") +
      theme(plot.title = element_text(hjust = 0.5))
    
  } else{
    
    p2_b <- count(df, Leadership) %>%
      ggplot(aes(x = Leadership, y = n, label = n)) +
      geom_bar(fill = "#13A89E", stat = "identity") +
      ylim(0, nrow(dat)) +
      xlab("Leadership role\n(b)") + ylab("Number of Responses") +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) +
      geom_text(size = 3, position = position_stack(vjust = 0.5), color = "white") +
      theme(plot.title = element_text(hjust = 0.5))
    
  }
  
  return(p2_b)
  
}

plot_training <- function(dat_all_training, df){
  
  p3 <- dat_all_training %>% group_by(OR_Area, Training) %>% count(Response) %>%   
    ggplot(aes(x = Training, y = n, fill = forcats::fct_rev(Response)))+
    geom_bar(stat = "identity", position = "stack") +
    facet_grid(~ OR_Area) +
    scale_fill_manual(name = "Response", values = c("#28295B", "#4E4F86", "#EC008C", "#6e6e6e", "#13A89E")) +
    theme(legend.position="bottom", legend.text = element_text(size = 7)) +
    xlab("Would Find Training Useful") + ylab("Number of Responses") +
    ylim(0, nrow(df)) +
    theme(plot.title = element_text(hjust = 0.5)) +
    geom_text(aes(label = n, group = OR_Area, Training), size = 3, position = position_stack(vjust = 0.5, reverse = TRUE), color = "white")
  
  return(p3)
  
}

plot_training_provided <- function(dat_training_provided, df){
  
  p4 <- count(dat_training_provided, OR_Area) %>%
    ggplot(aes(x = OR_Area, y = n, label = n)) +
    geom_bar(fill = "#13A89E", stat = "identity") +
    xlab("Open Research Area") + ylab("Number of Responses") +
    ylim(0, nrow(df)) +
    scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) +
    geom_text(size = 3, position = position_stack(vjust = 0.5), color = "white") +
    theme(plot.title = element_text(hjust = 0.5))
  
  return(p4)
  
}

plot_priority <- function(priority){
  
  p5 <- priority %>% group_by(OR_Area) %>% count(Rank) %>%
    ggplot(aes(x = OR_Area, y = n, fill = forcats::fct_rev(Rank))) +
    geom_bar(stat = "identity", position = "stack") +
    scale_fill_manual(name = "Rank", 
                      values = c("#28295B", "#4E4F86", "#13A89E", "#ed68b7", "#EC008C", "#6e6e6e")) +
    theme(legend.position="right") +
    xlab("Open Research Areas") + ylab("Number of Responses") +
    ylim(0, length(unique(priority$randomID))) +
    theme(plot.title = element_text(hjust = 0.5)) +
    geom_text(aes(group = OR_Area, label = n), size = 3, position = position_stack(vjust = 0.5, reverse = FALSE), color = "white")
  
}

plot_priotity_training <- function(priority_training, priority){
  
  priority_training %>% group_by(OR_Area) %>% count(Rank) %>%
    ggplot(aes(x = OR_Area, y = n, fill = forcats::fct_rev(Rank))) +
    geom_bar(stat = "identity", position = "stack") +
    scale_fill_manual(name = "Rank", 
                      values = c("#28295B", "#4E4F86", "#13A89E", "#ed68b7", "#EC008C", "#6e6e6e")) +
    theme(legend.position="right") +
    xlab("Open Research Areas") + ylab("Number of Responses") +
    ylim(0, length(unique(priority$randomID))) +
    theme(plot.title = element_text(hjust = 0.5)) +
    geom_text(aes(group = OR_Area, label = n), size = 3, position = position_stack(vjust = 0.5, reverse = FALSE), color = "white")
  
}
