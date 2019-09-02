


##setwd("C://Users/kassiebe/Desktop/Coursera/Week4_DataCleaning_project")

setwd("C://01 Mylocal driver/Coursera_Data_Science_Specialization/Week4_DataCleaning_projectv2")

### Downloading data from the website

if(!file.exists("./data")){dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl,destfile="./data/Dataset.zip")


## unzip the donloaded zipped file

unzip(zipfile = "./data/Dataset.zip",exdir="./data")

files<-list.files(path, recursive = TRUE)

files


## read data from files

path <- file.path("./data" , "UCI HAR Dataset")

# data from activity files

y_test<-read.table(file.path(path, "test", "Y_test.txt"), header= FALSE)

y_train<-read.table(file.path(path, "train", "Y_train.txt"), header=FALSE)


str(y_test)
str(y_train)

## data from subject files

sub_train<-read.table(file.path(path, "train", "subject_train.txt"),header= FALSE)

sub_test<-read.table(file.path(path, "test",  "subject_test.txt"), header=FALSE)


str(sub_train)

str(sub_test)

#### data from feature files

x_test  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)

x_train <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)

str(x_test)

str(x_train)


## 1:  Merging training and test sets to create one dataset

y_data<-rbind(y_train, y_test)

sub_data<-rbind(sub_train, sub_test)

x_data<-rbind(x_train, x_test)


## Assign names

names(y_data)<- c("activity")

names(sub_data)<-c("subject")

x_dataNames <- read.table(file.path(path, "features.txt"),head=FALSE)

names(x_data)<- x_dataNames$V2

## Merging data

dat1<-cbind(y_data, sub_data)

data_final<-cbind(dat1, x_data)

head(data_final)

#### 2:  Extracting only the measurements on the mean and standard deviation for each measurement.

data_names<-x_dataNames$V2[grep("mean\\(\\)|std\\(\\)", x_dataNames$V2)]

final_selectedNames<-c(as.character(data_names), "subject", "activity" )

data_set<-subset(data_final,select=final_selectedNames)

str(data_set)


### 3: Uses descriptive activity names to name the activities in the data set

activitylables<-read.table(file.path(path, "activity_labels.txt"),header = FALSE)

head(data_set$activity,30)

## Assign lables to data_set

names(data_set)<-gsub("^t", "time", names(data_set))
names(data_set)<-gsub("^f", "frequency", names(data_set))
names(data_set)<-gsub("Acc", "Accelerometer", names(data_set))
names(data_set)<-gsub("Gyro", "Gyroscope", names(data_set))
names(data_set)<-gsub("Mag", "Magnitude", names(data_set))
names(data_set)<-gsub("BodyBody", "Body", names(data_set))

names(data_set)


### Creating a second independent tidy data set

library(dplyr)

tidy_data<-aggregate(. ~subject + activity, data_set, mean)

tidy_data<-tidy_data[order(tidy_data$subject,tidy_data$activity),]

write.table(tidy_data, file = "tidydata.txt",row.name=FALSE)


library(codebook)

dat4<-codebook(data_set)
write.table(dat4, "codebook.md")


####  Produce codebook
# 
#  library(knitr)
#  
#  knit2html("codebook.Rmd")



