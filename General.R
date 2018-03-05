#-------------- Package Required
library(tidyverse)
library(scales)
library(gridExtra)
library(caret)
library(dummies)

#------------- Functions Created
reorder_size <- function(x) {           #sorting the columns in bar chart
        factor(x, levels = names(sort(table(x))))
}

xsq_test <- function(x, y = Wrk_Training$Subscription) {
        TableForTest <- table(x, y)
        XsqResults <- chisq.test(TableForTest)
        pvalue <- XsqResults$p.value
        print(XsqResults)
        print("Statistical Significance Level: 5%")
        if (pvalue < 0.05) {
                print("This is a statistical significant result. This variable plays an important role in the decision of clients to subscribe or not to subscribe the bank's term deposit")
        } else {
                print("This is NOT a statistical significant result. This variable DOES NOT play an important role in the decision of clients to subscribe or not to subscribe the bank's term deposit")
        }
}

xsq_test(Wrk_Training$JobType)

#------------- Data Loaded and Attached
Bank_PhoneCalls <- read.table("bank-full.csv", sep = ";", header = T)
colnames(Bank_PhoneCalls) <- c("Age", "JobType", "Marital", "Education", "CreditDefault", "AvgYearlyBalance", "HousingLoan", "PersonalLoan", "ContactType","Day", "Month","Duration", "NumOfContacts", "PassedDays", "Previous", "PreviousOutcome", "Subscription")

#------------- Data Splitting
set.seed(100)
index <- createDataPartition(y = Bank_PhoneCalls$Subscription, p = 0.8, list = F)
Raw_Training <- Bank_PhoneCalls[index,]
Raw_Testing <- Bank_PhoneCalls[-index,]
identical((nrow(Raw_Training) + nrow(Raw_Testing)), nrow(Bank_PhoneCalls))  #Check the number of observations matched

#------------- Numeric Exploratory Data Analysis
head(Raw_Training)
tail(Raw_Training)
str(Raw_Training)
summary(Raw_Training)
summary(Wrk_Training)
str(Wrk_Training)

#------------- Basic Data Transformation
RefLine <- round(4232/31938, 2) #reference line: 12% of subscription rate
RefLine

#------------- Data Preparation
Raw_Training[Raw_Training$Previous == 275,]$Previous <- 2

# Create category for seasonal periods
Raw_Training_Period <- as.character(Raw_Training$Month)
Raw_Training_Season <- rep(NA, 36170)
for (i in 1:length(Raw_Training_Period)){
        if (Raw_Training_Period[i] %in% c("may", "jun", "jul", "aug")) {
                Raw_Training_Season[i] <- "high"
        } else if (Raw_Training_Period[i] %in% c("feb", "apr", "nov")) {
                Raw_Training_Season[i] <- "medium"
        } else {
                Raw_Training_Season[i] <- "low"
        }
}

Wrk_Training <- Raw_Training %>% 
        mutate(HasPreviousContact = factor(PassedDays != -1, labels = c("no", "yes")),
               AgeGreaterThan60 = factor(Age > 60, labels = c("no", "yes")),
               Season = factor(Raw_Training_Season))

#--------------- Data Preparation for testing dataset

# Create category for seasonal periods
Testing_Period <- as.character(Raw_Testing$Month)
Testing_Season <- rep(NA, 9041)
for (i in 1:length(Testing_Period)){
        if (Testing_Period[i] %in% c("may", "jun", "jul", "aug")) {
                Testing_Season[i] <- "high"
        } else if (Testing_Period[i] %in% c("feb", "apr", "nov")) {
                Testing_Season[i] <- "medium"
        } else {
                Testing_Season[i] <- "low"
        }
}

Raw_Testing <- Raw_Testing %>% 
        mutate(HasPreviousContact = factor(PassedDays != -1, labels = c("no", "yes")),
               AgeGreaterThan60 = factor(Age > 60, labels = c("no", "yes")),
               Season = factor(Testing_Season))

str(Raw_Testing)
