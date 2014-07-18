project_dir = "/Users/ycjhang/Dropbox/Course/2014/Coursera_Practical_Machine_Learning/weight_lifting"
file_url_train <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
file_url_test <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
file_name_train <- paste0(project_dir, "/data/original/pml-training.csv")
file_name_test <-  paste0(project_dir, "/data/original/pml-testing.csv")
if ( !file.exists(file_name_train) ) {
  dir.create(paste(project_dir, "data/original", sep = "/"))
  download.file(file_url_train, file_name_train)
}
if ( !file.exists(file_name_test) ) {
  download.file(file_url_test, file_name_test)
}