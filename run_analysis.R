run_analysis <- function() {
    
    library(reshape2)
    
    if (!file.exists("galaxyData")){
        dir.create("galaxyData")
    }
    
    if(!file.exists(".\\galaxyData\\galaxy.zip")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile=".\\galaxyData\\galaxy.zip")
        dateDownloaded <- date()
    }
    
    if(!file.exists(".\\galaxyData\\UCI HAR Dataset\\features.txt")){
        unzip(".\\galaxyData\\galaxy.zip", overwrite = TRUE, exdir = ".\\galaxyData")
    }
    
    
    
    ##list.files(".\\galaxyData")
    
    train_x <- read.table(".\\galaxyData\\UCI HAR Dataset\\train\\X_train.txt", header=FALSE)
    train_y <- read.table(".\\galaxyData\\UCI HAR Dataset\\train\\Y_train.txt", header=FALSE)
    train_subject <- read.table(".\\galaxyData\\UCI HAR Dataset\\train\\subject_train.txt", header=FALSE)
    
    test_x <- read.table(".\\galaxyData\\UCI HAR Dataset\\test\\X_test.txt", header=FALSE)
    test_y <- read.table(".\\galaxyData\\UCI HAR Dataset\\test\\Y_test.txt", header=FALSE)
    test_subject <- read.table(".\\galaxyData\\UCI HAR Dataset\\test\\subject_test.txt", header=FALSE)
    
    features <- read.table(".\\galaxyData\\UCI HAR Dataset\\features.txt", header=FALSE)
    
    names(train_x) <- features$V2
    names(train_y) <- "activity"
    names(train_subject) <- "subjectID"
    names(test_x) <- features$V2
    names(test_y) <- "activity"
    names(test_subject) <- "subjectID"
    
    train <- cbind(train_subject, train_y, train_x)
    test <- cbind(test_subject, test_y, test_x)
    
    full_data <- rbind(train,test)
    
    sub <- grep("*mean*",names(full_data))
    sub <- append(sub, grep("*std*",names(full_data)))
    sub <- append(sub, c(1,2))
    
    cleaned <- full_data[,sort(sub)]
    
    names(cleaned) <- gsub("\\-","",sub("\\(\\)","",names(cleaned),))
    
    cleaned$activity[cleaned$activity == 1] <- "walking"
    cleaned$activity[cleaned$activity == 2] <- "walking_upstairs"
    cleaned$activity[cleaned$activity == 3] <- "walking_downstairs"
    cleaned$activity[cleaned$activity == 4] <- "sitting"
    cleaned$activity[cleaned$activity == 5] <- "standing"
    cleaned$activity[cleaned$activity == 6] <- "laying"
    
    df_melt <- melt(cleaned, id = c("subjectID","activity"))
    
    cleaned <- dcast(df_melt, subjectID + activity ~ variable, mean)
    
    cleaned
    
    
}