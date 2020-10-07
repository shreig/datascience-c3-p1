---
title: Getting and Cleaning Data Course Project
author: Luis Cano
date: 2020-10-02
---

This Repo contains the Project Assignment for the Course Getting and Cleaning Data from Coursera.

The purpose of this Project is to transform the Data Set Provided using the Samsung Galaxy S Data collected from 30 subjects, from  [Coursera Getting and Cleaning Data Course Project Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) to a Tidy Data Set.

It contains four main parts:

1. This file describing the structure of this project
2. The Data Directory (Data/) with the data sets used in this project from the link above
3. The run_analysis.R script file that prepares the data set to make a tidy data set
4. The CodeBook.md that describes each variable of the Tidy Data set and the process and transformations that need to be done to convert the Provided Data Set to a Tidy Data Set

## Data Directory
In the Data Directory there is a README.txt that contains information about the source Data Set. This data set is divided by the training data set and the test data set. 

The locations of each data set is as follows:

1. Training data set is at Data/train
2. Test data set is at Data/test

## run_analysis.R
This script does the following when run:

1. Merge the training and test sets
2. Extracts only mean and standard deviation measurements
3. Map the activity name labels in the data sets
4. Label each column of the Data sets with a descriptive name
5. Create another file named tidy.txt with the data set in #1 with the average of each variable by activity and subject

Is important to note that the Data directory Data/ must be at the working directory before running the script to work.

## CodeBook.md
This file contains the instructions to replicate the work done in the run_analysis.R and the feature definitions.


By the license, the reference to the publication:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012




