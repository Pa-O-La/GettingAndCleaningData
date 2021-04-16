#You should create one R script called run_analysis.R that does the following. 

# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names. 
# 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)
       
my_path <- getwd()
setwd(my_path)

############################################################################################
##    Download Data
## 
##  You can skip thi section and load the data in the data directory
##  Or you cou upload the data downloading a new dataset 
############################################################################################
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/dataset.zip", method="curl")
# for windows user: lets you choose a file and save its file path in R
zipF<-file.choose() 
# Define the folder where the zip file should be unzipped to 
# unzip the file 
unzip('./data/dataset.zip',exdir='./data')  

############################################################################################
##    READING Data
############################################################################################

#Shows information about the variables used on the feature vector
#feat_info <- read.delim('./data/UCI HAR Dataset/features_info.txt')
#names(feat_info)

#List of all features
feat_list <- read.delim('./data/UCI HAR Dataset/features.txt', sep = " ", header=FALSE )
names(feat_list) = c('id','desc')
#View(feat_list)

#Links the class labels with their activity name
labels <- read.delim('./data/UCI HAR Dataset/activity_labels.txt' , header = FALSE , sep = "")
names(labels) = c('id','desc')
#View(labels)

#Training set
X_train <- read.table('./data/UCI HAR Dataset/train/X_train.txt', sep = "" , header = FALSE)
names(X_train) = feat_list[,2]
#View(X_train)
#Training labels
y_train <- read.table('./data/UCI HAR Dataset/train/y_train.txt', sep = "" , header = FALSE)
names(y_train) ='activity'
#View(y_train)
unique(y_train)

#Test set
X_test<- read.table('./data/UCI HAR Dataset/test/X_test.txt', sep = "" , header = FALSE)
names(X_test) = feat_list[,2]
#View(X_test)
#Test labels.
y_test <- read.table('./data/UCI HAR Dataset/test/y_test.txt', sep = "" , header = FALSE)
names(y_test) ='activity'
#View(y_test)
unique(y_test)

#The following files are available for the train and test data. Their descriptions are equivalent
#Each row identifies the subject who performed the activity for each window sample
#Its range is from 1 to 30
subject_train <- read.table('./data/UCI HAR Dataset/train/subject_train.txt', sep = "" , header = FALSE)  
names(subject_train) ='subject.id'
#View(subject_train)
subject_test <- read.table('./data/UCI HAR Dataset/test/subject_test.txt', sep = "" , header = FALSE)
names(subject_test) ='subject.id'
#View(subject_test)

# set train and test set
dataset.type <- rep("train",dim(X_train)[1])
df_train <- cbind(subject_train, y_train, dataset.type, X_train)
dataset.type <- rep("test",dim(X_test)[1])
df_test <- cbind(subject_test, y_test, dataset.type, X_test)
# remove unused object
rm(subject_train, y_train, X_train,subject_test, y_test, X_test, dataset.type)

############################################################################################
# 1. Merge the training and the test sets to create one data set.
############################################################################################
df <- rbind(df_test, df_train)
# remove unused object
rm (df_test, df_train)

# remove doplicated and invalid names:
names(df) <- make.names(names=names(df), unique=TRUE, allow_ = TRUE)
View(df)

############################################################################################
# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
############################################################################################
search_string = '((*[Mm][Ee][Aa][Nn]*)|(*[Ss][Tt][Dd]*))'
length(feat_list[grep(search_string, feat_list[,2]), 2])  #86 column with mean and std
df <- df %>% select(subject.id, activity,matches(search_string))
View(df)

############################################################################################
# 3 Uses descriptive activity names to name the activities in the data set
############################################################################################
labels
df$activity = labels[df$activity,2]
View(df)

############################################################################################
# 4 Appropriately labels the data set with descriptive variable names.
# use only letters, numbers and points
############################################################################################
names(df)

#replace .. and ... with a single .
colnames(df) <- gsub('\\.\\.+', '', colnames(df))
#remove final .
colnames(df) <- gsub('\\.$', '', colnames(df))
#remove dublicated name: BodyBody -> Body
colnames(df) <- gsub('BodyBody', 'Body', colnames(df))
# initial t became time
# initial f became freq
colnames(df) <- gsub('^t', 'time.', colnames(df))
colnames(df) <- gsub('^f', 'freq.', colnames(df))
colnames(df) <- gsub('.tBody', '.timeBody', colnames(df))
names(df)

############################################################################################
# 5 From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
############################################################################################
df_tidy <- df %>% group_by(subject.id, activity) %>% summarize_each(mean) 
View(df_tidy)

############################################################################################
# save final tidy dataset
############################################################################################
if(!file.exists("./output")){dir.create("./output")}
write.table(df_tidy, './output/df_tidy.txt', row.name=FALSE)
