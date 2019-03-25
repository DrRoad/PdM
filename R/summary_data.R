#' data summary
#'
#' Generates data_summary accuracy tables and plots.
#'
#' @aliases summary_data
#' @param df a data frame
#' @return a list with the following variables:
#' @details load input data
#'
#'
#'
#' @author Cuong Sai and Maxim Shcherbakov.
#'
#' @keywords data
#'
#' @export

summary_data <- function(df) {
  skimr::skim(df)
}
