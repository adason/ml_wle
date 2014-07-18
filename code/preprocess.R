project_dir <- "~/Dropbox/Course/2014/Coursera_Practical_Machine_Learning/weight_lifting"
wle_training <- readRDS(paste0(project_dir, "/data/archived/wle_training.rds"))
wle_testing <- readRDS(paste0(project_dir, "/data/archived/wle_training.rds"))

# Detect nearzero columns and remove them
wle_nearzero <- nearZeroVar(wle_training, saveMetrics = TRUE)
wle_training <- wle_training[,!wle_nearzero$nzv, with = FALSE]
wle_testing <- wle_testing[,!wle_nearzero$nzv, with = FALSE]

# separate y columns
wle_training_y <- as.factor(wle_training$classe)
wle_testing_y <- as.factor(wle_testing$classe)
wle_training <- wle_training[, -1, with = FALSE]
wle_testing <- wle_testing[,-1, with = FALSE]

# BoxCox, Center, Scale Impute and PCA (or not)
# Impute missing values using k-nearest-neighbors with k = 5
# (Ignore first column since is our outcome variable and it's not numeric)
prep_model <- preProcess(wle_training, 
                               method = c("BoxCox", "center", "scale", "knnImpute"),
                               k = 5)
prep_model_pca <- preProcess(wle_training, 
                             method = c("BoxCox", "center", "scale", "knnImpute", "pca"),
                             thresh = 0.95, 
                             k = 5)
wle_training <- predict(prep_model, newdata = wle_training)
wle_testing <- predict(prep_model, newdata = wle_testing)

wle_training_pca <- predict(prep_model, newdata = wle_training)
wle_testing_pca <- predict(prep_model, newdata = wle_testing)