#' Create model
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

# formula <- as.formula(paste(paste("RUL~"), paste(names(train_df[,1:18]), collapse = "+")))

create_model <- function(df, formula, m,...) {
  fit <- caret::train(formula, data=df, method=m,...)
}
