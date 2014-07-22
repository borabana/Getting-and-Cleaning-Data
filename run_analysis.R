# Set the working directotry to the root of the GIT directory for this project.
setwd(Sys.getenv("GACD"))


# We'll use data.table for all data sets to improve read and indexing performance.
library(data.table)


# These are the support fuctions to help clean and validate the data set.
source("smartFetchAndUnzip.R")
source("trimLines.R")
source("validateDataSets.R")


# Fetch and unpack the raw data sets, but only if a cached copy of the archive is not already available.
# The "Human Activity Recognition Using Smartphones Data Set" originally came from the UC Irvine Machine
# Learning Repository.  The URL used here is from the Data Science Coursera class Getting and Cleaning
# Data taught in July 2014.  The archive will contain a root folder named "UCI HAR Dataset".  Information
# about the data is here:
#
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipName <- "getdata_projectfiles_UCI HAR Dataset.zip"
expectedFolderName <- "UCI HAR Dataset"
smartFetchAndUnzip(url, zipName, expectedFolderName)
rm(url, zipName)


setwd(expectedFolderName)
rm(expectedFolderName)


# Load activity descriptions; should be 6 by 2.
activities <- fread("activity_labels.txt", sep=" ", header=F)


# Load feature names; should be 561 by 2.
features <- fread("features.txt", sep=" ", header=F)


# Load the test and train data.  The X_test.txt and X_train.txt files use whitespace to separate values
# and the files can contain leading and trailing whitespace.  The files may also contain extra whitespace
# between values.  This whitespace needs to be removed so that the individual values are correctly read.
# Note that there are no NA values so it is safe to remove the whitespace between values.

setwd("test")
trimLines("X_test.txt", "X_test_trimmed.txt", compressWhitespace=T)
test.subjects <- fread("subject_test.txt", sep="\n", header=F,)
test.x <- fread("X_test_trimmed.txt", sep=" ", header=F)
test.y <- fread("y_test.txt", sep="\n", header=F)

setwd("..\\train")
trimLines("X_train.txt", "X_train_trimmed.txt", compressWhitespace=T)
train.subjects <- fread("subject_train.txt", sep="\n", header=F,)
train.x <- fread("X_train_trimmed.txt", sep=" ", header=F)
train.y <- fread("y_train.txt", sep="\n", header=F)


setwd("..\\..")


# Run validations on the loaded data.  Unexpected results result in a stop.
validateDataSets()


# Add meaningful feature names.
setnames(activities, c("activity-id", "activity-name"))
setnames(features, c("id", "name"))
setnames(test.subjects, c("subject"))
setnames(train.subjects, c("subject"))
setnames(test.x, features$name)
setnames(train.x, features$name)
setnames(test.y, c("activity-id"))
setnames(train.y, c("activity-id"))


# Assemble the test and train data into a single data set.
tidy <- rbind(
  cbind(test.subjects, test.y, test.x),
  cbind(train.subjects, train.y, train.x))

rm(test.subjects, test.y, test.x, train.subjects, train.y, train.x)


# Select the mean and standard deviation features while preserving the subject and activity-id.
selectedFeatures <- features[grep("std\\(\\)|mean\\(\\)", features$name, ignore.case=T),]$name
tidy <- subset(tidy, T, c("subject", "activity-id", selectedFeatures))


# Define keys and merge in the activity names.
setkey(activities, "activity-id")
setkey(tidy, "subject", "activity-id")
tidy <- merge(tidy, activities)


# Reorder the features to be more pleasing and redefine the keys for the final tidy data set.
tidy <- subset(tidy, T, c("subject", "activity-name", selectedFeatures))
setkey(tidy, "subject", "activity-name")


# Save the tidy data set.
tidyFileName <- "UCI-HAR-tidy-Dataset.txt"
write.table(tidy, file=tidyFileName, sep=",", col.names=T, row.names=F, quote=F)


# Compute means grouped by subject and activity-name, then save this data too.
tidy.means <- tidy[, lapply(.SD, mean), by=key(tidy)]
tidyMeansFileName <- "UCI-HAR-tidy-means-Dataset.txt"
write.table(tidy.means, file=tidyMeansFileName, sep=",", col.names=T, row.names=F, quote=F)


# Reload the saved data sets to ensure they can be consumed by other scripts.
tidy.reload <- fread(tidyFileName, sep=",", header=T)
tidy.means.reload <- fread(tidyMeansFileName, sep=",", header=T)
rm(tidyFileName, tidyMeansFileName, tidy.reload, tidy.means.reload)
