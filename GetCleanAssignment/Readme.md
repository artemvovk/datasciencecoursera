# Getting and Cleaning Data Course Project v0.0.1-a1
 _by Artem Vovk_
 _created on 10/16/16_

## Directions:

* You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Review Criteria

* The submitted data set is tidy.
* The Github repo contains the required scripts.
* GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
* The README that explains the analysis files is clear and understandable.
* The work submitted for this project is the work of the student who submitted it.

## TODO

* Use Readme.txt to see how datasets align - measure dimensions

 * X_test + Y_test
 * X_train + Y_train
 * subject_test + subject_train
 * features
 * activity_labels

* Write R code to extract relevant values and align them with relevant columns
 * activity_labels to coded values
 * group by subject_text values
 * extract "means" and "stds" columns

* Refactor column names to be more readable/relevant
