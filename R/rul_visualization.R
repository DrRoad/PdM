#' RUL visualization
#'
#' Generates data_visualization accuracy tables and plots.
#'
#' @aliases data_visualization
#' @param df data
#' @param id_engine indentificator
#' @param cols specisly cols
#' @return a list with the following variables
#'
#' @details load input data
#'
#'
#'
#' @author Cuong Sai and Maxim Shcherbakov.
#'
#' @keywords data
#'
#' @export

rul_visualization <- function(df, id_engine) {
    df <- df %>% filter(id %in% id_engine)
    df$id <- as.factor(df$id)
    # Plot
    p <- ggplot2::ggplot(df, ggplot2::aes(x = id, y =  RUL, fill = id))
    p <- p + ggplot2::geom_bar(stat="identity")
    # ggplot2::geom_line() +
    # ggplot2::geom_smooth(se = FALSE) +
    # viridis::scale_color_viridis(discrete = TRUE) +
    # ggplot2::facet_wrap(~ s, ncol = 3, scales = "free_y")+
    # ggplot2::ggtitle("Sensor Traces") +
    # ggplot2::xlab("Time (Cycles)") +
    # ggplot2::ylab("Measurements") +
    # ggplot2::theme(plot.title = element_text(hjust = 0.5))

  print(p)
}
