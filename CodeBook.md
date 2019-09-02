
The run_analysis.R script performs the data preparation and then followed by the 5 steps required as 
    described in the course project’s definition.

    Download the dataset:Dataset downloaded and extracted under the folder called UCI HAR Dataset

    Assign each data to variables
        

    Merges the training and the test sets to create one data set
        

    Extracts only the measurements on the mean and standard deviation for each measurement
        TidyData (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: 

    Appropriately labels the data set with descriptive variable names
       

    From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
    for each activity and each subject
