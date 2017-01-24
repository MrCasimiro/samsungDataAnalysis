run_analysis <- function(path) {
    
    test_dir <- paste(path, "test/",sep="")
    train_dir <- paste(path, "train/",sep="")
    features <- read.table(paste(path,"features.txt",sep=""))
    var_ind <- grep("(mean|std)", features$V2)
    var_labels <- grep("(mean|std)", features$V2, value = TRUE)
    var_labels <- tolower(gsub("[-()]", "", var_labels))
    
    # load the data from the test volunteers
    subject_test <- read.table(paste(test_dir,"subject_test.txt",sep=""))
    x_test <- read.table(paste(test_dir, "X_test.txt",sep=""))
    y_test <- read.table(paste(test_dir, "y_test.txt",sep=""))
    names(subject_test) <- "idsubject"
    names(y_test) <- "idactivity"
    x_test <- x_test[var_ind]
    names(x_test) <- var_labels
    test_data <- cbind(subject_test, y_test, x_test) 
    
    # load the data from trainning volunteers
    subject_train <- read.table(paste(train_dir,"subject_train.txt",sep=""))
    x_train <- read.table(paste(train_dir, "X_train.txt",sep=""))
    y_train <- read.table(paste(train_dir, "y_train.txt",sep=""))
    names(subject_train) <- "idsubject"
    names(y_train) <- "idactivity"
    x_train <- x_train[var_ind]
    names(x_train) <- var_labels
    train_data <- cbind(subject_train, y_train, x_train)
    
    # put the training data under the test data
    # remember: both data have the same number of columns
    # just the number os observations(rows) are different.
    all_data <- join(test_data, train_data, type = "full")
    
    all_data$idactivity <- sub("1", "WALKING", all_data$idactivity)
    all_data$idactivity <- sub("2", "WALKING_UPSTAIRS", all_data$idactivity)
    all_data$idactivity <- sub("3", "WALKING_DOWNSTAIRS", all_data$idactivity)
    all_data$idactivity <- sub("4", "SITTING", all_data$idactivity)
    all_data$idactivity <- sub("5", "STANDING", all_data$idactivity)
    all_data$idactivity <- sub("6", "LAYING", all_data$idactivity)
    
    # take all unique ids of subjects and activities and call each one
    # of sub<id> or act<id>
    sublevels <- paste("subj", levels(as.factor(all_data$idsubject)),sep = "")
    actlevels <- paste("act", levels(as.factor(all_data$idactivity)),sep ="")
    other_data <- data.frame(row.names = c(sublevels,actlevels))
    
    ## for loops through columns of all_data
    for (i in 3:length(all_data)) {
        index = 1 # differenciate column idsubject and column idactivity
        
        ## while loops through all subject and activity for each column
        # in all_data
        count = 1
        while(count < 37) {
            ind = count
            if(count > 30) {
                ind <- count - 30
                ind <- sub("act","",actlevels[ind])
                index = 2
            }
            pattern <- paste("^",ind,"$", sep = "")
            row_index <- grep(pattern, all_data[,index])
            other_data[count,i-2] <- mean(all_data[row_index,i])
            count = count + 1
        }
        
    }
    # name the columns and returns the data containing the average of
    # each variable for each subject and id.
    names(other_data) <- names(all_data)[3:81]
    other_data
}