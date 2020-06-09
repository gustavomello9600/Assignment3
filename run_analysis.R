#SETUP
library(tidyr) #to get modern version of gather
library(dplyr)

#STEP 1: Joining test and train datasests

   #Integrating testing datasets

      #Getting test subjects
      test_subjects <- read.table("data\\test\\subject_test.txt")

      #Getting test activities
      test_activities <- read.table("data\\test\\y_test.txt")
      
      #Getting test data
      test_data <- read.fwf("data\\test\\X_test.txt", rep(16, 561), sep="")
      
      #Merging datasets
      test <- cbind(test_subjects, test_activities, test_data)

   #Integrating training datasets
      
      #Getting test subjects
      train_subjects <- read.table("data\\train\\subject_train.txt")
      
      #Getting test activities
      train_activities <- read.table("data\\train\\y_train.txt")
      
      #Getting test data
      train_data <- read.fwf("data\\train\\X_train.txt", rep(16, 561), sep="")
      
      #Merging datasets
      train <- cbind(train_subjects, train_activities, train_data)
      
   #Integrating test and train data
   full_data <- rbind(test, train)
   
   #Storing full dataset in a CSV file inside "intermediate_steps" folder
   if (!file.exists("steps")) dir.create("steps")
   write.csv(full_data, file = "steps\\1. Full Data.csv")
   
#STEP 2: Extract only mean() and std() measurements
   
   #Getting the indexes whose features contains the desired measurements
   
      #Reading features indexes
      features <- read.table("data\\features.txt")
      
      #Droping redundant first column and converting to character vector
      features <- as.character(features[[-1]])
      
      #Getting indexes for those containing mean() or std()
      indexes <- grep("(mean[(][)]|std[(][)])", features)
      
   #Subsetting the data according to the desired variables
      
      #Considering the subject and activity columns
      desired_columns <- c(1, 2, indexes + 2)
      
      #Subsetting full data
      desired_data <- full_data[desired_columns]
      
   #Saving resulting dataset in CSV file
      write.csv(desired_data, "steps\\2. Desired Data.csv")
      
#STEP 3: Use descriptive names to the activities
      
   #Creating, from the desired data, a dataset to be labeled
   labeled_data <- desired_data
          
   #Reading activities indexes
   activities <- as.character(read.table("data\\activity_labels.txt")[[2]])
   
   #Converting activity column to factor
   labeled_data[[2]] <- as.factor(labeled_data[[2]])
   
   #Attributing the activities labels to the factor levels
   levels(labeled_data[[2]]) <- activities
   
   #Saving resulting dataset in CSV file
   write.csv(labeled_data, "steps\\3. Labeled Data.csv")
   
#STEP 4: Properly describe the variables
   
   #Creating, from the labeled data, a dataset to be described
   described_data <- labeled_data
   
   #Properly name the columns
   names(described_data) <- c("Subject", "Activity", features[indexes])
   
   #Saving resulting dataset in CSV file
   write.csv(described_data, "steps\\4. Described Data.csv")
   
#STEP 5: Tidy and summarize the data
   
   #Bringing data to a tibble format
   tidy_data <- as_tibble(described_data)
   
   #Tidying data
   tidy_data <- tidy_data %>%
     
                  #pivot_longer is a improved version of gather
                   pivot_longer(
                     -c(1, 2),
                     names_to = c("Feature", "Measurement", "Axis"),
                     names_pattern = "([a-zA-Z]+?)-([meanstd]+?)[(][)]-*([XYZ]+)?",
                     values_to = "Value") %>%
     
                  #pivot_wider is a improved version of spread
                   pivot_wider(
                     names_from = Feature,
                     values_from = Value,
                     values_fn = mean
                   )
   
   #Summarizing the data as requested by the assignment
   summarized_data <- tidy_data %>%
                         group_by(Subject, Activity) %>%
                         summarise(across(-(1:4), ~mean(.x, na.rm = TRUE)))
   
   #Saving resulting dataset in CSV file
   write.csv(summarized_data, "steps\\5. Summarized Data.csv")
   
   
   
   
   
