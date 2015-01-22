# INPUT PATH FOR FILES BELOW

features_file <-'./data/UCI_data/features.txt'
train_file <- './data/UCI_data/train/X_train.txt'
activity_train_file <- './data/UCI_data/train/y_train.txt'
subject_train_file <- './data/UCI_data/train/subject_train.txt'
activity_test_file <- './data/UCI_data/test/y_test.txt'
subject_test_file <- './data/UCI_data/test/subject_test.txt'
test_file <- './data/UCI_data/test/X_test.txt'

x <- c(features_file, train_file, activity_train_file, subject_train_file, activity_test_file, subject_test_file,  test_file)


run_analysis <- function(x){		
	
	# read column names from features_file
	cat <- file(features_file)
	lines <- readLines(cat)
	close(cat)
	
	# I. GENERATE DATA FRAME FOR TRAIN DATA
	
	#read activity codes for train data 
	cat <- file(activity_train_file)
	row_lines <- readLines(cat)
	close(cat)
	
	#make row labels from activity code
	vec <- c()
	for (i in row_lines){
	
	if (i == "1"){
		vec <- append(vec, "WALKING")
	}
	
	else if (i == "2"){
		vec <- append(vec, "WALKING_UPSTAIRS")
	}
	
	else if (i == "3"){
		vec <- append(vec, "WALKING_DOWNSTAIRS")
	}
	
	else if (i == "4"){
		vec <- append(vec, "SITTING")
	}
	
	else if (i == "5"){
		vec <- append(vec, "STANDING")
	}
	
	else if (i == "6"){
		vec <- append(vec, "LAYING")
	}
	
	}
	
	#extract activity codes
	activity_code <- c()
	for (i in row_lines){
		activity_code <- c(activity_code, as.numeric(i))
	}

	#extract subject codes
	cat <- file(subject_train_file)
	subject_lines <- readLines(cat)
	close(cat)
	
	subject_code <- c()
	for (i in subject_lines){
		subject_code <- c(subject_code, as.numeric(i))
	}
		
	
	#initiate "train" data frame
	df <- data.frame()
	
	#extract "mean", "std" and column names from "train" file. Append to df. 
	x <- 0
	names <- c()
	for (i in lines){

		test_ave <- grepl("mean", i, ignore.case = TRUE)
		test_std <- grepl("std", i, ignore.case = TRUE)

		if (test_ave){
			
			data <- read.fwf(train_file, widths = c(-((16*x) + 1), 16))
			names <- append(names, i)
			df <- append(df, data)
			
			}

		if (test_std){
			
			data <- read.fwf(train_file, widths = c(-((16*x) + 1), 16))
			names <- append(names, i)
			df <- append(df, data)
		}	
	
		x <- x + 1
	}
	
	
	#convert df to "data.frame", assign row and column names, append activity and subject data 
	df <- data.frame(df)
	rownames(df) <- make.names(vec, unique=TRUE)
	colnames(df) <- names
	df <- cbind(df, vec)
	names(df)[names(df) == 'vec'] <- 'activity'
	df <- cbind(df, subject_code)
	names(df)[names(df) == 'subject_code'] <- 'subject'
	
	
	
	
	# II. GENERATE DATA FRAME FOR TEST DATA

	#read activity codes for train data 
	cat <- file(activity_test_file)				# y_test.txt
	row_lines <- readLines(cat)
	close(cat)
	
	#make row labels from activity code
	vec <- c()
	for (i in row_lines){
	
	if (i == "1"){
		vec <- append(vec, "WALKING_TEST")
	}
	
	else if (i == "2"){
		vec <- append(vec, "WALKING_UPSTAIRS_TEST")
	}
	
	else if (i == "3"){
		vec <- append(vec, "WALKING_DOWNSTAIRS_TEST")
	}
	
	else if (i == "4"){
		vec <- append(vec, "SITTING_TEST")
	}
	
	else if (i == "5"){
		vec <- append(vec, "STANDING_TEST")
	}
	
	else if (i == "6"){
		vec <- append(vec, "LAYING_TEST")
	}
	}

	#extract activity codes
	activity_code <- c()
	for (i in row_lines){
		activity_code <- c(activity_code, as.numeric(i))
	}

	#extract subject codes
	cat <- file(subject_test_file)		#subject_test.txt
	subject_lines <- readLines(cat)
	close(cat)
	
	subject_code <- c()
	for (i in subject_lines){
		subject_code <- c(subject_code, as.numeric(i))
	}

	#initiate "test" data frame
	df_test <- data.frame()

	#extract "mean", "std" and column names from "train" file. Append to df. 
	x <- 0
	names <- c()
	for (i in lines){

		test_ave <- grepl("mean", i, ignore.case = TRUE)
		test_std <- grepl("std", i, ignore.case = TRUE)

		if (test_ave){
			
			data <- read.fwf(test_file, widths = c(-((16*x) + 1), 16))
			names <- append(names, i)
			df_test <- append(df_test, data)
			
			}

		if (test_std){
			
			data <- read.fwf(test_file, widths = c(-((16*x) + 1), 16))
			names <- append(names, i)
			df_test <- append(df_test, data)
		}	
	
		x <- x + 1
	}

	#convert df to "data.frame", assign row and column names, append activity and subject data 
	df_test <- data.frame(df_test)
	rownames(df_test) <- make.names(vec, unique=TRUE)
	colnames(df_test) <- names
	df_test <- cbind(df_test, vec)
	names(df_test)[names(df_test) == 'vec'] <- 'activity'
	df_test <- cbind(df_test, subject_code)
	names(df_test)[names(df_test) == 'subject_code'] <- 'subject'


	#  III. MERGE DATA FRAMES: TRAIN-TEST
	
	df_final <- rbind(df, df_test)
	
	# IV. GENERATE SUMMARY TABLE
	
	summary_table <- ddply(df_final, .(subject, activity), numcolwise(mean))
	
	# V. SUMMARY TABLE
		
	write.table(summary_table, file = "summary_table.txt" , row.name = FALSE)
	
	
	
	print(dim(summary_table))
	# print(tail(df))
	#print(tail(df_test))
	# print(attributes(df_test))
	# print(attributes(df_final))
	#print(attributes(df_final))
	# print(length(names))
	#print(df)
	#print(df)
	# print (length(df))
	# print (names(df))
	#df <- data.frame(df)
	# print(dim(df))
	#print(names(df))
	#print (read.fwf(train, widths = c(-1, 15)))
	
	
}
