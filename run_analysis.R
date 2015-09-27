## read the input data provided

# read the list of all features
featuresData <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)[,2]

# read activity labels
activityLabelsData <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)[,2]

# the training set
xTrainData <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)

# the training labels
yTrainData <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)

# add Activity Name column to yTrainData as we will select this as one of the columns in the tidy data
# in order to get the descriptive activity name to name the activities
yTrainData[,2] <- activityLabelsData[yTrainData[,1]]

# read subject train data
subjectTrainData <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)

# read the test data
xTestData <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)

# read the training labels
yTestData <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)

# add Activity Name column to yTestData as we will select this as one of the columns in the tidy data
# in order to get the descriptive activity name to name the activities
yTestData[,2] <- activityLabelsData[yTestData[,1]]

# read subject test data
subjectTestData <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)

# name the columns for the training data that was read towards providing descriptive variable names
colnames(xTrainData) <- featuresData
colnames(yTrainData) <- c("ActivityId", "ActivityLabel")
colnames(subjectTrainData) <- "SubjectId"

# name the columns for the test data that was read
colnames(xTestData) <- featuresData
colnames(yTestData) <- c("ActivityId", "ActivityLabel")
colnames(subjectTestData) <- "SubjectId"

# create one combined training set
trainingDataset <- cbind(xTrainData, yTrainData, subjectTrainData)

# create one combined test set
testDataset <- cbind(xTestData, yTestData, subjectTestData)

## Merge the training and the test sets to create one data set
combinedData <- rbind(trainingDataset, testDataset)

## Extract only the measurements on the mean and sd for each measurement
# create a logical vector that would be used in extracting just the necessary columns (mean or standard deviation)
logicalFeaturesToExtract <- grepl("mean|std", featuresData)

# extract the only required variables using the logical vector
finalRequiredData <- combinedData[, logicalFeaturesToExtract]

#colnames(finalRequiredData)

# set the id Variables
idVariables <- c("SubjectId", "ActivityId", "ActivityLabel")

# the measure variables...
needed_labels <- setdiff(colnames(finalRequiredData), idVariables)
#needed_labels

# create a melted data set from the combined dataset using id variables and measure variables
meltedData <- melt(combinedData, id=idVariables, measure.vars=needed_labels)

# create a finalData data set by using dcast function
finalDataset <- dcast(meltedData, SubjectId + ActivityLabel ~ variable, mean)

# get the column names as in its current state
colNames <- colnames(finalDataset)

# iterate through all column names and give each column a name that is better readable
for (i in 1:length(colNames)) {
    colNames[i] = gsub("\\()", "", colNames[i])
    colNames[i] = gsub("-std$", "StandardDeviation", colNames[i])
    colNames[i] = gsub("-mean$", "Mean", colNames[i])
    colNames[i] = gsub("^(f)", "Frequency ", colNames[i])
    colNames[i] = gsub("^(t)", "Time", colNames[i])
    colNames[i] = gsub("AccMag", "Acc Magnitude ", colNames[i])
    colNames[i] = gsub("([Bb]ody[Bb]ody | [Bb]ody)", "Body ", colNames[i])
    colNames[i] = gsub("AccJerkMag", "Acc Jerk Magnitude", colNames[i])
    colNames[i] = gsub("GyroMag", "Gyro Magnitude", colNames[i])
    colNames[i] = gsub("GyroJerkMag", "Gyro Jerk Magnitude", colNames[i])
    colNames[i] = gsub("meanFreq", "Mean Frequency", colNames[i])
}

# assign back the column names the new column names after above iteration
colnames(finalDataset) <- colNames

# create a tidy data set called tidy_dataset.txt using write.table function
write.table(finalDataset, file="./tidy_data.txt", row.names=FALSE)

# As an additional step, validate the tidy data set craeated by reading it back using read.table function 
validateData  <- read.table("./tidy_data.txt", header=TRUE)
