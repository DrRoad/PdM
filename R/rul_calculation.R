#' RUL calculation
#'
#' Generates RUL colum for train_data
#'
#' @aliases calculate_rul
#' @param df data frame
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

calculate_rul <- function(df) {
  df <- df %>% dplyr::group_by(id) %>% dplyr::mutate(RUL = max(timestamp) - timestamp) %>% ungroup
  return(df)
}
