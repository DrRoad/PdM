#' @export
normalize_data <- function(train_df, test_df, method = "range"){

  origin_variable <- c("id", "RUL")
  origin_train <- train_df[origin_variable]
  trans_train <-  train_df %>%  dplyr::select(-one_of(origin_variable))
  origin_test <- test_df["id"]
  trans_test <- test_df %>%  dplyr::select(-one_of("id"))
  preprocessParams <- caret::preProcess(trans_train, method = method)
  transformed_train <- predict(preprocessParams, trans_train)
  transformed_test <- predict(preprocessParams, trans_test)
  train_data <- dplyr::bind_cols(origin_train, transformed_train)
  test_data <- dplyr::bind_cols(origin_test, transformed_test)

  return(list(train_data, test_data))
}
