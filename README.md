# GettingAndCleaningDataProject
## Getting and Cleaning Data Project

### The scope of work

## Source of Data
* The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

* Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The project activity is to create one R Script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Procedure/ Steps
1. Download the provided data source locally onto your system
2. Once the referred source is downloaded, there will be a folder called "UCI HAR Dataset" folder that needs to be extracted
3. Place the run_analysis.R in a folder that is the parent folder of "UCI HAR Dataset" folder
4. Set the working directory to this parent folder that contains the run_analysis.R file and also the UCI HAR Dataset folder (containing other required input files as downloaded)
5. From R Studio, execute the command source (run_analysis.R) and execute. This will create the required tidy_data.txt in the working directory
6. As an additional step, to validate the execution of the script, the tidy_data.txt that is written is read back to ensure that the contents were written properly and it is readable
