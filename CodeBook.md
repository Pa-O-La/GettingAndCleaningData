This codebook explain how my run_analysis.R get the tidy data from the original dataset.

1 Collect data
=================
First I download and unzip the data. You can skip these steps by reading directly the folder data. 

Data Source
-----------------
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

Original data
----------------
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

		- tBodyAcc-XYZ
		- tGravityAcc-XYZ
		- tBodyAccJerk-XYZ
		- tBodyGyro-XYZ
		- tBodyGyroJerk-XYZ
		- tBodyAccMag
		- tGravityAccMag
		- tBodyAccJerkMag
		- tBodyGyroMag
		- tBodyGyroJerkMag
		- fBodyAcc-XYZ
		- fBodyAccJerk-XYZ
		- fBodyGyro-XYZ
		- fBodyAccMag
		- fBodyAccJerkMag
		- fBodyGyroMag
		- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

		- mean(): Mean value
		- std(): Standard deviation
		- mad(): Median absolute deviation 
		- max(): Largest value in array
		- min(): Smallest value in array
		- sma(): Signal magnitude area
		- energy(): Energy measure. Sum of the squares divided by the number of values. 
		- iqr(): Interquartile range 
		- entropy(): Signal entropy
		- arCoeff(): Autorregresion coefficients with Burg order equal to 4
		- correlation(): correlation coefficient between two signals
		- maxInds(): index of the frequency component with largest magnitude
		- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
		- skewness(): skewness of the frequency domain signal 
		- kurtosis(): kurtosis of the frequency domain signal 
		- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
		- angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

		- gravityMean
		- tBodyAccMean
		- tBodyAccJerkMean
		- tBodyGyroMean
		- tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
Please read the dataset's readme file for credits and information about data source and extraction.

I open the file with read.table because they are not csv.

2 Data exploration:
=================
	- features_info.txt: shows information about the variables used on the feature vector
	- features.txt : list of all features
	- activity_labels.txt: links the class labels with their activity name
	- X_train.txt and X_test.txt in the train/test folder keep all the measures, one row for each measurement and one column for each feature. The file has not header, but the names of the feature are in the feature.txt file. 
	- y_train.txt and y_test.txt in the train/test folder has the measure's activity identifier, one row for each measurement. unique function show the 1 to 6 activity.
	- in subject_train.txt and subject_test.txt: each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

3 Create train and test:
=================
	- add 'dataset.type' column to identify 'train' and 'test' data
	- bind the measure with the relative subjects and activities both for train and test set.

4 Merge
=================
Merge the training and the test sets to create one data set and remove duplicated and invalid names

5 Filter
=================
Extract only the measurements on the mean and standard deviation for each measurement by searching the string 'mean' and 'std' in upper and lower case. There are only 86 columns with that features. The resulting dataset contains subject.id, activity and these 86 feature. 

6 Describe
=================
Use descriptive activity names to name the activities in the data set

Appropriately labels the data set with descriptive variable names. For good practice I use only letters, numbers and points and I replace 't' and 'f with 'time' and 'freq' to be more descriptive.

7 The tidy dataset
=================
Finally I create df_tydy from the previous dataset with the average of each variable for each activity and each subject.

8 Save
=================
Save final tidy dataset
