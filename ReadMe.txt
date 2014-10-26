ReadMe for run_analysis.r
Author: Sebastian Cruz sebcruz@outlook.com

The run_analysis.r was developed on the Windows version of RStudio Version 0.98.939 using R for Windows x64 version 3.1.0

The single script is broken into several titled and enumerated sections. Before executing run_analysis.r please create and set a working directory from which to execute the script.  The script will execute each section serially and will generate a single text file entitled "TidyActivity_Aggregated.txt".

run_analysis.r Sections
     1. Import Raw and Descriptive Data
     2. Append and Merge Data
     3. Utilize only Target Columns from Merged Data
     4. Append Activity Lables
     5. Summarize by Activity, SubjectID
     6. Export the Tidy Dataset to Working Directory

Analysis Process Comments
Raw measurement data, activity descriptions, and measurement descriptions were provided by the original study in multiple separate text files. Additionally the raw measurement data were broken into two separate datasets, one for Test and another for Training.  Each Test and Train datasets include multiple rows (or observations) per participating Subject and Activity engaged in. Each file was imported by the script and stored in the working directory. Per course project requirements, the separate train and test datasets were merged into a single dataset.  Human friendly descriptive Activity and Measures labels replaced their numerical representations to improve dataset understandability.  Additionally, per course project requirements, measures to be analyzed were limited to just those measures with the text "mean()" or "std" in the field description.  Finally the dataset was summerzied using the mean of each measure such that one record per SubjectID and Activity remained.  A tidy dataset will be exported into the working directory with this summerized dataset.  Please see the commented run_analysis.r script for exact functions and implementation used.

