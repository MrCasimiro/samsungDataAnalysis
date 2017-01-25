# Data analysis of Samsung Galaxy S2 data set

To analyze this data set it will be required to Samsung Dalaxy data set and installed the package _plyr_.
The run_analysis take one parameter: the path to Samsung data set, that for default it's __UCI HAR Dataset__.
In this analysis it will be considered only the measurements that used some kind of mean or std(standard deviation),
for example:
* tBodyAcc-mean()-X: included
* tBodyAcc-std()-X: included
* fBodyBodyGyroJerkMag-meanFreq(): included
* angle(tBodyAccMean, gravity): not included

For more details about the whole variables has been used see the __codebook.md__

# First step

The first step is load the library plyr and set the path to the test and train data sets (folders)

# Second step

The second step is load all variables(measurements) in Samsung data set and then extracts, the index(in row number) 
and the names, only the variables desired(the variables desired have mean or std in your name).
The names has been "normalized" to contains only letters in lower case.

# Third step

The third step is read the the data in *subject_test.txt*, *X_test.txt* and *y_test.txt*, then the columns in subject_test and
y_test has been renamed to "idsubject" and "activityid", respectively.
The X_test contains all data to all measurements, so it has been extracts only the variables desired and then it has been
been renamed all the columns to the names that will be normalized in second step.
After adjusting the three data sets, it has been put this three data set together through the function cbind.

# Fourth step

This step is equal to the third step, the only difference it's the data set, that in this case it's the train data set.

# Fifth step

The fifth step takes the two data set results in third and fourth step and put the second one under the first one through
the join function with the type argument equal to "full".
(Remember that this two data sets have the same number of columns and in the same order).
After doing the join operation, the ids activities has been renamed to your meaning. (1 = WALKING, 2 = WALKING_UPSTAIRS and
so on).

# Sixth step

In this step it has been taked the ids activity and subject levels to rename the rows name in the result data set.
(This step is optional, because the data will be written with the row.names arguments equal to FALSE).

# Seventh step
In this step we loops through the data set we have to populate the result data set, creates in the sixth step.
The first loops go through the measurements in the data set, the second one calculates the mean to each column for each
subject and activity.
And then the result data set it will be written in the path provided in function with the name tidy_dataset.txt



