This code generates a tidy data set of accelerometers from the Samsung Galaxy S smartphone in 5 steps. This is the data:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Here are the steps:

I. GENERATE DATA FROM TRAIN DATA: This step makes a data frame of the mean and standard deviation from the Train data. It will also have 2 added columns for the subject and their activities.

II. GENERATE DATA FRAME FOR TEST DATA: This step is the same as I, but for the Test data.

III. MERGE DATA FRAMES: TRAIN-TEST: This step merges data frame generated from I&II.

IV. GENERATE SUMMARY TABLE: makes a summary table of the merged data frame.

V. SUMMARY TABLE: write summary table.

____________________________________________


Lines 3-9 point to location of the files, read by the function ‘run_analysis’.
To execute, edit lines 3-9, source file at the R console and at the command line:

> run_analysis(x)

____________________________________________

Run analysis overview: 	code variables in ‘quotes’

1. run_analysis reads lines from the features.txt to get column labels. ‘lines’

2. It also reads lines from the y_train.txt for activity labels. ‘row_lines’. 

3. Then it makes a vector (‘vec’) with descriptive names for each activity.

4. Extract subject codes into lines (‘subject_lines’) from subject_train.txt and add to a vector ‘subject_code’. 

5. to extract mean and std from X_train (‘train_file’), initiate a variable ‘x’ for index of ‘lines’ with the phrase “mean” or “std”. ‘test_ave’ and ‘test_std’ are boolean variables where if True, the x-th column of ‘train_file’ is extracted using the read.fwf command. These columns will be appended to variable ‘data’ with column label ‘names’.

6. a data frame is then initiated with ‘data’ ,  row names from ‘vec’ , and column labels ‘names’. 

7. finally ‘vec’ and ‘subject_code’ are added as columns to the data frame from previous step(6). 

8. Steps 1 and 7 are repeated for the Test data set X_test.txt

9. Train and Test data frames from steps 1-8 are merged back-to-back as ‘df_final’

10. summary table is made with the ddply command of plyr package. ’summary_table’ and written to a file with the write.table command. 





