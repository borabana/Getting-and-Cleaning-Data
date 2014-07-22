## Codebook for the *run_analysis.R* Script

### Generated Data Set 1: *UCI-HAR-tidy-Dataset.txt*

*UCI-HAR-tidy-Dataset.txt* is a 10,299 by 68 data set derived from the "Human Activity Recognition Using Smartphones Data Set" provided by the [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#).  The file is formatted as comma separated values and contains a single header line.  The features are outlined in the table below.

<table>
<thead>
<tr>
<td>Position</td>
<td>Name</td>
<td>Description</td>
</tr>
</thead>
<tbody>
<tr>
<td>1</td>
<td>subject</td>
<td>The numeric ID of the test subject from which the measured data was collected.  There were 30 subjects in the HAR test therefore the range of values will be 1 to 30.  Values outside this range are invalid and the sample row should be considered suspect.
</td>
</tr>
<tr>
<td>2</td>
<td>activity-name</td>
<td>The human-readable name for the activity the test subject was performing when the measured data was collected.  There were 6 activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING.  Any other values are invalid and the sample row should be considered suspect.
</td>
</tr>
<tr>
<td>3 to 68</td>
<td>Various mean and standard deviation measurements</td>
<td>The raw HAR data contains 561 features for each sample row.  The *UCI-HAR-tidy-Dataset.txt* data set contains 68 features with 66 of them taken from the original set of 561.  These 66 features are broken down into 33 mean and 33 standard deviation measurements for each sample.  The other two features are the subject and activity-name as previously described.  Mean measurements are denoted by a substring of "-mean()" in a feature name while standard deviations are denoted by a "-std()" substring.
<p>
40 measurements are derived from the device's accelerometer while 26 are from the device's gyroscope.  The accelerometer measurements are in [standard gravity units](http://en.wikipedia.org/wiki/Standard_gravity) which are expressed in meters per second squared.  The gyroscope measurements are expressed in radians per second.
</td>
</tr>
</tbody>
</table>

### Generated Data Set 2: UCI-HAR-tidy-means-Dataset.txt*
