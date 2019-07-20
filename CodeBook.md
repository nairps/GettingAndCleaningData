-   [1. Abstract](#abstract)
-   [2. Materials](#materials)
    -   [Activity recognition
        experiment](#activity-recognition-experiment)
    -   [Getting the activity recognition experiment
        dataset](#getting-the-activity-recognition-experiment-dataset)
    -   [Activity recognition experiment dataset
        structure](#activity-recognition-experiment-dataset-structure)
    -   [Training and test datasets](#training-and-test-datasets)
    -   [The variables in the activity
        dataset](#the-variables-in-the-activity-dataset)
-   [3. Methods](#methods)
    -   [Data preparation for merging](#data-preparation-for-merging)
    -   [Merge the training and the test
        sets](#merge-the-training-and-the-test-sets)
    -   [Extract the mean and standard deviation for each
        measurement](#extract-the-mean-and-standard-deviation-for-each-measurement)
    -   [Convert activity codes to descriptive activity
        names](#convert-activity-codes-to-descriptive-activity-names)
    -   [Label the data set with descriptive variable
        names](#label-the-data-set-with-descriptive-variable-names)
    -   [Average each variable for each activity and each
        subject](#average-each-variable-for-each-activity-and-each-subject)
    -   [Save the new tidy dataset to a
        file](#save-the-new-tidy-dataset-to-a-file)
-   [4. Results](#results)
    -   [Structure of the tidy dataset](#structure-of-the-tidy-dataset)
    -   [Explanation of the variables in the tidy dataset
        `tidy_data.txt`](#explanation-of-the-variables-in-the-tidy-dataset-tidy_data.txt)
-   [5. Reproducing the
    `tidy_datset.txt`](#reproducing-the-tidy_datset.txt)
-   [6. References](#references)

## 1. Abstract
-----------

Below presented is a codebook for the tidy dataset, `tidy_data.txt`
created from the "Human Activity Recognition Using Smartphones Dataset -
Version 1.0". The tidy dataset was created with the objective of
obtaining an independent and clean dataset for later analyses from the
original dataset and includes averages of each (selected) variable for
each activity and each subject. To make this tidy dataset creation as
reproducible as possible, a codebook was also generated. This codebook
summarises the activity recognition experiment and describes the
structure of the original dataset and its variables. In addition, the
codebook details the data collection, the transformations performed on
the original data, the structure of the new dataset and variables in the
`tidy_data.txt` and details on how to reproduce the tidy dataset
creation.

## 2. Materials
------------

### Activity recognition experiment

A group of 30 volunteers (age range: 19-48) performed 6 different
activities (walking, walking downstairs, walking upstairs, standing,
sitting, lying) with a smartphone, having embedded inertial sensors,
mounted to their waist \[1\]–\[4\]. The 3-axial (X, Y and Z) linear
acceleration and 3-axial (X, Y and Z) angular velocity were captured
during the activities using the embedded accelerometer and gyrometer
respectively in the smartphone. The collected data was then randomly
partitioned to the training and test data: 70% of the volunteers were
assigned to the train set and the rest 30% were assigned to the test
set. The dataset was preprocessed which is described in detail in the
website
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
and also in the README file of the downloaded dataset. Two datasets were
generated from the originally collected data. One for the inertial
signals and another activity windows on which this project is focused
on. A summary of the activity recognition experiment is given in Table
1.

<table class="table table-striped" style="width: auto !important; ">
<caption>
Table 1: Information about the experiment
</caption>
<thead>
<tr>
<th style="text-align:left;">
Experiment Information
</th>
<th style="text-align:left;">
Details
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;width: 20em; ">
Data Set Characteristics
</td>
<td style="text-align:left;width: 25em; ">
Multivariate, Time-Series
</td>
</tr>
<tr>
<td style="text-align:left;width: 20em; ">
Number of Volunteers
</td>
<td style="text-align:left;width: 25em; ">
30
</td>
</tr>
<tr>
<td style="text-align:left;width: 20em; ">
Age range of the Volunteers
</td>
<td style="text-align:left;width: 25em; ">
19-48 years
</td>
</tr>
<tr>
<td style="text-align:left;width: 20em; ">
Number of activities
</td>
<td style="text-align:left;width: 25em; ">
6, coded 1-6
</td>
</tr>
<tr>
<td style="text-align:left;width: 20em; ">
Type of activities
</td>
<td style="text-align:left;width: 25em; ">
walking, walking downstairs, walking upstairs, standing, sitting, lying
</td>
</tr>
<tr>
<td style="text-align:left;width: 20em; ">
Data captured
</td>
<td style="text-align:left;width: 25em; ">
3-axial linear acceleration captured using embedded accelerometer &
3-axial angular velocity captured using embedded gyrometer
</td>
</tr>
<tr>
<td style="text-align:left;width: 20em; ">
Number of Features
</td>
<td style="text-align:left;width: 25em; ">
561 time and frequency domain variables
</td>
</tr>
</tbody>
</table>
### Getting the activity recognition experiment dataset

The data for the analysis was obtained from
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
and saved to a local folder using the `R` script `run_analysis.R`.

### Activity recognition experiment dataset structure

Altogether, there were 28 files in the original dataset folder
(excluding the zip file) that was downloaded from link above. The
structure of the activity recognition dataset is given in Figure 1.

**Figure 1. Structure of the activity recognition experiment dataset**

    data/
    ├── UCI_HAR_DATASET.zip
    └── UCI_HAR_Dataset
        ├── README.txt
        ├── activity_labels.txt
        ├── features.txt
        ├── features_info.txt
        ├── test
        │   ├── Inertial\ Signals
        │   │   ├── body_acc_x_test.txt
        │   │   ├── body_acc_y_test.txt
        │   │   ├── body_acc_z_test.txt
        │   │   ├── body_gyro_x_test.txt
        │   │   ├── body_gyro_y_test.txt
        │   │   ├── body_gyro_z_test.txt
        │   │   ├── total_acc_x_test.txt
        │   │   ├── total_acc_y_test.txt
        │   │   └── total_acc_z_test.txt
        │   ├── X_test.txt
        │   ├── subject_test.txt
        │   └── y_test.txt
        └── train
            ├── Inertial\ Signals
            │   ├── body_acc_x_train.txt
            │   ├── body_acc_y_train.txt
            │   ├── body_acc_z_train.txt
            │   ├── body_gyro_x_train.txt
            │   ├── body_gyro_y_train.txt
            │   ├── body_gyro_z_train.txt
            │   ├── total_acc_x_train.txt
            │   ├── total_acc_y_train.txt
            │   └── total_acc_z_train.txt
            ├── X_train.txt
            ├── subject_train.txt
            └── y_train.txt

    5 directories, 29 files

### Training and test datasets

As the objective of this project is to create a tidy data set by merging
the test and the train dataset, only some of the files listed in Figure
1 are required for the data cleaning and processing here. Table 2
summarises the structure and content of the test files that will be
processed in this project to generate the tidy dataset. These datasets
and metadata in Table 2 will be used for computing the averages of the
variables for each subject and activity.

<table class="table table-striped" style>
<caption>
Table 2: The files needed for merging test and train and their contents
</caption>
<thead>
<tr>
<th style="text-align:left;">
Dataset
</th>
<th style="text-align:left;">
Content
</th>
<th style="text-align:left;">
Number of rows
</th>
<th style="text-align:left;">
Number of columns
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;width: 15em; ">
README.txt
</td>
<td style="text-align:left;">
General File Info
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;width: 15em; ">
activity\_labels.txt
</td>
<td style="text-align:left;">
Descriptive activity names (Links the activity code)
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
2
</td>
</tr>
<tr>
<td style="text-align:left;width: 15em; ">
features\_info.txt
</td>
<td style="text-align:left;">
Description of the variables used on the feature vector
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;width: 15em; ">
features.txt
</td>
<td style="text-align:left;">
List of all features
</td>
<td style="text-align:left;">
561
</td>
<td style="text-align:left;">
2
</td>
</tr>
<tr>
<td style="text-align:left;width: 15em; ">
train/X\_train.txt
</td>
<td style="text-align:left;">
Training set
</td>
<td style="text-align:left;">
7352
</td>
<td style="text-align:left;">
561
</td>
</tr>
<tr>
<td style="text-align:left;width: 15em; ">
train/y\_train.txt
</td>
<td style="text-align:left;">
Training labels (activity code)
</td>
<td style="text-align:left;">
7352
</td>
<td style="text-align:left;">
1
</td>
</tr>
<tr>
<td style="text-align:left;width: 15em; ">
subject\_train.txt
</td>
<td style="text-align:left;">
Subjects who participated (range 1-30)
</td>
<td style="text-align:left;">
7352
</td>
<td style="text-align:left;">
1
</td>
</tr>
<tr>
<td style="text-align:left;width: 15em; ">
test/X\_test.txt
</td>
<td style="text-align:left;">
Test set
</td>
<td style="text-align:left;">
2947
</td>
<td style="text-align:left;">
561
</td>
</tr>
<tr>
<td style="text-align:left;width: 15em; ">
test/y\_test.txt
</td>
<td style="text-align:left;">
Test labels (activity code)
</td>
<td style="text-align:left;">
2947
</td>
<td style="text-align:left;">
1
</td>
</tr>
<tr>
<td style="text-align:left;width: 15em; ">
subject\_test.txt
</td>
<td style="text-align:left;">
Subjects who participated (range 1-30)
</td>
<td style="text-align:left;">
2947
</td>
<td style="text-align:left;">
1
</td>
</tr>
</tbody>
</table>

### The variables in the activity dataset

The signals collected from the experiment are listed below, where the
prefixes `t` and `f` indicate the measurements in the time and frequency
domains respectively.

1.  tBodyAcc-XYZ
2.  tGravityAcc-XYZ
3.  tBodyAccJerk-XYZ
4.  tBodyGyro-XYZ
5.  tBodyGyroJerk-XYZ
6.  tBodyAccMag
7.  tGravityAccMag
8.  tBodyAccJerkMag
9.  tBodyGyroMag
10. tBodyGyroJerkMag
11. fBodyAcc-XYZ
12. fBodyAccJerk-XYZ
13. fBodyGyro-XYZ
14. fBodyAccMag
15. fBodyAccJerkMag
16. fBodyGyroMag
17. fBodyGyroJerkMag

The training and the test datasets comprised the below listed estimates
for the above collected signals (source: README file of the human
activity recognition dataset).

      - mean(): Mean value
      - std(): Standard deviation
      - mad(): Median absolute deviation 
      - max(): Largest value in array
      - min(): Smallest value in array
      - sma(): Signal magnitude area
      - energy(): Energy measure. Sum of the squares divided by the number of values. 
      - iqr(): Interquartile range 
      - entropy(): Signal entropy
      - arCoeff(): Autorregresion coefficients with Burg order equal to 4
      - correlation(): correlation coefficient between two signals
      - maxInds(): index of the frequency component with largest magnitude
      - meanFreq(): Weighted average of the frequency components to obtain a mean frequency
      - skewness(): skewness of the frequency domain signal 
      - kurtosis(): kurtosis of the frequency domain signal 
      - bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
      - angle(): Angle between to vectors.

## 3. Methods
----------

Listed below are the transformations that have been applied to the test
data, train data and metadata files to clean and merge the test and
train datasets for calculating the averages of the variables for each
subject and activity.

### Data preparation for merging

The training and test datasets were prepared for merging using the
following steps.

-   Provided the column name `subject` to the subject info files,
    `subject_train` and `subject_test`.

-   Provided the column name `activity_code` to the activity code files
    for the training and test sets, `y_train` and `y_test`.

-   Provided the column names, `activity_code` and `activity_labels` to
    the `activity_label` file.

### Merge the training and the test sets

-   Merged subject information and activity labels of the training and
    test data sets with the training and test dataset respectively.

-   Merged the `subject-activity-train` datasets with the
    `subject-activity-test` datasets to generate a merged dataset named
    `merged_dat`.

-   Modified the feature names in the `features.txt` with the `R base`
    function `make.names` as the column names were not unique. These
    modified feature names were then assigned as the column names of the
    3rd to the last columns of the merged data set, `merged_dat`; the
    first two columns of the `merged_dat` are `subject` and
    `activity_labels`.

### Extract the mean and standard deviation for each measurement

-   Next, a filtered dataset `merged_dat_mean_std` was generated by
    extracting only the mean and standard deviation for each measurement
    from the merged data set `merged_dat`. These means and standard
    deviations, which were present in the original dataset, were
    estimated from the time and frequency domain 3-axial accelerometer
    and gyrometer signals. The signals collected and the estimates
    calculated based on the collected signals in the activity dataset
    are all presented in the section 2.5. Of note, only the mean and
    standard deviations of the measurements were extracted here for
    calculating the averages.

### Convert activity codes to descriptive activity names

-   The activity codes indicated by the variable `activity_code` in the
    `merged_dat_mean_std` were mapped to their corresponding activity
    names from the `activity_labels` file.

-   The descriptive activity names were then formatted to lowercase
    using the R function `tolower` and stored as a new variable
    `activity_labels` in the `merged_dat_mean_std`.

### Label the data set with descriptive variable names

-   The feature names in the columns of the merged dataset were
    formatted next by taking off the extra dots `[.]` which were created
    by the `make.names` function.

-   The strings `mean` and `std` in the variable names were capitalised
    respectively to `Mean` and `Std`.

-   A string duplication in 6 of the variables
    (`fBodyBodyAccJerkMag.mean..`, `fBodyBodyAccJerkMag.std..`,
    `fBodyBodyGyroMag.mean..`, `fBodyBodyGyroMag.std..`,
    `fBodyBodyGyroJerkMag.mean..` and `fBodyBodyGyroJerkMag.std..`) was
    corrected to make it like other frequency signal variables.

-   The character `f` in the beginning of the variable names, which
    indicate frequency domain signals, were converted to `Freq`.

-   For the variables beginning with `t`, which indicates time domain
    signals, the string `Time` is used as prefix instead of `t`.

### Average each variable for each activity and each subject

-   Took the averages of each variable for each activity and each
    subject

-   The variable names for the measurements were then prefixed with
    "avg" indicating the average values.

### Save the new tidy dataset to a file

-   The newly created merged dataset with the averages of each
    measurements for each activity and each subject was then written to
    a local file.

## 4. Results
----------

### Structure of the tidy dataset

Presented below in *Figure 2* is the structure of the tidy dataset. The
first two columns of the `tidy_dataset.txt` are the subject identifiers
and the activity labels. Altogether, this `tidy_dataset.txt` comprises
66 averaged measurements for each activity (N=6) and each subject
(N=30).

**Figure 2. Structure of the tidy dataset**

    > tidy_data
    # A tibble: 180 x 68
    # Groups:   subject [30]
       subject activity_labels avgTimeBodyAccM… avgTimeBodyAccM… avgTimeBodyAccM… avgTimeBodyAccS… avgTimeBodyAccS…
         <int> <fct>                      <dbl>            <dbl>            <dbl>            <dbl>            <dbl>
     1       1 laying                     0.222         -0.0405           -0.113           -0.928          -0.837  
     2       1 sitting                    0.261         -0.00131          -0.105           -0.977          -0.923  
     3       1 standing                   0.279         -0.0161           -0.111           -0.996          -0.973  
     4       1 walking                    0.277         -0.0174           -0.111           -0.284           0.114  
     5       1 walking_downst…            0.289         -0.00992          -0.108            0.0300         -0.0319 
     6       1 walking_upstai…            0.255         -0.0240           -0.0973          -0.355          -0.00232
     7       2 laying                     0.281         -0.0182           -0.107           -0.974          -0.980  
     8       2 sitting                    0.277         -0.0157           -0.109           -0.987          -0.951  
     9       2 standing                   0.278         -0.0184           -0.106           -0.987          -0.957  
    10       2 walking                    0.276         -0.0186           -0.106           -0.424          -0.0781 
    # … with 170 more rows, and 61 more variables: avgTimeBodyAccStdZ <dbl>, avgTimeGravityAccMeanX <dbl>,
    #   avgTimeGravityAccMeanY <dbl>, avgTimeGravityAccMeanZ <dbl>, avgTimeGravityAccStdX <dbl>,
    #   avgTimeGravityAccStdY <dbl>, avgTimeGravityAccStdZ <dbl>, avgTimeBodyAccJerkMeanX <dbl>,
    #   avgTimeBodyAccJerkMeanY <dbl>, avgTimeBodyAccJerkMeanZ <dbl>, avgTimeBodyAccJerkStdX <dbl>,
    #   avgTimeBodyAccJerkStdY <dbl>, avgTimeBodyAccJerkStdZ <dbl>, avgTimeBodyGyroMeanX <dbl>,
    #   avgTimeBodyGyroMeanY <dbl>, avgTimeBodyGyroMeanZ <dbl>, avgTimeBodyGyroStdX <dbl>,
    #   avgTimeBodyGyroStdY <dbl>, avgTimeBodyGyroStdZ <dbl>, avgTimeBodyGyroJerkMeanX <dbl>,
    #   avgTimeBodyGyroJerkMeanY <dbl>, avgTimeBodyGyroJerkMeanZ <dbl>, avgTimeBodyGyroJerkStdX <dbl>,
    #   avgTimeBodyGyroJerkStdY <dbl>, avgTimeBodyGyroJerkStdZ <dbl>, avgTimeBodyAccMagMean <dbl>,
    #   avgTimeBodyAccMagStd <dbl>, avgTimeGravityAccMagMean <dbl>, avgTimeGravityAccMagStd <dbl>,
    #   avgTimeBodyAccJerkMagMean <dbl>, avgTimeBodyAccJerkMagStd <dbl>, avgTimeBodyGyroMagMean <dbl>,
    #   avgTimeBodyGyroMagStd <dbl>, avgTimeBodyGyroJerkMagMean <dbl>, avgTimeBodyGyroJerkMagStd <dbl>,
    #   avgFreqBodyAccMeanX <dbl>, avgFreqBodyAccMeanY <dbl>, avgFreqBodyAccMeanZ <dbl>, avgFreqBodyAccStdX <dbl>,
    #   avgFreqBodyAccStdY <dbl>, avgFreqBodyAccStdZ <dbl>, avgFreqBodyAccJerkMeanX <dbl>,
    #   avgFreqBodyAccJerkMeanY <dbl>, avgFreqBodyAccJerkMeanZ <dbl>, avgFreqBodyAccJerkStdX <dbl>,
    #   avgFreqBodyAccJerkStdY <dbl>, avgFreqBodyAccJerkStdZ <dbl>, avgFreqBodyGyroMeanX <dbl>,
    #   avgFreqBodyGyroMeanY <dbl>, avgFreqBodyGyroMeanZ <dbl>, avgFreqBodyGyroStdX <dbl>,
    #   avgFreqBodyGyroStdY <dbl>, avgFreqBodyGyroStdZ <dbl>, avgFreqBodyAccMagMean <dbl>,
    #   avgFreqBodyAccMagStd <dbl>, avgFreqBodyAccJerkMagMean <dbl>, avgFreqBodyAccJerkMagStd <dbl>,
    #   avgFreqBodyGyroMagMean <dbl>, avgFreqBodyGyroMagStd <dbl>, avgFreqBodyGyroJerkMagMean <dbl>,
    #   avgFreqBodyGyroJerkMagStd <dbl>

### Explanation of the variables in the tidy dataset `tidy_data.txt`

-   `subject`: Subjects who participated in the study (range:1-30 )
-   `activity_labels` : The activity (N=6) which was performed

<table class="table table-striped" style="width: auto !important; ">
<caption>
Table 4: Variables
</caption>
<thead>
<tr>
<th style="text-align:right;">
Number
</th>
<th style="text-align:left;">
VariableNames
</th>
<th style="text-align:left;">
DataType
</th>
<th style="text-align:left;">
Domain
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
VariableInformation
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
subject
</td>
<td style="text-align:left;">
integer
</td>
<td style="text-align:left;">
The volunteers
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
1-30
</td>
<td style="text-align:left;">
Subject
</td>
</tr>
<tr>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
activity\_labels
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
Activity labels
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
walking, walking\_upstairs, walking\_downstairs, sitting, standing,
laying
</td>
<td style="text-align:left;">
ActivityLabel
</td>
</tr>
<tr>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccMeanX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the body acceleration signals on the X-axis for
each activity (activity codes:1-6 in the data file
`activity_labels.txt`) and each subject (range: 1-30)
</td>
</tr>
<tr>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccMeanY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the body acceleration signals on the Y-axis for
each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccMeanZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the body acceleration signals on the Z-axis for
each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
6
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccStdX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the body acceleration signals on
the X-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
7
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccStdY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of standard deviations for the body acceleration signals on the
Y-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
8
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccStdZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the body acceleration signals on
the Z-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
9
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeGravityAccMeanX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the gravity acceleration signals on the X-axis
for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
10
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeGravityAccMeanY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the gravity acceleration signals on the Y-axis
for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
11
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeGravityAccMeanZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the gravity acceleration signals on the Z-axis
for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
12
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeGravityAccStdX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the gravity acceleration signals
on the X-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
13
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeGravityAccStdY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of standard deviations for the gravity acceleration signals on
the Y-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
14
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeGravityAccStdZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the gravity acceleration signals
on the Z-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
15
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccJerkMeanX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the body linear acceleration jerk signals on
the X-axis for each activity (activity codes:1-6 in the data file
`activity_labels.txt`) and each subject (range: 1-30)
</td>
</tr>
<tr>
<td style="text-align:right;">
16
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccJerkMeanY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the body linear acceleration jerk signals on
the Y-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
17
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccJerkMeanZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the body linear acceleration jerk signals on
the Z-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
18
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccJerkStdX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the body linear acceleration jerk
signals on the X-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
19
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccJerkStdY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of standard deviations for the body linear acceleration jerk
signals on the Y-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
20
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccJerkStdZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the body linear acceleration jerk
signals on the Z-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
21
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroMeanX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the angular velocity signals on the X-axis for
each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
22
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroMeanY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the angular velocity signals on the Y-axis for
each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
23
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroMeanZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the angular velocity signals on the Z-axis for
each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
24
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroStdX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the angular velocity signals on
the X-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
25
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroStdY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of standard deviations for the angular velocity signals on the
Y-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
26
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroStdZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the angular velocity signals on
the Z-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
27
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroJerkMeanX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the angular velocity jerk signals on the X-axis
for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
28
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroJerkMeanY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the angular velocity jerk signals on the Y-axis
for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
29
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroJerkMeanZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the angular velocity jerk signals on the Z-axis
for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
30
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroJerkStdX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the angular velocity jerk signals
on the X-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
31
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroJerkStdY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of standard deviations for the angular velocity jerk signals on
the Y-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
32
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroJerkStdZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the angular velocity jerk signals
on the Z-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
33
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccMagMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the means of the magnitudes of body acceleration signals for
each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
34
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccMagStd
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the standard deviations of the magnitudes of body
acceleration signals for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
35
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeGravityAccMagMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the means of the magnitudes of gravity acceleration signals
for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
36
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeGravityAccMagStd
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the standard deviations of the magnitudes of gravity
acceleration signals for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
37
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccJerkMagMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the means of the magnitudes of body acceleration jerk
signals for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
38
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyAccJerkMagStd
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the standard deviations of the magnitudes of body
acceleration jerk signals for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
39
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroMagMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the means of the magnitudes of body angular velocity signals
for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
40
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroMagStd
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the standard deviations of the magnitudes of body angular
velocity signals for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
41
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroJerkMagMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the means of the magnitudes of body angular velocity jerk
signals for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
42
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgTimeBodyGyroJerkMagStd
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Time Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the standard deviations of the magnitudes of body angular
velocity jerk signals for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
43
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccMeanX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the body acceleration signals on the X-axis for
each activity (activity codes:1-6 in the data file
`activity_labels.txt`) and each subject (range: 1-30)
</td>
</tr>
<tr>
<td style="text-align:right;">
44
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccMeanY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the body acceleration signals on the Y-axis for
each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
45
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccMeanZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the body acceleration signals on the Z-axis for
each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
46
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccStdX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the body acceleration signals on
the X-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
47
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccStdY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of standard deviations for the body acceleration signals on the
Y-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
48
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccStdZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the body acceleration signals on
the Z-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
49
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccJerkMeanX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the body linear acceleration jerk signals on
the X-axis for each activity (activity codes:1-6 in the data file
`activity_labels.txt`) and each subject (range: 1-30)
</td>
</tr>
<tr>
<td style="text-align:right;">
50
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccJerkMeanY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the body linear acceleration jerk signals on
the Y-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
51
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccJerkMeanZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the body linear acceleration jerk signals on
the Z-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
52
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccJerkStdX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the body linear acceleration jerk
signals on the X-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
53
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccJerkStdY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of standard deviations for the body linear acceleration jerk
signals on the Y-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
54
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccJerkStdZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the body linear acceleration jerk
signals on the Z-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
55
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyGyroMeanX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the angular velocity signals on the X-axis for
each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
56
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyGyroMeanY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the angular velocity signals on the Y-axis for
each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
57
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyGyroMeanZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the means for the angular velocity signals on the Z-axis for
each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
58
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyGyroStdX
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the angular velocity signals on
the X-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
59
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyGyroStdY
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of standard deviations for the angular velocity signals on the
Y-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
60
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyGyroStdZ
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Average of the standard deviations for the angular velocity signals on
the Z-axis for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
61
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccMagMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the means of the magnitudes of body acceleration signals for
each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
62
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccMagStd
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the standard deviations of the magnitudes of body
acceleration signals for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
63
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccJerkMagMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the means of the magnitudes of body acceleration jerk
signals for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
64
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyAccJerkMagStd
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the standard deviations of the magnitudes of body
acceleration jerk signals for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
65
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyGyroMagMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the means of the magnitudes of body angular velocity signals
for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
66
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyGyroMagStd
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the standard deviations of the magnitudes of body angular
velocity signals for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
67
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyGyroJerkMagMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the means of the magnitudes of body angular velocity jerk
signals for each activity and each subject
</td>
</tr>
<tr>
<td style="text-align:right;">
68
</td>
<td style="text-align:left;width: 1cm; font-weight: bold;">
avgFreqBodyGyroJerkMagStd
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Frequency Domain Signals
</td>
<td style="text-align:left;width: 15cm; font-weight: bold;">
\[-1,1\]
</td>
<td style="text-align:left;">
Averages of the standard deviations of the magnitudes of body angular
velocity jerk signals for each activity and each subject
</td>
</tr>
</tbody>
</table>

## 5. Reproducing the `tidy_datset.txt`
------------------------------------

The tidy data was generated using the R script `run_analysis.R` which
uses the `tidyverse` package (`tidyverse_1.2.1`).

The `R` `sessionInfo()` is given in the Figure 3 to show the attached
packages for reproducibility.

**Figure 3: R session information showing the attached packages for
reproducing the analysis**

    > sessionInfo()
    R version 3.6.1 (2019-07-05)

    attached base packages:
    [1] stats     graphics  grDevices utils     datasets  methods   base     

    other attached packages:
    [1] forcats_0.4.0   stringr_1.4.0   dplyr_0.8.3     purrr_0.3.2     readr_1.3.1     tidyr_0.8.3     tibble_2.1.3    ggplot2_3.2.0  
    [9] tidyverse_1.2.1

    loaded via a namespace (and not attached):
     [1] tidyselect_0.2.5  xfun_0.8          haven_2.1.1       lattice_0.20-38   colorspace_1.4-1  vctrs_0.2.0       generics_0.0.2   
     [8] htmltools_0.3.6   viridisLite_0.3.0 yaml_2.2.0        utf8_1.1.4        rlang_0.4.0       pillar_1.4.2      glue_1.3.1       
    [15] withr_2.1.2       modelr_0.1.4      readxl_1.3.1      munsell_0.5.0     gtable_0.3.0      cellranger_1.1.0  rvest_0.3.4      
    [22] kableExtra_1.1.0  evaluate_0.14     knitr_1.23        fansi_0.4.0       broom_0.5.2       Rcpp_1.0.1        scales_1.0.0     
    [29] backports_1.1.4   webshot_0.5.1     jsonlite_1.6      hms_0.5.0         digest_0.6.20     stringi_1.4.3     grid_3.6.1       
    [36] cli_1.1.0         tools_3.6.1       magrittr_1.5      lazyeval_0.2.2    crayon_1.3.4      pkgconfig_2.0.2   zeallot_0.1.0    
    [43] rsconnect_0.8.13  data.table_1.12.2 xml2_1.2.0        lubridate_1.7.4   assertthat_0.2.1  rmarkdown_1.14    httr_1.4.0       
    [50] rstudioapi_0.10   R6_2.4.0          nlme_3.1-140      compiler_3.6.1   

## 6. References
-------------

\[1\] D. Anguita, A. Ghio, L. Oneto, X. Parra, and J. L. Reyes-Ortiz,
“Human Activity Recognition on Smartphones Using a Multiclass
Hardware-Friendly Support Vector Machine,” in *Ambient Assisted Living
and Home Care*, 2012, pp. 216–223.

\[2\] J. L. Reyes-ortiz, R. Ghio, D. Anguita, X. Parra, and J.
Cabestany, “Human activity and motion disorder recognition: Towards
smarter interactive cognitive environments,” in *In European Symposium
on Artificial Neural Networks, Computational Intelligence and Machine
Learning*, 2013.

\[3\] D. Anguita, A. Ghio, L. Oneto, X. Parra, and J. L. Reyes-Ortiz, “A
Public Domain Dataset for Human Activity Recognition Using Smartphones,”
*Computational Intelligence*, p. 6, 2013.

\[4\] J.-L. Reyes-Ortiz, L. Oneto, A. Ghio, A. Samá, D. Anguita, and X.
Parra, “Human Activity Recognition on Smartphones with Awareness of
Basic Activities and Postural Transitions,” in *Artificial Neural
Networks and Machine Learning – ICANN 2014*, 2014, pp. 177–184.
