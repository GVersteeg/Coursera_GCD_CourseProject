## Script for getting and cleaning data course programming assignment
## Author: Gerrit Versteeg
## Last saved: 22-08-2016
##
## NOTE: Detailed explanation of each step in the script is provided in: README.md
##
##-----------------------------------------------------------------------------
##---------------- PART 1. GETTING THE DATA -----------------------------------
##
##---- step 0. Loading relevant packages
library("plyr")
library("dplyr")
library("reshape2")
##
##---- step 1: prepare the download (URL & landingplace) -----------------------
myURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
myURL <- sub("^https", "http", myURL)
if (!file.exists("GCDP_data")) {
        dir.create("GCDP_data")
}
##
##---- step 2: download the zip-file, unzip it and delete it------------------- 
download.file(myURL, destfile = "./GCDP_data/temp.zip", mode="wb")
dateDownloaded <- date()
unzip("./GCDP_data/temp.zip", exdir = "./GCDP_data")
unlink("./GCDP_data/temp.zip")
##
##-----------------------------------------------------------------------------
##----- PART 2. MAKING DATAFRAMES OF THE RELEVANT DATA ------------------------
##
##---- step 3: read all relevant txt.files into tibbles for speed in dplyr ----
actLabels <- tbl_df(read.table("./GCDP_data/UCI HAR Dataset/activity_labels.txt", header = FALSE, colClasses = "character"))
features <- tbl_df(read.table("./GCDP_data/UCI HAR Dataset/features.txt", header = FALSE, colClasses = "character"))
trainSet <- tbl_df(read.table("./GCDP_data/UCI HAR Dataset/train/X_train.txt", header = FALSE))
testSet <- tbl_df(read.table("./GCDP_data/UCI HAR Dataset/test/X_test.txt", header = FALSE))
trainSubjects <- tbl_df(read.table("./GCDP_data/UCI HAR Dataset/train/subject_train.txt", header = FALSE))
testSubjects <- tbl_df(read.table("./GCDP_data/UCI HAR Dataset/test/subject_test.txt", header = FALSE))
trainActs <- tbl_df(read.table("./GCDP_data/UCI HAR Dataset/train/y_train.txt", header = FALSE))
testActs <- tbl_df(read.table("./GCDP_data/UCI HAR Dataset/test/y_test.txt", header = FALSE))
##
##
##-----------------------------------------------------------------------------
##----- PART 3. MERGING THE VARIOUS COMPONENTS INTO A SINGLE DATA FRAME -------
##
##---- step 4: Prepare valid, descriptive column names for measurement variables
nameVector = make.names(features$V2, unique = TRUE, allow_ = TRUE)
nameVector <- sub("\\.\\.","", nameVector)
nameVector <- sub("\\.$","", nameVector)
##
##---- step 5: Name the columns of the data from the test and train group -----
colnames(testActs) <- "Activity"
colnames(testSubjects) <- "Subject"
colnames(testSet) <- nameVector
colnames(trainActs) <- "Activity"
colnames(trainSubjects) <- "Subject"
colnames(trainSet) <- nameVector
##
##---- step 6: Combine the columns of the data from the test-/train groups ----
complete_testSet <- bind_cols(testActs, testSubjects, testSet)
complete_trainSet <- bind_cols(trainActs, trainSubjects, trainSet)
##
##---- step 7: Concatenate the main data from test and train group ------------
completeSet <- bind_rows(complete_trainSet, complete_testSet)
##
##---- step 8: Select Activity, Subject and all column containing "mean" or "std"
subSet <- select(completeSet, Activity, Subject, matches("mean|std"))
##
##---- step 9: Renaming the activities according to the actLabels given -------
subSet$Activity <- plyr::mapvalues(as.factor(subSet$Activity), actLabels$V1, actLabels$V2)
##
##---- cleanup work directory -------------------------------------------------
rm("features")
rm("testActs", "testSubjects", "testSet")
rm("trainActs", "trainSubjects", "trainSet")
rm("complete_trainSet", "complete_testSet")
rm("completeSet")
rm("actLabels")
##
##
##-----------------------------------------------------------------------------
##----- PART 4. CREATING AND WRITING THE TIDY DATASET -------------------------
##
##---- step 10: Sort the resulting subSet on activity and then subject --------
subSetSorted <- arrange(subSet, Activity, Subject)
varNames <- names(subSetSorted)[-c(1, 2)]
##
##---- step 11: Melt the subSet into LONG form --------------------------------
subSetMelt <- melt(subSetSorted, id=c("Activity", "Subject"), measure.vars=varNames)
##
##---- step 12: Use dcast to create a table in WIDE form with avarages --------
tidySet <- dcast(subSetMelt, Activity + Subject ~ variable, mean)
##
##---- step 13: Write text file "tidySet.txt" in the working directory --------
if (file.exists("./tidySet.txt")) {
        unlink("./tidySet.txt")
}
write.table(tidySet, file = "./tidySet.txt", row.names = FALSE)
##
##---- cleanup work directory -------------------------------------------------
rm("subSet", "subSetSorted", "subSetMelt", "tidySet", "varNames", "nameVector")
##
##
##---- message to console upon completion -------------------------------------
message("** Script finished succesfully (find tidySet.txt in your working directory)")
##
##
##-----------------------------------------------------------------------------
## End of script
##-----------------------------------------------------------------------------

