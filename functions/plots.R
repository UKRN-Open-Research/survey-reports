plot_responsesovertime <- function(df){
  
  df$RecordedDate <- as.Date(df$RecordedDate)
  
  p1 <- count(df, RecordedDate) %>%
    ggplot(aes(x = RecordedDate, y = n)) +
    geom_bar(aes(fill = n), stat="identity") +
    labs(x="Date", y = "Number of responses") +
    scale_fill_gradient(low = "#6e6fb5", high = "#28295B")
  
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
    
    p2_a <- df %>% group_by(Discipline) %>% count(Primary) %>%
      ggplot(aes(x = Primary, y = n, label = n)) +
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






