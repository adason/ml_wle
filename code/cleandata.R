# Download the data if not exist
project_dir <- "~/Dropbox/Course/2014/Coursera_Practical_Machine_Learning/weight_lifting"
source(paste0(project_dir, "/code/getdata.R"))

# Load required libraries
library(caret)
library(data.table)

# Read the dataset using `fread()` in `data.table` package.
na_strings <- c("NA","#DIV/0!","")
wle_data <- fread(paste0(project_dir, "/data/original/pml-training.csv"), na.strings = na_strings)

# ========================
# According to the [paper](http://groupware.les.inf.puc-rio.br/public/papers/2013.Velloso.QAR-WLE.pdf) 
# describing this dataset, they use a sliding window approach to detect and separate 
# each movement measurements. Then the statistcs (mean, variance, skiness..) 
# of this window measure is calculated and stored. Therefore, my first step is 
# to filter out these records from the original dataset. Then remove unrevelent 
# `time stamp`, `record_id`, `new_window`, `num_window` and `user_name`.
# ========================

wle_data <- wle_data[new_window == "yes",]
wle_data <- wle_data[, c("V1", "raw_timestamp_part_1", "raw_timestamp_part_2", "cvtd_timestamp", "new_window", "num_window", "user_name") := NULL]
# Convert should be numeric columns to numeric
wle_data <- wle_data[,lapply(.SD, as.numeric), by=c("classe")]

# =========== Training-Testing Split ==============
# In order to build a machine leraning model and verify my model, 
# I take the dataset and spit into two parts, with 70% of the data for 
# training and 30% of the data for testing. This is processed through 
# `createDataPartition()` function in `caret` package.
# ==================================================

set.seed(98736)
train_indices <- createDataPartition(wle_data$classe, p = 0.7)
wle_training <- wle_data[train_indices$Resample1]
wle_testing <- wle_data[-train_indices$Resample1]

# Save training and testing to rdata
dir.create(paste0(project_dir, "/data/archived"), showWarnings = FALSE)
saveRDS(wle_training, file = paste0(project_dir, "/data/archived/wle_training.rds"))
saveRDS(wle_testing, file = paste0(project_dir, "/data/archived/wle_testing.rds"))
