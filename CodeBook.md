# Getting and Cleaning Data Course Project

This assignment's goal was to summarize specific aspects of an open database used for Human Activity Recognition.


## Data Source

All the data files contained in the /data folder were obtained by unziping the zip file available at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

They were originally extracted from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Getting and Cleaning the Data

1. The first task was to join the train and test datasets. It was done by reading the subject_category.txt, the y_category.txt and the X_category.txt files in both the train and test folders and binding them together.
2. The only measurements that were demanded to be taken into account were those involving the mean and standard deviation of the features observed. So the data was filtered accordingly.
3. The "activity_labels.txt" was then used to name the activities by their identifying numbers.
4. The "features.txt" was then used to identify the measurements corresponding to the dataset columns.
5. Lastly, the desired measurements were then summarised by subject and by activity displaying its means for each group.

## Final Variables
All the below variables are numeric and were normalized, i.e. reduced to values between -1 and 1. This process makes them unitless.

* tBodyAcctGravityAcc
* tBodyAccJerk
* tBodyGyro
* tBodyGyroJerk
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc
* fBodyAccJerk
* fBodyGyro
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

