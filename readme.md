The run_analysis contains a function that does a number of things relating to the Samusung data set:
* First it checks to see if the data exists in a directory called galaxydata. If it does not, then it creates the sub directory, downloads the file, and unzips it
* Next, it loads the necessary training and test files as data frames into R.
* It then applies names to all of the measures using the names from the features file
* Using cbind and rbind, the two different sets are combined into one data large data set
* Next, the function uses grep to grab only the mean and std columns in the data set, and creates a new data frame with only these variables
* The function then cleans up the column names by removing unnecessary () and - characters to make them a bit more human-readable
* Finally, the function uses dcast to apply the mean function across all columsn for each subject and activity combo, resulting in the final cleaned data set that will be submitted
