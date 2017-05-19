This is an R script called run_analysis.R that does the following:
1)Merges the training and the test sets to create one data set.
2)Extracts only the measurements on the mean and standard deviation for each measurement.
3)Uses descriptive activity names to name the activities in the data set
4)Appropriately labels the data set with descriptive variable names.
5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each 

subject.

Steps to reproduce this project:
1 - Open the R script run_analysis.r using a text editor.
Change the parameter of the setwd function call to the working directory/folder (i.e., the folder where these the R script file is 

saved).
2 - Run the R script run_analysis.r. It calls the R Markdown file, run_analysis.Rmd, which contains the bulk of the code.
3 - Outputs produced:
	Tidy dataset file DatasetHumanActivityRecognitionUsingSmartphones.txt (tab-delimited text)
	Codebook file codebook.md (Markdown)

How the script works:
0-Call library
	0.1-library(dplyr);
	0.2-library(plyr);
	0.3-library(tidyr);
	0.4-library(readr);

1-Read Files
	1.1-Read "Train Files"
	1.2-Read "Test Files"

2-Prepare Data
	2.1-Prepare Attribute/Feature Names
	2.2-Transform (Parse Data): Add New Column to yTrain and call it yTrain2
	2.3-Transform (Feature Selection): Identify only "Mean" & "Standard Deviation" Features
	2.4-Transform (Feature Selection): Select only "Mean" & "Standard Deviation" Features
	2.5Transform (Bind DataSet Columns): Combine Subject, Activity & Feature Attributes as a Training Dataset & Test Dataset 

respectively.

3-Sanity Check

4-Transform (Bind DataSet Rows): Combine both Training Dataset & Test Dataset into a dataset for Analysis.

5-Extract Metadata

6-Transform (TallData): Melts the Measure Variables into a Tall & Slim DataSet.
	6.1-Method: gather() ... another option is to use melt() eg.melt(DataSet,id=identifier,measure.var=variables)

7-Transform (NewColumns): Create 3 New Columns: Feature, FeatureStatistics, FeatureAxial 
	7.1-Method: Clean the values of the column Variable (..., which are actually the Melted Column Names from gather()) and 

perform  "text-to-column" by non-alphanumeric seperator.

8-Transform (NewColumns): Create 3 New Columns: FeatureDomain, FeatureType & FeatureMeasure.
	8.1-Method: Mutate the above column names and specifying substitude values that matches the regular expression.

9-Transform (NewColumns): Create 2 New Columns:mean, std by spreading the values in column FeatureStatistics.
	9.1-Method: spread()

10-write out TidyData


