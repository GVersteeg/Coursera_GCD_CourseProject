# Coursera_GCD_CourseProject

Author: Gerrit Versteeg
Last saved: 23-08-2016

Contains detailed explanation of script "run_analysis.R"
You can load and check the tidy dataset "tidySet.txt" with the following R-code snippet:
```{r}
myURL <- "https://s3.amazonaws.com/coursera-uploads/peer-review/HkJsxW0yEeWEewoyD2Bc5Q/49eefec694612b8c4711706b2b453151/tidySet.txt"
myURL <- sub("^https", "http", myURL)
data <- read.table(myURL, header = TRUE)
View(data)
```

***
## Introduction

This is the read.me file for the graded programming assignment for Course Project (Wk 4) of the Getting and Cleaning Data Course.

The script uses research data on the results of Human Activity Recognition Using Smartphones (ref. http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING-UPSTAIRS, WALKING-DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on their waist. De results have been captured in a number of files and collected into one zip.file, available at:
LINK: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
A further description of the files is given in de read.me file within the zipfile.


***
## Goal of the script run_analysis.R
Goal of the script (and assignment) is to retrieve the files that resulted from the research and to prepare a tidy data from them, that can be used for later analysis. The steps that are required to do so are:
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names.
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

***
## Important notes on design decisions made
Some design decisions needed to be made, because the intended use of the resulting tidy dataset is not described.

**Order & grouping**
I ordered the tidy dataset by activity and then subject, because step 5 of the assignment states "... tidy data set with the average of each variable ** for each activity and each subject**" and I just kept the same order as apparently requested.

**Inertial directories**
I did not use any of the raw data files from the inertial directories because they don't contain any data that can be seen as a mean of standard deviation.

**Selection of meanFreq columns**
We needed to "extract only the variables on the mean and standard deviation for each measurement". I also selected the variables with "meanFreq" in the name, because they can be interpreted as a measurement of 'mean' and they are easy to drop if the analist doesn't need them. Better to be save than sorry, I reckon. 

**Descriptive column names**
I used the names out of the features.txt file, because they depict all the relevant abbreviated keywords (e.g Act, Body, Gyro) for that specific variable. Using longer descriptions would result in very long column names, making it tiresome to do subsequent analysis. The CodeBook can be used for further explanation.

**Descriptive activities**
I used the names out of the activity_labels.txt because they sound pretty self-explanatory.

**Wide versus Long**
I used a wide format for the tidy dataset. Hadley mentions that both are oké and the choice should be dependant on the research you plan to do with the dataset. Because this is unknown, I find the tidy dataset to be more readable in wide format and it can be made long in one simple 'melt'-step. Also the discussion (https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/) shows that wide as well as long comply with the learning goals of the assignment.

**Tidiness of resulting data set**
I think the resulting data set is tidy, because it:
    * only contains columns that refer to one and only one variable and there is a lack of information on how to interpret them in any other fashion.
    * all rows contain only one observation for one subject performing one activity (observational unit).
    * rows and columns are not defined by any value(s).

**Cleaning up the environment as we go**
I tend to remove temporary files, to keep the working directory from cluttering and from using unnecessary memory. To view intermediary results to enable a close watch on the progress of each step, one can single step through the script.

***
## Detailed description of script "run_analysis.R"

### PART 1 - GETTING THE DATA

**Step 0. Loading relevant packages**
    * "plyr" for using mapvalues to efficiently assign labels to activities
    * "dplyr" for fast data set manipulation on tibbles
    * "reshape2" for setting up the resulting tidy dataset

**Step 1: prepare download (URL & landing place)** 
myURL contains the URL of the web location of the zip-file. The HTTPS is stripped to HTTP to make it work on a MAC. After that, the landing place of the zip-file is prepared. A directory ./data is created (if it didn’t already exist), as a subdirectory of the current working directory. The zip-file will downloaded into the ./data directory. I did not check for the possible existence of de temporary zip.file because it that is very unlikely.

**Step 2: download, unzip and delete the zip-file**
The zip-file is downloaded into the data directory, using mode=wb because the file is binary. The date of the download is recorded and will remain available for the analist to use. De zip-file is unzipped into the same data directory.
After unzipping, the zipfile is not needed anymore. Therefor the connection with the zip-file is closed and deleted. 


### PART 2 - MAKING DATAFRAMES OF THE RELEVANT DATA

**Step 3: make tables out of relevant files**
I read all relevant tables into tbl_df (tibble) format for speed in dplyr:
    * activity_labels.txt (labels for activities, format character)
    * features.txt (all 561 variable names, format character)
    * X-train.txt (all of the measurements for subjectgroep "train")
    * X-test.txt (all of the measurements for subjectgroep "test")
    * subject_train.txt (the subject of each row in X-train)
    * subject_test.txt (the subject of each row in X-test)
    * y-train.txt (the activity of each row in X-train)
    * y-test.txt (the activity of each row in X-test)

### PART 3 - MERGING THE VARIOUS COMPONENTS INTO A SINGLE DATA FRAME

**Step 4: Prepare the names for the measurement columns**
To setup valid, self-explanatory column names for the measurement variables, I took three steps to setup a vector that conatinas nice names for the columns of both main measurement data sets:
    * used NameVector as vector with names derived from the features.txt file. Please note that features.txt contains invalid column names that will cause problems in dplyr::bind_rows and dplyr::select later on, therefor we need to make them valid.
    * used "make.names"" to obtain legal and unique column names. Please note that make.names replaces illegal characters into dots, that we need to delete.
    * used "sub"" to delete the resulting "double dot"'s and the "dot at the end"'s.
Note that this step already prepares the self-explanatory variable-names. So we do not need to change the variable-names of the resulting tidy data set anymore.

**Step 5: Name all columns**
Name the columns of the subsets of data from the test and train group:
    * testActs/trainActs get columnname "Activity"
    * testSubjects/trainSubjects get columnname "Subject"
    * testSet/trainSet get the cleansed columnnames derived out of features (in the order of features.txt)

**Step 6: Combine the columns**
Combines the columns of the data from the test-/train groups in the order activity and subject followed by the measurement variables. That order is used because of later grouping based on requirement "for each activity and each subject").Using bind_cols() for speed.

**Step 7: Concatenate test and train sets**
Append the main data rows from the test group to those of the train group, using bind_rows() for speed. 

**Step 8: Select all mean and std variables**
Select columns: Activity, Subject and all column names containing "mean" or "std". I used matches() to avoid reordering of columns into: first all means, then all std's

**Step 9: Label activities meaningful**
I renamed the activities according to the actLabels given. To do so I interpreted the activity column as factors, so that the levels of 'activity' can be renamed in one easy step rather than using a for-loop to change all values. I use the actLabels as a lookup table for the names of the activities. Note: column names were already adapted in step 6 to be more self-explanatory

***
## PART 4 - CREATING AND WRITING THE TIDY DATASET

**Step 10: Sorting**
Sort the resulting subSet on activity and then subject, making it easier to read and making sure grouping is done correctly later on

**Step 11: Melting**
Melt the subSet into LONG form using varNames as a vector of all measurement variables. This makes all names of measurement vars explicit rows in new 'variable' column and makes all values of the measurement vars explicit rows in new 'value' column.

**Step 12: Casting**
Used dcast to create a table in WIDE form again recreating all column names from the 'variable' column and taking the average of all columns for each uniqe activity/subject combination.

**Step 13: Writing**
Write table to text file "tidySet.txt" in the working directory, with headers. If the file already exists (caused by a previous run) I delete it first.