#' Handling Missing Values
#'
#' Imputation and Removing Data
#'
#' @aliases handling_na
#' @param df the input data frame
#' @param method the method for handling missing values
#' @return A new data frame without missing values
#' @details Handling missing values with different methods
#'
#'
#'
#' @author Cuong Sai and Maxim Shcherbakov.
#'
#' @keywords data frame
#'
#' @export



handle_misv <- function(df, method) {

# Removing
  if (method == "omit") {
    df <- na.omit(df)
  }
# knnImprute
  if (method == "knn"){
    pPmI <- caret::preProcess(df, method = 'medianImpute')
    df <- predict(pPmI, df)
  }
#bagImprute
  if (method == "bag") {
    pPbI <- caret::preProcess(df, method = 'bagImpute')
    df <- predict(pPbI, df)
  }
# Mean
  if (method == "mean"){

  }
# Median
  if (method == "median"){

  }
# mode
  if (method == "mod") {

  }
}
