---
title: Project Code Book
author: Luis Cano
date: 2020-10-02
---

This project includes the Data Set from [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/)

The Code Book from that data set is at 'Data/README.txt' and 'Data/features_info.txt'.


This Project converts the above data set to two data sets:

1. The first Data Set with the combined data from the means() and std() features of the Train and Test Data Set
2. Another Data Set with the means of the first Data Set grouped by subject and activity

The features for this Data Sets are:

- Normalized and bounded within [-1,1].
- The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).
- The gyroscope units are rad/seg.
- The features beginning with t are time bounded and the ones beginning with f are frequency bounded.


This file describes the process to:

1. Merge the training and test sets
2. Extracts only mean and standard deviation measurements
3. Map the activity name labels in the data sets
4. Label each column of the Data sets with a descriptive name
5. Create another file with the data set in #1 to average each variable by activity and subject

This process is in run_analysis.R file.

## 1. Merge the training and test sets

#### Required package: dplyr / tidiverse
The library dplyr version 1.0+ is required to run this Project.

Load library dplyr:

    library(dplyr)

#### Load the training and test data sets:
Set the location of each file:

- features.txt: Have the feature names.
- activity_labels.txt: Have the activity labels
- X_train.txt, X_test.txt: features of the train and test data set
- y_train.txt, y_test.txt: Activities for each observation
- subject_train.txt, subject_test.txt: The subject id for each observation

Set the file locations to variables:

    featuresFile <- "Data/features.txt"
    activityFile_labels <- "Data/activity_labels.txt"

    trainFile_X <- "Data/train/X_train.txt"
    trainFile_y <- "Data/train/y_train.txt"
    trainFile_subject <- "Data/train/subject_train.txt"

    testFile_X <- "Data/test/X_test.txt"
    testFile_y <- "Data/test/y_test.txt"
    testFile_subject <- "Data/test/subject_test.txt"


For better performance, set the feature vector length:

    featureVector_length <- 561

Using read.table to read each file to a data set:

First the features and activities labels:

    features <- read.table(featuresFile, header = FALSE,
                       nrows = featureVector_length,
                       strip.white = TRUE,
                       col.names = c("n", "feature"))

    activity_labels <- read.table(activityFile_labels, header = FALSE,
                         col.names = c("n", "activity_label"))

Second the train data sets:

    train_X <- read.table(trainFile_X, header = FALSE, 
                      colClasses = 
                        rep("numeric", times = featureVector_length),
                      strip.white = TRUE,
                      col.names = features$feature
                      )

    train_y <- read.table(trainFile_y, header = FALSE,
                      colClasses = c("factor"),
                      strip.white = TRUE,
                      col.names = c("activity"))

    train_subject <- read.table(trainFile_subject, header = FALSE,
                            col.names = c("subject"))

Last the test data sets:

    test_X <- read.table(testFile_X, header = FALSE, 
                      colClasses = 
                        rep("numeric", times = featureVector_length),
                      strip.white = TRUE,
                      col.names = features$feature
)

    test_y <- read.table(testFile_y, header = FALSE,
                      colClasses = c("factor"),
                      strip.white = TRUE,
                      col.names = c("activity"))

    test_subject <- read.table(testFile_subject, header = FALSE,
                            col.names = c("subject"))


#### Join the train data, activities and subjects

For joining the previous data sets to one tidy data set first we join the train data set with cbind:

    train_dataset <- cbind(train_X, train_y, train_subject)

The same for the test data set:

    test_dataset <- cbind(test_X, test_y, test_subject)

#### Merge the training and test sets:

    project_dataset <- as_tibble(rbind(train_dataset, test_dataset))

## 2. Extracts only the measurements on the mean and standard deviation for each measurement:

For extracting just the mean and standard deviation measurement we use the select function 
from dplyr, and use a regular expression to filter out this, matching `mean..($|.[XYZ]$)`,  `std..($|.[XYZ}$])`, `activity` and `subject`.


    tidy_dataset <- project_dataset %>% select(matches("mean..($|.[XYZ]$)"), matches("std..($|.[XYZ]$)"), matches("activity"), matches("subject"))

With the previous statement we store the features with mean(), std(), activity and subject to the tidy_dataset variable. 


## 3. Uses descriptive activity names to name the activities in the data set
For this we use a factor to label the activities, we previously loaded the activity labels 
to the activity_labels data set:

    levels(tidy_dataset$activity) <- activity_labels$activity_label


## 4. Label the features and create a second tidy data set with the average of each variable for activity and subject

We will use the aggregate function to group by subject and activity the tidy_dataset and 
then 

    means_of_subject_activity <- aggregate(x=select(tidy_dataset,-c('subject', 'activity')), 
          by=list(tidy_dataset$subject, tidy_dataset$activity),
          FUN=mean)
          
Then we use descriptive variable names:          

    names(means_of_subject_activity)[1] <- "subject"
    names(means_of_subject_activity)[2] <- "activity"

## 5. Write the Data sets to Storage

The first Tidy data set is on tidy_dataset

    write.csv(tidy_dataset, "Data/ds1.csv", row.names = FALSE)

The second data set is on means_of_subject_activity

    write.csv(means_of_subject_activity, "Data/ds2.csv", row.names = FALSE)

