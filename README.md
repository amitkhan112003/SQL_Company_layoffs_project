
## SQL Data Cleaning for Layoffs Dataset

This project demonstrates the process of cleaning and preparing a layoffs dataset for further analysis. 
## Table of Contents

Project Description

The Steps Taken

1. Creating Staging Tables

2. Removing Duplicates

3. Standardizing Data

4. Handling NULL Values

5. Removing Unnecessary Columns

6. Exploratory Data Analysis (EDA)

Key SQL Queries

Conclusion
## Project Description

This project demonstrates the process of cleaning and preparing a layoffs dataset for further analysis. The goal is to handle data inconsistencies, remove duplicates, standardize the data, and remove irrelevant records, which can then be used for more advanced analytics or reporting. We use SQL techniques to ensure that the data is consistent, reliable, and ready for any type of analysis.
## The Steps Taken

1. Creating Staging Tables
To ensure the original data remains intact while we perform cleaning operations, a staging table layoffs_staging was created. This table holds the raw data and acts as a backup in case something goes wrong during the cleaning process.

Steps:

Created the layoffs_staging table using CREATE TABLE ... LIKE.

Inserted all the records from the original layoffs table into the layoffs_staging table.

Queried the layoffs_staging table to ensure the raw data was successfully transferred.

2. Removing Duplicates
The next step was to identify and remove any duplicate entries in the dataset. Duplicates were identified based on multiple columns (e.g., company, location, industry, total laid-off, etc.) using the ROW_NUMBER() function.

Steps:

Used ROW_NUMBER() with PARTITION BY to assign a unique number to each row based on the combination of columns that define duplicates.

Filtered rows where ROW_NUMBER() was greater than 1 (indicating a duplicate) and removed them.

3. Standardizing Data
Data standardization was performed to ensure consistency across columns:

Trimming: Removed leading and trailing whitespaces from the company column.

Categorical Values: Standardized the industry column to group similar values under one category, for example, changing "Crypto" variants to a single "Crypto".

Country Name Standardization: Trimmed trailing periods from country names, such as "United States." becoming "United States".

Date Formatting: The date column was converted into a proper DATE data type using the STR_TO_DATE() function.

4. Handling NULL Values
We checked for NULL or empty values in critical columns like industry, total_laid_off, and percentage_laid_off. These were handled as follows:

Replaced empty industry values with NULL.

Updated NULL values in industry by using valid data from other rows where the same company was present.

5. Removing Unnecessary Columns
Once the cleaning was done, we dropped any unnecessary columns, such as the row_num column used to track duplicate rows during the cleaning process.

6. Exploratory Data Analysis (EDA)
Finally, exploratory data analysis (EDA) was performed to gain insights into the dataset. The analysis focused on:

Total layoffs per company, industry, and country.

Aggregating layoffs by date and time periods (monthly, yearly).

Calculating rolling totals of layoffs over time.

Identifying the top 5 companies with the highest layoffs for each year.
## Key SQL Queries

ROW_NUMBER(): Used to identify duplicate rows by creating a partitioned ranking.

STR_TO_DATE(): Converts string dates into proper DATE format for consistency.

TRIM(): Removes leading and trailing whitespaces from strings.

UPDATE and DELETE: Used to clean records, such as filling in NULL values or removing unnecessary rows.

Aggregation Functions: SUM(), AVG(), MIN(), MAX() were used to calculate statistics on layoffs.

DENSE_RANK(): Employed to rank companies based on layoffs within specific years.

Window Functions: SUM() OVER (PARTITION BY ...) used to calculate rolling totals over time.
## Conclusion

The SQL Data Cleaning process was successfully completed, transforming a raw and inconsistent dataset into a clean, standardized version suitable for further analysis. Key steps included removing duplicates, handling NULL values, standardizing categorical data, and ensuring proper date formatting. The cleaned dataset can now be used for deeper insights, such as identifying trends in layoffs across companies, industries, and countries.

This cleaned dataset lays the foundation for further analysis, which can help uncover patterns in layoffs over time and potentially provide valuable insights for businesses and researchers studying employment trends.