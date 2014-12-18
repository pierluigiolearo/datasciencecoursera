library ("RCurl")
library("plyr")

##Setting environment
if (!file.exists("./data")){
  dir.create("./data")  
}
## Get instruction
url <- "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
f <- "./data/peerDescr.html"
download.file(url, f, method="auto", quiet = FALSE, mode = "w", cacheOK = FALSE)
## Get data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- "./data/Dataset.zip"
download.file(url, f)
## Unzip dataset
unzip(f,exdir="./data")
path = "./data/UCI HAR Dataset/"

## Read data sets
testData <- read.table(paste(path,"test/X_test.txt", sep=""))
trainData <- read.table(paste(path,"train/X_train.txt", sep=""))

## Read data labels
testLabel <- read.table(paste(path,"test/y_test.txt",sep=""))
trainLabel <- read.table(paste(path,"/train/y_train.txt",sep=""))

## Read labels
activityList <- read.table(paste(path,"activity_labels.txt",sep=""))
featuresList <- read.table(paste(path,"features.txt",sep=""),stringsAsFactors=FALSE)

## Read subjects
testSub <- read.table(paste(path,"test/subject_test.txt",sep=""))
trainSub <- read.table(paste(path,"train/subject_train.txt",sep=""))

## Creata a unique dataset
df <- rbind(testData, trainData)
dim(df) # 10299 rows
dl <- rbind(testLabel,trainLabel)
dim(dl) # 10299 rows
ds <- rbind(testSub,trainSub)
dim(ds) # 10299 rows

## Keep only need data 
validColumns <- grepl("(std|mean[^F])", featuresList$V2, perl=TRUE)
df <- df[,validColumns]


## Naming data to human labels
names(df) <- featuresList$V2[validColumns]
names(df) <- gsub("\\(|\\)", "", names(df))
names(df) <- tolower(names(df))
activityList[,2] = gsub("_", "", tolower(as.character(activityList[,2])))
dl[,1] = activityList[dl[,1], 2]
names(dl) <- "activity" ## Add activity label
names(ds) <- "subject" ## Add subject label

## Create a tidy dataset
tidyData <- cbind(ds, dl, df)
write.table(tidyData, "tidyData.txt",row.name=FALSE)


## Create second tiny data set with avg of each var for each act and each sub
uSubj = unique(ds)[,1]
nSubj = length(uSubj)
lal = length(activityList[,1])


for (i in 1:nSubj) {
  for (j in 1:lal) {
    cnd <- tidyData[,1]==uSubj[i] & tidyData[,2]==activityList$V2[j]
    tmp <- subset(tidyData,cnd)
    tmpData <- tmp[1,1:2]
    tmp$subject <- NULL                 ## Delete the columns not numerics
    tmp$activity <- NULL
    rw <- as.data.frame(lapply(tmp,mean)) ## Find the means
    tmpData <- cbind(tmpData,rw)         ## Reconstruct the dataset 
    if(!exists('tidyData2')) {
      tidyData2 <- tmpData
    }
    else {
      tidyData2 <- rbind(tidyData2,tmpData)
    } 
  }
}

write.table(tidyData2, "tidyData2.txt",row.name=FALSE)
