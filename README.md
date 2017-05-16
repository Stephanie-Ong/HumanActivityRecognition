# HumanActivityRecognition
An Assignment: Getting and Cleaning Data

##This is an R script called run_analysis.R that does the following.
##1)Merges the training and the test sets to create one data set.
##2)Extracts only the measurements on the mean and standard deviation for each measurement.
##3)Uses descriptive activity names to name the activities in the data set
##4)Appropriately labels the data set with descriptive variable names.
##5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##1-Read Files
read.table("UCI HAR dataset/activity_labels.txt") -> ActivityLabels;
read.table("UCI HAR dataset/features.txt") -> Features;
##1.1-Read "Train Files"
read.table("UCI HAR dataset/train/subject_train.txt") -> SubjectTrain;
read.table("UCI HAR dataset/train/X_train.txt") -> xTrain;
read.table("UCI HAR dataset/train/y_train.txt") -> yTrain;
read.table("UCI HAR dataset/train/Inertial Signals/body_acc_x_train.txt") -> BodyAccXTrain;
read.table("UCI HAR dataset/train/Inertial Signals/body_acc_y_train.txt") -> BodyAccYTrain;
read.table("UCI HAR dataset/train/Inertial Signals/body_acc_z_train.txt") -> BodyAccZTrain;

read.table("UCI HAR dataset/train/Inertial Signals/body_gyro_x_train.txt") -> BodyGyroXTrain;
read.table("UCI HAR dataset/train/Inertial Signals/body_gyro_y_train.txt") -> BodyGyroYTrain;
read.table("UCI HAR dataset/train/Inertial Signals/body_gyro_z_train.txt") -> BodyGyroZTrain;

read.table("UCI HAR dataset/train/Inertial Signals/total_acc_x_train.txt") -> TotalAccXTrain;
read.table("UCI HAR dataset/train/Inertial Signals/total_acc_y_train.txt") -> TotalAccYTrain;
read.table("UCI HAR dataset/train/Inertial Signals/total_acc_z_train.txt") -> TotalAccZTrain;

##1.2-Read "Test Files"
read.table("UCI HAR dataset/test/subject_test.txt") -> SubjectTest;
read.table("UCI HAR dataset/test/X_test.txt") -> xTest;
read.table("UCI HAR dataset/test/y_test.txt") -> yTest;
read.table("UCI HAR dataset/test/Inertial Signals/body_acc_x_test.txt") -> BodyAccXTest;
read.table("UCI HAR dataset/test/Inertial Signals/body_acc_y_test.txt") -> BodyAccYTest;
read.table("UCI HAR dataset/test/Inertial Signals/body_acc_z_test.txt") -> BodyAccZTest;

read.table("UCI HAR dataset/test/Inertial Signals/body_gyro_x_test.txt") -> BodyGyroXTest;
read.table("UCI HAR dataset/test/Inertial Signals/body_gyro_y_test.txt") -> BodyGyroYTest;
read.table("UCI HAR dataset/test/Inertial Signals/body_gyro_z_test.txt") -> BodyGyroZTest;

read.table("UCI HAR dataset/test/Inertial Signals/total_acc_x_test.txt") -> TotalAccXTest;
read.table("UCI HAR dataset/test/Inertial Signals/total_acc_y_test.txt") -> TotalAccYTest;
read.table("UCI HAR dataset/test/Inertial Signals/total_acc_z_test.txt") -> TotalAccZTest;

##2-Prepare Data
##2.1-Prepare Attribute/Feature Names
names(ActivityLabels) <- c("ActivityId","ActivityLabel");
names(Features) <- c("FeatureId","FeatureLabel");
names(SubjectTrain) <- "SubjectId";
names(xTrain) <- Features[,2];
names(yTrain) <- "ActivityId";
names(SubjectTest) <- "SubjectId";
names(xTest) <- Features[,2];
names(yTest) <- "ActivityId";

##2.2-Transform (Parse Data): Add New Column to yTrain and call it yTrain2
yTrain2 <- yTrain;
yTrain2[,2] <- ActivityLabels[,2][yTrain2[,1]];
names(yTrain2) <- c("ActivityId","ActivityLabel");
yTest2 <- yTest;
yTest2[,2] <- ActivityLabels[,2][yTest2[,1]];
names(yTest2) <- c("ActivityId","ActivityLabel");

##2.3-Transform (Feature Selection): Identify only "Mean" & "Standard Deviation" Features
MeanStdDevFeatures <- grepl("mean\\(\\)|std\\(\\)", Features[,2]);

##2.4-Transform (Feature Selection): Select only "Mean" & "Standard Deviation" Features
xTrain[,MeanStdDevFeatures] -> MeanStdDevXTrain;
xTest[,MeanStdDevFeatures] -> MeanStdDevXTest;

##2.5Transform (Parse Data): Combine Subject, Activity & Feature Attributes as a Training Dataset & Test Dataset respectively.
TrainingSet<-cbind(SubjectTrain,yTrain2,MeanStdDevXTrain);
TestSet<-cbind(SubjectTest,yTest2,MeanStdDevXTest);

##3-Checking
dim(ActivityLabels);
dim(Features);
dim(SubjectTrain);
dim(xTrain);
dim(yTrain);
dim(yTrain2);
dim(MeanStdDevXTrain);
dim(TrainingSet);
dim(SubjectTest);
dim(xTest);
dim(yTest);
dim(yTest2);
dim(MeanStdDevXTest);
dim(TestSet);

##4-Transform (Parse Data): Combine both Training Dataset & Test Dataset into a dataset for Analysis.
AnalysisSet<-rbind(TrainingSet,TestSet);

##5-Extract Metadata
as.data.frame(names(AnalysisSet))
summary(AnalysisSet)
