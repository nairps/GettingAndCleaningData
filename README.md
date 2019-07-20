-   [1. The files in the repo](#the-files-in-the-repo)
-   [2. `run_analysis.R`](#run_analysis.r)

1. The files in the repo
------------------------

1.  `tidy_data.txt`: The tidy dataset, described in detail in the
    CodebBook.md

2.  `CodeBook.md`: Summarises the activity recognition dataset,
    describes the tidy dataset variables and the transformations
    performed to clean up the data and explain how to reproduce the tidy
    dataset

3.  `run_analysis.R`: A self explanatory commented R script that
    performs the various steps needed for creating the tidy dataset

2. `run_analysis.R`
-------------------

Specifically, the `run_analysis.R` does the following steps:

-   downloads and load the data
-   prepare the data for merging
-   merge the training and the test sets
-   extracts the measurements on the mean and standard deviation for
    each measurement
-   rename activity codes to activity labels
-   modifies the variable names to make it more descriptive
-   create a new dataset with the average of each variable for each
    activity and each subject
-   create a codebook describing the entire process and the tidy dataset
