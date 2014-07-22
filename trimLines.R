# Trim leading and trailing whitespace on each line of a file and, optionally, also
# compress whitespace within a line into a single blank.  The return value is the
# number of lines read from the file and written to the trimmed file.
#
trimLines <- function(srcFile, destFile, compressWhitespace=F) {
  if (!file.exists(srcFile)) {
    stop("Source file does not exist.")
  }
  
  linesRead <- 0
  src <- file(srcFile, open = "r")
  dest <- file(destFile, open = "w")
  
  while (length(oneLine <- readLines(src, n=1)) > 0) {
    # Remove leading and trailing whitespace.
    oneLine <- gsub("^\\s+|\\s+$", "", oneLine)
    
    if (compressWhitespace) {
      oneLine <- gsub("\\s+", " ", oneLine)
    }
      
    writeLines(oneLine, dest)
    linesRead <- linesRead + 1
  } 

  close(src)
  close(dest)
  
  return (linesRead)
}