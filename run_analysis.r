#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# 1. Import Raw and Descriptive Data
     ## Import Raw Data
     X_test.raw <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"")
     X_train.raw <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"")

     ## Import Subject ID values, Rename Columns
     subject_test.raw <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"")
     subject_train.raw <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"")
     ## Rename Columns
     colnames(subject_test.raw) <- c("SubjectID")
     colnames(subject_train.raw) <- c("SubjectID")

     ## Import Activity ID Values, Rename Columns
     y_test.raw <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"")
     y_train.raw <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"")
     ## Rename Columns
     colnames(y_test.raw) <- c("ActivityID")
     colnames(y_train.raw) <- c("ActivityID")

     ## Import Activity Labels and Feature Names, Rename Columns
     activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", quote="\"")
     features <- read.table("./UCI HAR Dataset/features.txt", quote="\"") #aka Column Names
     ## Rename Columns
     colnames(activity_labels) <- c("ActivityID","Activity") 
     colnames(features) <- c("FeatureID","Feature")

# 2. Append and Merge Data
     ## Append Activity ID and Subject ID Data
     X_test <- cbind(X_test.raw, subject_test.raw, y_test.raw)
     X_train <- cbind(X_train.raw, subject_train.raw, y_train.raw)

     ## Merge Test and Train Datasets, Update column names with Feature names
     data.df <- rbind(X_test, X_train)
     # Rename Columns
     colnames(data.df) <- c(as.character(features$Feature), "SubjectID", "ActivityID")


# 3. Utilize only Target Columns from Merged Data
     ## Isolate Target Columns using grep() with mean and standard deviation
     targetMetricColumns <- rbind(
              features[grep("mean()", features$Feature, fixed=TRUE),]
             ,features[grep("std()", features$Feature, fixed=TRUE),]
     )
     ## Subset Dataset with Target Columns
     data.df.target <- data.df[, c(as.character(targetMetricColumns$Feature), "SubjectID", "ActivityID")]

# 4. Append Activity Lables
     ## Append Activity Lables using Activity ID
     ## Note: merge() will reorder dataframe by ActivityID and move that column to first column position
     data.df.target <- merge(data.df.target, activity_labels, by="ActivityID")

# 5. Summarize by Activity, SubjectID
     ## UnPivot/Melt the dataset to accomidate aggregation by Activity and SubjectID for multiple Measures
     ## Load reshape2 Library to perform melt
     library(reshape2)
     ## Store Measure Column Names in Variable as there are many
     measures = targetMetricColumns$Feature
     ## UnPivot/Melt Dataset
     data.df.target.unpivoted = melt(data.df.target, id=c("SubjectID","ActivityID","Activity"), measure.vars=measures)

     ## Collapse the Dataset by the Activity and SubjectID using Mean for each Measure
     data.mean = dcast(data.df.target.unpivoted, Activity + SubjectID ~ variable, mean)
     
# 6. Export the Tidy Dataset to Working Directory
write.table(data.mean, file="TidyActivity_Aggregated.txt", row.name=FALSE)








