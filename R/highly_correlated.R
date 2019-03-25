# Remove Redundant Features
# ensure the results are repeatable
remove_rf <- function(df, cf = 0.75) {

  # calculate correlation matrix
  correlationMatrix <- cor(df)
  # summarize the correlation matrix
  #print(correlationMatrix)
  # find attributes that are highly corrected (ideally >0.75)
  highlyCorrelated <- caret::findCorrelation(correlationMatrix, cutoff=cf)
  # print indexes of highly correlated attributes
  print(highlyCorrelated)
}

