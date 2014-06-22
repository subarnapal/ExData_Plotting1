

# Download the zip file containing dataset to start with
# ===========================================================
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="Dataset.zip")	# use this expression to download the zip file in your working directory


# Unzip the downloaded file in a new directory "Dataset" within your working directory
# ===========================================================
unzip("dataset.zip", exdir="Dataset")	# a new directory "Dataset" will be created where the unzipped files / folders will be stored


# Location of the files and run_analysis.R
# ===========================================================
setwd("./Dataset/UCI HAR Dataset")	# Set the working directory as where the data folders "train" and "test" and other descriptive files, e.g. "README.txt", "featutes_info.txt", "activity_labels.text", "features.txt" are stored in your computer


# Keep the "run_analysis.R" in this directory
# ===========================================================


# Read the files in "train" folder
# ===========================================================
train.x <- read.table("./train/X_train.txt", stringsAsFactors=FALSE)
train.y <- read.table("./train/y_train.txt")
train.subject <- read.table("./train/subject_train.txt")

# Read the files in "test" folder
# ===========================================================
test.x <- read.table("./test/X_test.txt", stringsAsFactors=FALSE)
test.y <- read.table("./test/y_test.txt")
test.subject <- read.table("./test/subject_test.txt")


# Read the names of the 561 variables and 6 activities
# ===========================================================
features <- read.table("features.txt", stringsAsFactors=FALSE)	# to read the "features.txt" file to get the descriptive names of the variables
activity <- read.table("activity_labels.txt", stringsAsFactors=FALSE)	# to read the "activity_labels.txt" file to get the descriptive names of the activities


# Manipulating the variables' names stored in the dataframe "features" to clean unwanted characters 
# and provide an unified mnemonic structure to all variables' names
# ===========================================================
v3 <- gsub(",", ".", features$V2)	# to remove the "," and replace it with "."
v4 <- gsub("tBody", "time.Body", v3)	# to remove the "t" as in "tBody" and replace it with "time" to denote it as time domain variable
v5 <- gsub("tGravity", "time.Gravity", v4)	# to remove the "t" as in "tGravity" and replace it with "time" to denote it as time domain variable
v6 <- gsub("fBody", "frequency.Body", v5)	# to remove the "f" as in "fBody" and replace it with "frequency" to denote it as frequency domain variable
v7 <- gsub("fGravity", "frequency.Gravity", v6)		# to remove the "f" as in "fGravity" and replace it with "frequency" to denote it as frequency domain variable
v8 <- gsub(as.character('()'), "", v7, fixed=TRUE)	# to remove the "()" and replace it with ""
v9 <- gsub(as.character('('), ".", v8, fixed=TRUE)	# to remove the "(" and replace it with "."
v10 <- gsub(as.character(')'), "", v9, fixed=TRUE)	# to remove the ")" and replace it with ""
v11 <- gsub("-", ".", v10)


# Assigning the names to the variables in the datasets "train.x" and "test.x"
# ===========================================================
features$v3 <- v11	# to assign the cleansed variables' names to the dataframe "features"
names(train.x) <- features$v3	#  to assign the cleansed variables' names to the dataframe "train.x"
names(test.x) <- features$v3	#  to assign the cleansed variables' names to the dataframe "test.x"


# Combine the activity names and the subject who performed the activity for each row of data in both the datasets
# ===========================================================
train.x <- cbind(train.x, activity$V2[train.y[[1]][]], train.subject)	# to combine the corresponding activity names for each row of data in the dataframe "train.x"
colnames(train.x)[562:563] <- c("activity", "subject")	# to name the two newly combined columns in the dataframe "train.x" as per the last expression

test.x <- cbind(test.x, activity$V2[test.y[[1]][]], test.subject)	# to combine the corresponding activity names for each row of data in the dataframe "test.x"
colnames(test.x)[562:563] <- c("activity", "subject")	# to name the two newly combined columns in the dataframe "test.x" as per the last expression


# Combine the two dataframes "train.x" and "test.x"
# ===========================================================
mergedData <- rbind(train.x, test.x)	# a new dataframe "mergedData" of dimension 10299 X 563 (10299 rows and 563 variables) is created by combining the two dataframes "train.x" and "test.x"


# Extracts only the measurements on the mean and standard deviation for each measurement from the dataframe "mergedData"
# ===========================================================
MeanStdData <- mergedData[, grep('mean|std|activity|subject', names(mergedData), ignore.case=TRUE)]	# to extract the dataframe with column names containing "mean", "std" and "activity" and "subject"
													# this is reqd. to preserve the activity and subject details in the new dataframe "MeanStdData"
													# dimesion of this dataframe is 10299 X 88 (10299 rows and 88 variables including "activity" & "subject"  


# Create a tidy data set from the "MeanStdData" with the average of each variable for each activity and each subject
# ===========================================================
tidyData <- aggregate(.~ (activity + subject), data=MeanStdData, FUN=mean)	# a dataframe "tidyData" of dimension 180 X 88 is created


# Export this tidy data set to create an independent dataset
# ===========================================================
write.table(tidyData, file="tidy_data.txt", sep="\t")	# the file "tidy_data.txt" will be saved in your working directory


# Read this independent tidy data into "R"
# ===========================================================
read.table("tidy_data.txt", sep="\t")	# keep this file "tidy_data.txt" in your working directory and use this expression to read this txt file back in "R"
dim(read.table("tidy_data.txt", sep="\t"))	# this expression will provide the dimension of "tidy_data.txt" as 180 X 88 same as the tidy data set created (to cross verify)
