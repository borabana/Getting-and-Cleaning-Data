## Summary

The main script *run_analysis.R* generates two clean data sets from the raw data contained in the "Human Activity Recognition Using Smartphones Data Set".  This raw data set was obtained from the [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#).  The clean data set named *UCI-HAR-tidy-Dataset.txt* is a union of the raw training and test data with features added for the subject and activity associated with each sample row.  The clean data set named *UCI-HAR-tidy-means-Dataset.txt* contains the means for each unique subject/activity group present in the *UCI-HAR-tidy-Dataset.txt* data set.

## Requirements

### R Version

This script was written and tested using R 3.1.1 and RStudio 0.98.977.  Earlier and later versions are likely to work with the scripts, but these configurations have not been tested.

### R Libraries

*run_analysis.R* uses the *data.table* library for all data sets to improve read and indexing performance while generating the clean data sets.  A data.table is mostly compatible with R's standard data.frame implementation.  The data.table library is available from [CRAN](http://cran.r-project.org/web/packages/data.table/index.html).

### Custom Functions

*run_analysis.R* uses three additional custom functions to help with loading and cleaning of the raw data.  *smartFetchAndUnzip.R* is used to fetch the raw data archive from the net and unzip its contents.  *trimLines.R* is used to remove unwanted whitespace from the raw data files to ensure these files are loaded correctly.  Lastly, *validateDataSets.R* contains a few simple sanity checks to validate that the raw data was read correctly and has the expected shape.

## High-level Script Steps

1. Load required libraries
2. Source the three custom functions
3. Fetch and unzip the raw data archive, but only if a cached copy of the archive is not already available.  The archive will contain a root folder named "UCI HAR Dataset".
4. Load the activity descriptions; this should yield 6 by 2 data.table.  The separator is a space and there is no heading line.
5. Load the feature names; this should yield a 561 by 2 data table.  The separator is a space and there is no heading line.
6. Load the raw test and train data.  The *X_test.txt* and *X_train.txt* files use whitespace to separate values and the files can contain leading and trailing whitespace.  The files may also contain extra whitespace between values.  This whitespace will be removed so that the individual feature values are correctly read.  There are no NA values so it is safe to remove the whitespace between values.
7. Run validations on the loaded data.  Unexpected results result in a stop of the script.
8. Add meaningful feature names so that the clean data sets are more friendly.
9. Assemble the test and train data sets into a single data set using the *rbind* and *cbind* functions.
10. Select the mean and standard deviation features while preserving the subject and activity-id features.
11. Define keys for the data sets and merge in the activity names.
12. Reorder the features to be more pleasing and redefine the keys for the clean data set.
13. Save the *UCI-HAR-tidy-Dataset.txt* data set.
14. Compute means grouped by subject and activity-name, then save this data set too as *UCI-HAR-tidy-means-Dataset.txt*.
15. Reload the two saved data sets to ensure they can be consumed by other scripts.
