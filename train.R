
library(data.table)
library(randomForest)
library(ggplot2)

df <- read.csv("https://raw.githubusercontent.com/elleobrien/wine/master/wine_quality.csv")

df2 <- setDT(df)

inTrain <- sample(df2[, .I], floor(df2[, .N] * 0.75))
df_train <- df2[inTrain]
df_test <- df2[-inTrain]

rf_classify <- randomForest::randomForest(quality ~ .
                                          , data = df_train
                                          , ntree = 100
                                          , mtry = 2
                                          , importance = TRUE)




fileConn<-file("metrics.txt")

writeLines(c(
  
  paste0("Mean of squared residuals: ", rf_classify$mse[length(rf_classify$mse)][1]),
  paste0("% Var explained: ", rf_classify$rsq[length(rf_classify$rsq)][1])
  
  ), fileConn)

close(fileConn)



