# 1. Merges the training and the test sets to create one data set.
X <- rbind(x_train,x_test)
Y <- rbind(y_train,y_test)

Subject <- rbind(subject_test,subject_train)

data_merge <- cbind(Subject,X,Y)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

data_extract <- data_merge%>%select(subject, code, contains("mean"), contains("std"))
head(data_extract)


# 3. Uses descriptive activity names to name the activities in the data set.
data_extract$code <- activity[data_extract$code, 2]


# 4. Appropriately labels the data set with descriptive variable names.
names(data_extract)[2] = "activity"
names(data_extract)<-gsub("tBody", "TimeBody", names(data_extract))
names(data_extract)<-gsub("-freq()", "Frequency", names(data_extract), ignore.case = TRUE)
names(data_extract)<-gsub("angle", "Angle", names(data_extract))
names(data_extract)<-gsub("gravity", "Gravity", names(data_extract))
names(data_extract)<-gsub("-mean()", "Mean", names(data_extract), ignore.case = TRUE)
names(data_extract)<-gsub("^t", "Time", names(data_extract))
names(data_extract)<-gsub("-std()", "STD", names(data_extract), ignore.case = TRUE)
names(data_extract)<-gsub("Acc", "Accelerometer", names(data_extract))
names(data_extract)<-gsub("Gyro", "Gyroscope", names(data_extract))
names(data_extract)<-gsub("^f", "Frequency", names(data_extract))
names(data_extract)<-gsub("BodyBody", "Body", names(data_extract))
names(data_extract)<-gsub("Mag", "Magnitude", names(data_extract))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
result <- data_extract %>% group_by(subject, activity) %>% summarise_all(funs(mean))

write.table(result, "Assignment/UCI HAR Dataset/result.txt", row.name=FALSE)
