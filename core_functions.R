process_df <- function(month) {
  hotels_data %>% 
    filter(arrival_month == month) %>%
    count(is_canceled, arrival_ymd, name = "num_records") %>% 
    rename(
      "Arrival date" = arrival_ymd, 
      "Number of reservations" = num_records
    )
}

gen_plot <- function(df) {
  formatted_title <-
    "Number of <span style = 'color:#0088BC;'>check-ins</span> and <span style = 'color:#D83F1F;'>cancelations</span> for each arrival date"
  
  ggplot(df, aes(`Arrival date`, `Number of reservations`,
                 colour = is_canceled, group = is_canceled)) +
    geom_line() +
    geom_point() +
    theme_bw() +
    scale_color_manual(
      values = c("FALSE" = "#0088BC", "TRUE" = "#D83F1F"),
    ) +
    labs(
      title = formatted_title, 
      x = "", y = ""
    ) +
    theme(
      plot.title = element_markdown(hjust = 0.5),
      legend.position = "none"
    )
}

make_interactive <- function(plot) {
  plot %>% 
    ggplotly(tooltip = c("x", "y")) %>% 
    
    # to make dimensions of manually and functionally iterated plots similar
    htmltools::div()
}