#' Find and delete the variables which are constant
#'
#' Checks if the input data contains the constan variable
#'
#' @aliases find_constants
#' @param df dataframe containing multiple multivariate time series formatted using
#' the specific Table Schema, use \code{showDF()} to display schema specification details.
#' @param del if TRUE, delete all of the constan variable in input data frame.
#' @return The new data frame
#' @details Checks that fc contains necessary column and the composite primary key values are not duplicated.
#' @author Cuong Sai and Maxim Shcherbakov.
#' @seealso \code{\link{showDF}}
#'
#' @examples
#' validate_data(train_data)
#'
#' @export
#'

find_constants <- function(df, del = TRUE){

  # Check constants in data

  stats_df <- skimr::skim(df)
  constants <- stats_df %>% dplyr::filter(stat == "sd", value == 0)

  if (del) {
  # delete constan variables
  df <- df %>%  dplyr::select(-one_of(constants$variable))
  # message
  if (length(constants$variable) != 0) {
    message(paste(paste("The following constants variables is deleted:"),  paste(constants$variable, collapse = ", ")))
  }

  } else {

    # message
    if (length(constants$variable) != 0) {
      message(paste(paste("The following variables is constants:"),  paste(constants$variable, collapse = ", ")))
    }
  }

  return(df)
}

