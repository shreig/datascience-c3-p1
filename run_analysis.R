# Required package: dplyr / tidiverse
library(dplyr)

### Load the training and test data sets:
featuresFile <- "Data/features.txt"
activityFile_labels <- "Data/activity_labels.txt"

trainFile_X <- "Data/train/X_train.txt"
trainFile_y <- "Data/train/y_train.txt"
trainFile_subject <- "Data/train/subject_train.txt"

testFile_X <- "Data/test/X_test.txt"
testFile_y <- "Data/test/y_test.txt"
testFile_subject <- "Data/test/subject_test.txt"


# How many features does the data have?
featureVector_length <- 561

features <- read.table(featuresFile, header = FALSE,
                       nrows = featureVector_length,
                       strip.white = TRUE,
                       col.names = c("n", "feature"))

activity_labels <- read.table(activityFile_labels, header = FALSE,
                         col.names = c("n", "activity_label"))

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


# Join the train data, activities and subjects
train_dataset <- cbind(train_X, train_y, train_subject)


# Join the test data, activities and subjects
test_dataset <- cbind(test_X, test_y, test_subject)


### Merge the training and test sets:
project_dataset <- as_tibble(rbind(train_dataset, test_dataset))

### Extracts only the measurements on the mean and standard deviation for each measurement:
tidy_dataset <- project_dataset %>% select(matches("mean..($|.[XYZ]$)"), matches("std..($|.[XYZ]$)"), matches("activity"), matches("subject"))

### Uses descriptive activity names to name the activities in the data set
levels(tidy_dataset$activity) <- activity_labels$activity_label


### This create a second tidy data set with the average of each variable for activity and subject
means_of_subject_activity <- aggregate(x=select(tidy_dataset,-c('subject', 'activity')), 
          by=list(tidy_dataset$subject, tidy_dataset$activity),
          FUN=mean)
names(means_of_subject_activity)[1] <- "subject"
names(means_of_subject_activity)[2] <- "activity"

# The first Tidy data set is on tidy_dataset
write.csv(tidy_dataset, "Data/ds1.csv", row.names = FALSE)

# The second data set is on means_of_subject_activity
write.csv(means_of_subject_activity, "Data/ds2.csv", row.names = FALSE)


