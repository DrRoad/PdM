#' Data visualization for predictive maintenance
#'
#' The function for plotting of ggplot objects.
#'
#' @aliases visualize_data
#' @param df dataframe containing multivariate time series data
#' @param id_engine engine_id for the data of which to be shown
#' @param cols specisly cols
#' @param type what type of plot should be drawn. Possible types are: "p"-for points,
#' "l"-for lines, "h"-for histogram
#' @return a ggplot object containing the different graphs.
#'
#' @details Test
#'
#'
#'
#' @author Cuong Sai and Maxim Shcherbakov.
#'
#' @keywords data visualization
#'
#' @export

visualize_data <- function(df, id_engine, cols = NULL, type = "l", n_step = 20) {

  df <- df %>% dplyr::filter(id %in% id_engine)
  df$id <- factor(df$id)

  if (!is.null(cols)) {
    df_origin <- df %>% dplyr::select(id, timestamp)
    df_trans <- df %>% dplyr::select(cols)
    df <- dplyr::bind_cols(df_origin, df_trans)
  }
  # Create ggplot
  if (type %in% c("l", "p", "b")){
    df <- df %>% tidyr::gather(key = "s", value = measurement, -id, -timestamp)
    df$s <- factor(df$s, levels=unique(as.character(df$s)))
    p <- ggplot2::ggplot(data = df, mapping = ggplot2::aes(x = timestamp, y = measurement, color = id))
  }

  if (type == "h"){
    df <- df %>% tidyr::gather(key = "s", value = measurement, -id, -timestamp)
    df$s <- factor(df$s, levels=unique(as.character(df$s)))
    p <- ggplot2::ggplot(data = df, ggplot2::aes(x =  measurement, fill = s)) +
      ggplot2::geom_histogram() +
      ggplot2::facet_wrap(~ s, scales = "free", ncol = 4) +
      ggplot2::ggtitle("Sensor Traces") +
      ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))
  }


  if (type == "bp"){
    df <- df %>% tidyr::gather(key = "s", value = measurement, -id, -timestamp)
    df$s <- factor(df$s, levels=unique(as.character(df$s)))
    p <- ggplot2::ggplot(data = df, ggplot2::aes(x = timestamp, y = measurement, color = s)) +
      ggplot2::geom_boxplot() +
      ggplot2::facet_wrap(~ s, scales = "free", ncol = 4) +
      ggplot2::ggtitle("Sensor Traces") +
      ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))
  }

 if (type == "hf"){
    df1 <- df %>%  group_by(id) %>% filter(timestamp <= n_step) %>% ungroup
    df1$class <- "healthy"
    df1 <- df1 %>% tidyr::gather(key = "s", value = measurement, -id, -timestamp, -class)
    df2 <- df %>% group_by(id) %>% filter(timestamp > (max(timestamp) - n_step)) %>% ungroup
    df2$class <- "failing"
    df2 <- df2 %>% tidyr::gather(key = "s", value = measurement, -id, -timestamp, -class)
    df3 <- dplyr::bind_rows(df1, df2)
    df3$s <- factor(df3$s, levels=unique(as.character(df3$s)))
    #df3 <- dplyr::filter(df3, s == "s3")
    p <- ggplot2:: ggplot(df3, mapping = aes(x=measurement, fill = class, color = class)) +
      ggplot2::geom_histogram(alpha=0.4, bins = 30) +
      viridis::scale_color_viridis(discrete = TRUE)+
      facet_wrap(~ s, scales = "free", ncol = 4) +
      ggtitle("Healthy vs Failing Sensor Values")+
      ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))
  }

  # Line plot
  if (type == "l") {
    p <- p + ggplot2::geom_line() +
      ggplot2::geom_smooth(se = FALSE)+
      ggplot2::facet_wrap(~ s, ncol = 4, scales = "free_y") +
      viridis::scale_color_viridis(discrete = TRUE)+
      ggplot2::ggtitle("Sensor Traces") +
      ggplot2::labs(x = "Time", y = "Measurements") +
      ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))

  }
  # for points
  if (type == "p"){
  p <- p + ggplot2::geom_point() +
      ggplot2::facet_wrap(~ s, ncol = 3, scales = "free_y") +
      viridis::scale_color_viridis(discrete = TRUE) +
      ggplot2::ggtitle("Sensor Traces") +
      ggplot2::labs(x = "Time", y = "Measurements") +
      ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))
  }

 if (type == "b"){
   p <- p + ggplot2::geom_line() +
     ggplot2::geom_point()+
     ggplot2::geom_smooth(se = FALSE)+
     ggplot2::facet_wrap(~ s, ncol = 3, scales = "free_y") +
     viridis::scale_color_viridis(discrete = TRUE)+
     ggplot2::ggtitle("Sensor Traces") +
     ggplot2::labs(x = "Time", y = "Measurements") +
     ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))
 }


print(p)
}
