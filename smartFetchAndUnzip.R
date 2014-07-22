# Fetch a .zip from the ingternet and unzip its contents.  If a "cached" copy of the .zip is already
# in the working directory, then skip the fetch.  Likewise, if a known file from the .zip is already
# present in the working directory, then skip the unzip step.
#
smartFetchAndUnzip <- function(url, localZipName, expectedFile, forceRefetch=F, forceUnzip=F) {
  if (!file.exists(localZipName) || forceRefetch) {
    # No cached .zip so fetch it from the web; use binary (wb) mode.  May also have been
    # forced to refetch the .zip by the caller.
    download.file(url, localZipName, mode="wb")
  }
  
  # If an expected file is not found, then an unzip is required.    May also have been
  # forced to unzip by the caller.
  if (!file.exists(expectedFile) || forceUnzip) {
    unzip(localZipName)
  }
}
