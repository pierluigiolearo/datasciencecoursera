# Code Book for Course Project
----------
## Overview
__Source of the original data__:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
 
__Full Description at the site where the data was obtained__:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

__Process__

The script *run_analysis.R* performs the following process to clean up the data and create tiny data sets:



- Merge the training and test sets to create one data set.



- Reads *features.txt* and uses only the measurements on the mean and standard deviation for each measurement.



- Reads *activity_labels.txt* and applies human readable activity names to name the activities in the data set.



- Labels the data set with descriptive names. 
> Names are converted to lower case; underscores and brackets are removed.



- Merges the features with activity labels and subject IDs. The result is saved as **tidyData.txt**.



- The average of each measurement for each activity and each subject is merged to a second data set. The result is saved as **tidyData2.txt**.


###Variables

- **path** - relative path to unzip data
- **testData** - table contents of *test/X_test.txt*
- **trainData** - table contents of *train/X_train.txt*
- **df** - Measurement data. Combined data set of the two above variables
- **testSub** - table contents of *test/subject_test.txt*
- **trainSub** - table contents of *test/subject_train.txt*
- **ds** - Data Subjects. Combined data set of the two above variables
- **testLabel** - table contents of *test/y_test.txt*
- **trainLabel** - table contents of *train/y_train.txt*
- **dl** - Data Labels. Combined data set of the two above variables.
- **featuresList** - table contents of *features.txt*
- **validColumns** - logical vector of which features to use in tidy data set
- **tidyData** - subsetted, human-readable data ready for output according to project description.
- **uSubj** - unique subjects from S
- **nSubj** - number of unique subjects
- **lal** - number of activities
- **cnd** - logical condition to select each activity and each variable
- **tmp** - subset of tidyData with only measurements of means and sd
- **rw** - data table with means for each activity and each variable 
- **tidyData2** - second tiny data set with average of each variable for each activity and subject

----------

###Output

 **tidyData.txt**

*tidyData.txt* is a 10299x68 data frame.

- The first column contains subject IDs.
- The second column contains activity names.
- The last 66 columns are measurements.
- Subject IDs are integers between 1 and 30.

**tidyData2.txt**

*tidyData2.txt* is a 180x68 data frame.

- The first column contains subject IDs.
- The second column contains activity names.
- The averages for each of the 66 attributes are in columns 3-68.