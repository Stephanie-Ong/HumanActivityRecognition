##This is an R script called run_analysis.R that does the following.
##1)Merges the training and the test sets to create one data set.
##2)Extracts only the measurements on the mean and standard deviation for each measurement.
##3)Uses descriptive activity names to name the activities in the data set
##4)Appropriately labels the data set with descriptive variable names.
##5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


library(dplyr);
library(plyr);
library(tidyr);
library(readr);

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

##2.5Transform (Bind DataSet Columns): Combine Subject, Activity & Feature Attributes as a Training Dataset & Test Dataset respectively.
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

##4-Transform (Bind DataSet Rows): Combine both Training Dataset & Test Dataset into a dataset for Analysis.
DataSet<-rbind(TrainingSet,TestSet);

##5-Extract Metadata
as.data.frame(names(DataSet));
summary(DataSet);
write.table(DataSet, "DataSet.txt") # write out DataSet;

##Optional: Melt - Another option to gather()
##variables <- names(DataSet)[grep("^[t|f]",names(DataSet))]
##identifier <- names(DataSet)[grep("[Id|Label]$",names(DataSet))]
##MeltedDataSet<-melt(DataSet,id=identifier,measure.var=variables)

##6-Melts the Measure Variables into a Tall & Slim DataSet.
GatherDataSet<-gather(DataSet, Variable, Value, -(SubjectId:ActivityLabel));
TallDataSet1<-ddply(GatherDataSet, .(SubjectId,ActivityId,ActivityLabel,Variable), summarise, Average=mean(Value));

##7-Create 3 New Columns: Feature, FeatureStatistics, FeatureAxial 
##Method: Clean the values of the column Variable (..., which are actually the Melted Column Names from gather()) and perform "text-to-column" by non-alphanumeric seperator.
separate(data=TallDataSet1, col=Variable, into = c("Feature","FeatureStatistics","FeatureAxial"), remove=FALSE) -> TallDataSet2;

##8-Create 3 New Columns: FeatureDomain, FeatureType & FeatureMeasure.
##Method: Mutate the above column names and specifying substitude values that matches the regular expression.
mutate(TallDataSet2,FeatureDomain=gsub("[^t|f]|[A-SU-Za-su-z]+[t|T][A-SU-Za-su-z]+","",Feature),FeatureType=gsub("[A-Za-z]+(Body|Gravity)[A-Za-z]+","\\1", perl = TRUE,Feature),FeatureMeasure=gsub("[A-Za-z]+(Acc|AccJerk|Gyro|GyroJerk|AccMag|AccJerkMag|GyroMag|

GyroJerkMag)","\\1", perl = TRUE,Feature)) -> TallDataSet3;
mutate(TallDataSet3, Feature = as.factor(Feature), FeatureStatistics = as.factor(FeatureStatistics), FeatureAxial = as.factor(FeatureAxial), FeatureDomain = as.factor(FeatureDomain), FeatureType = as.factor(FeatureType), FeatureMeasure = as.factor(FeatureMeasure)) ->TallDataSet4;

##9-Create 2 New Columns:mean, std by spreading the values in column FeatureStatistics.
##Method: spread()
select(TallDataSet4,SubjectId,ActivityId,ActivityLabel,FeatureDomain,FeatureType,FeatureMeasure,FeatureAxial,FeatureStatistics,Average) %>% spread(FeatureStatistics,Average, fill=0) %>% ddply(.

(SubjectId,ActivityId,ActivityLabel,FeatureDomain,FeatureType,FeatureMeasure,FeatureAxial), summarise, AverageMean=mean(mean), AverageStandardDeviation=mean(std)) -> TidyData

##10-write out TidyData
write.table(TidyData, "TidyData.txt") ;

