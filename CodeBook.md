This codebook explain how my run_analysis.R get the tidy data from the dataset downloaded from link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

- First I download and unzip the data. You can skip these steps by reading directly the folder data. Please read the dataset's readme file for information about data source and extraction.

I open the file with read.table because they are not csv.

- Data exploration:
	- features_info.txt: shows information about the variables used on the feature vector
	- features.txt : list of all features
	- activity_labels.txt: links the class labels with their activity name
	- X_train.txt and X_test.txt in the train/test folder keep all the measures, one row for each measurement and one column for each feature. The file has not header, but the names of the feature are in the feature.txt file. 
	- y_train.txt and y_test.txt in the train/test folder has the measure's activity identifier, one row for each measurement. unique function show the 1 to 6 activity.
	- in subject_train.txt and subject_test.txt: each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- Create train and test:
	- add 'dataset.type' column to identify 'train' and 'test' data
	- bind the measure with the relative subjects and activities both for train and test set.

- Merge the training and the test sets to create one data set and remove duplicated and invalid names

- Extract only the measurements on the mean and standard deviation for each measurement by searching the string 'mean' and 'std' in upper and lower case. There are only 86 columns with that features. The resulting dataset contains subject.id, activity and these 86 feature. 

- Use descriptive activity names to name the activities in the data set

- Appropriately labels the data set with descriptive variable names. For good practice I use only letters, numbers and points and I replace 't' and 'f with 'time' and 'freq' to be more descriptive.

- Finally create df_tydy from the previous dataset with the average of each variable for each activity and each subject.

- Save final tidy dataset
