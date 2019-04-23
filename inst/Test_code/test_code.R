library(keras)
library(dplyr)
#++++++++++++++ Code+++++++++++++++++++++++++++++++++
# Фреймворк для прогностического обслуживания сложных многообъектных
# систем при разработке компонент проактивных систем поддержки принятия решения.

# load library
library(PdM)

# +++++++++Load data - загрузка данных для демонстрации работы Фреймворка ++++++++++++++

data("train_data", package = "PdM") # load train data
data("test_data", package = "PdM") # load test data
data("rul_target", package = "PdM") # load RUL

train_data
test_data
# ++++++++ Check data - проверка формата данных ++++++++++++

validate_data(train_data)
validate_data(test_data)

# ++++++++ summarize data - выводит обобщенную информацию о данных+++++++
# это набор статистических характеристик:
# - чило наблюдений
# - чило признаков
# - тип данных каждого признака
# - min, max
# - mean
# - median
# - Квартили: 25-й и 75-й процентиль
# - Квартили: 25-й и 75-й процентиль
# - чило пропущенных значений в каждом признаке
# - коэффициент асимметрии

summarize_data(train_data)
summarize_data(test_data)

# create new dataset with missing value
test_data_mv <- test_data
test_data_mv[2, 9] <- NA
test_data_mv[3, 6] <- NA
test_data_mv[4, 8] <- NA
head(test_data_mv)
summarize_data(test_data_mv)

#++++++++ handle missing value - борьбы с пропусками +++++
# Заполнение пропущенных значений медианой (удаление, knn, mean,...)
test_data_mv <-  handle_misv(test_data_mv, method = "median")
head(test_data_mv)
summarize_data(test_data_mv)

#++++++++ Visualization+++++++++++

?visualize_data
# for line graph
visualize_data(train_data, id_engine = 1:10, type = "l")
visualize_data(test_data, id_engine = 1:5, type = "l")
# for boxplot
visualize_data(train_data, id_engine = 1:100, type = "bp",
              cols = c("c1", "s10", "s11", "s20")) # Ящик с усами
# for histogram
visualize_data(train_data, id_engine = 1:100, type = "h")

# for histograms of the healthy vs failing sensor Values
visualize_data(train_data, id_engine = 1:100, type = "hf", n_step = 20)
# cодержат ли показания информацию, чтобы позволить нам различать
# исправное и неисправное состояние?
# Большинство показаний датчиков оборудования изменяется в течение его срока
# эксплуатации и проявляют закономерности как и сбой оборудования. Это разумеется,
# что эти показания должны содержать полезную информацию для предсказания RUL.
# n_step: взяты из первых timesteps(healthy values) и последних 20 timestamps (failing values)
# Если это не выполнется, то мало вероятно, что всякая модель, построенная с данным
# датчиков будет полезна для нашей задачи


# ++++++++ Вычисление RUL колонки для train data ++++++++++++
train_data <- calculate_rul(train_data)
head(train_data)

# Visualize RUL распределение
visualize_RUL(train_data, id_engine = 1:15)
visualize_RUL(train_data, id_engine = 1:100, type = "h")

# data Preprocessing
# величина дисперсии = 0 (постоянные призкаки)
c(train_data1, test_data1) %<-%  transfrom_data(train_data, test_data, method = "zv")
train_data1
# величина дисперсии около 0 (около-постоянные призкаки)
c(train_data2, test_data2) %<-%  transfrom_data(train_data1, test_data1, method = "nzv")
train_data2

#  correlation plot
visualize_correlation(train_data2, method="circle")
visualize_correlation(train_data2[,4:18], method="number")
