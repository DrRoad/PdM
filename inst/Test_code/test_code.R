#++++++++++++++ Code+++++++++++++++++++++++++++++++++

# load library
library(PdM)

# +++++++++Load data ++++++++++++++

data("train_data", package = "PdM") # load train data
data("test_data", package = "PdM") # load test data
data("rul_target", package = "PdM") # load RUL

# ++++++++ Check data ++++++++++++

validate_data(train_data)
validate_data(test_data)

# ++++++++ summarize data +++++++

summarize_data(train_data)
summarize_data(test_data)

# create new dataset with missing value
test_data_mv <- test_data
test_data_mv[2, 9] <- NA
test_data_mv[3, 6] <- NA
test_data_mv[4, 8] <- NA
head(test_data_mv)
summarize_data(test_data_mv)

#++++++++ handle missing value +++++
test_data_mv <-  handle_misv(test_data_mv, method = "median")
head(test_data_mv)
summarize_data(test_data_mv)
#++++++++ Visualization+++++++++++

?visualize_data
# for line graph
visualize_data(train_data, id_engine = 1:10, type = "l")
visualize_data(test_data, id_engine = 1:10, type = "l")
# for boxplot
visualize_data(train_data, id_engine = 1:10, type = "bp")
# for histogram
visualize_data(train_data, id_engine = 1:100, type = "h")

# for histograms of the healthy vs failing sensor Values
visualize_data(train_data, id_engine = 1:100, type = "hf", n_step = 30)

# ++++++++
