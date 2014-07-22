# Let's do some validation on the imported data sets to ensure they have reasonable
# dimensions and are compatible.
#
validateDataSets <- function() {
  if (nrow(activities) != 6) {
    stop("The number of activity rows is incorrect.")
  }
  
  if (ncol(activities) != 2) {
    stop("The number of activity columns is incorrect.")
  }
  
  
  if (nrow(features) != 561) {
    stop("The number of feature name rows is incorrect.")
  }
  
  if (ncol(features) != 2) {
    stop("The number of feature name columns is incorrect.")
  }
  
  
  if (ncol(test.subjects) != 1) {
    stop("The number of test subject columns is incorrect.")
  }
  
  if (ncol(test.y) != 1) {
    stop("The number of test result columns is incorrect.")
  }
  
  if (nrow(test.subjects) != nrow(test.x)) {
    stop("The number of test subjects does not match the number of test samples.")
  }
  
  if (nrow(test.subjects) != nrow(test.y)) {
    stop("The number of test subjects does not match the number of test results")
  }
  
  
  if (ncol(train.subjects) != 1) {
    stop("The number of training subject columns is incorrect.")
  }
  
  if (ncol(train.y) != 1) {
    stop("The number of training result columns is incorrect.")
  }
  
  if (nrow(train.subjects) != nrow(train.x)) {
    stop("The number of training subjects does not match the number of training samples.")
  }
  
  if (nrow(train.subjects) != nrow(train.y)) {
    stop("The number of training subjects does not match the number of training results")
  }
}