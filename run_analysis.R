###############################################################
#
#   Getting and Cleaning Data Course Project
#
#
###############################################################
library(tidyverse)
###############################################################
#
# 0. Data download
#
###############################################################
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./data/UCI_HAR_DATASET.zip")) {
  download.file(
    fileUrl,
    destfile = "./data/UCI_HAR_DATASET.zip",
    method = "curl"
  )
  unzip("./data/UCI_HAR_DATASET.zip",
    exdir = "./data/"
  )
}

# renaming the dataset folder
file.rename(
  "./data/UCI HAR Dataset",
  "./data/UCI_HAR_Dataset"
)

# show the content of the data directory
list.files("./data/UCI_HAR_DATASET", recursive = TRUE)

###############################################################
#
# 0.2 Loading the data and checking the structure of the files
#
###############################################################

# README, feature_info and those in the subfolder "Inertial Signals" are not loaded here
#
needed_files <- list.files(
  "./data/UCI_HAR_DATASET",
  recursive = TRUE
) %>%
  str_subset("Inertial|README|features_info", negate = TRUE)

# loading the files that are needed for the analysis
files <- lapply(
  needed_files, function(x)
    data.table::fread(
      paste0("./data/UCI_HAR_DATASET", "/", x),
      fill = TRUE
    )
)
# naming the loaded files
names(files) <- stringr::str_match(
  needed_files, "(\\w*).txt"
)[, 2]

# check the dimensions of the loaded files
file_dimensions <- t(sapply(files, dim))
colnames(file_dimensions) <- c("nrows", "ncols")
write.table(
  data.frame(
    "file.name" = rownames(file_dimensions),
    file_dimensions
  ),
  "GCD_data_file_dims.txt",
  sep = "\t",
  quote = F,
  row.names = F
)

###############################################################
#
# 0.3 preparing the files for merging
#
###############################################################
# providing column names to the subject info files
files$subject_train <- files$subject_train %>%
  rename(subject = V1)
files$subject_test <- files$subject_test %>%
  rename(subject = V1)

# providing column name to the activity code files
files$y_train <- files$y_train %>%
  rename(activity_code = V1)
files$y_test <- files$y_test %>%
  rename(activity_code = V1)

# providing column names to the activity label file
files$activity_labels <- files$activity_labels %>%
  rename(
    activity_code = V1,
    activity_labels = V2
  )
###############################################################
#
# 1. merging the training and test sets with subject and activity info
#
###############################################################
merged_dat <- bind_rows(
  bind_cols(
    files$subject_train,
    files$y_train,
    files$X_train
  ),
  bind_cols(
    files$subject_test,
    files$y_test,
    files$X_test
  )
)

######################################################################
#
# 1.2 cleaning the feature names and renaming the merged data columns
#     with the modified feature names
######################################################################
features <- make.names(files$features$V2, unique = TRUE)

# renaming the columns using features
head(colnames(merged_dat))
length(colnames(merged_dat))
merged_dat <- merged_dat %>%
  rename_at(
    vars(colnames(merged_dat)[3:ncol(merged_dat)]), ~features
  )
head(colnames(merged_dat))
########################################################################
#
# 2. extracting only the mean and standard deviation for each measurement
#
#######################################################################

merged_dat_mean_std <-
  merged_dat %>% select(
    subject,
    activity_code,
    matches("mean\\.\\.|std\\.\\.", ignore.case = FALSE)
  )
dim(merged_dat_mean_std)
##############################################################################
#
#   3. Use descriptive activity names to name the activities in the data set
#
##############################################################################


# converting activity codes to activity labels and formatting
merged_dat_mean_std_new <- left_join(
  merged_dat_mean_std,
  files$activity_labels,
  by = "activity_code"
) %>%
  mutate(activity_labels = factor(tolower(activity_labels))) %>%
  select(-activity_code)


dim(merged_dat_mean_std_new)
##############################################################################
#
#   4. Labelling the dataset with descriptive variable names.
#
##############################################################################
# formatting the variables to make it slightly more descriptive
colnames(merged_dat_mean_std_new) <-
  colnames(merged_dat_mean_std_new) %>%
  str_replace_all(c(
    "[.]{2,}" = "",
    "mean" = "Mean",
    "std" = "Std",
    "[.]" = "",
    "BodyBody" = "Body",
    "^t" = "Time",
    "^f" = "Freq"
  ))
####################################################################################
#
#   5. creating an independent tidy data set with
#     the average of each variable
#     for each activity and each subject.
#
####################################################################################
# note here that the calculations are sorted by the activity names instead of activity codes

tidy_data <- merged_dat_mean_std_new %>%
  group_by(subject, activity_labels) %>%
  summarise_all(mean)
dim(tidy_data)
class(tidy_data)
colnames(tidy_data) <- colnames(tidy_data) %>% str_replace_all(
  c("^Time" = "avgTime", "^Freq" = "avgFreq")
)
write_tsv(
  data.frame(colnames(tidy_data)),
  "./variables.txt"
)
##################################################################
#
# 6. saving tidy data to a file
#
##################################################################
write_tsv(
  tidy_data,
  "./tidy_data.txt"
)

