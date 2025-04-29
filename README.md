# 🧹 SQL Data Cleaning for Layoffs Dataset

## 📚 Table of Contents  
- 📝 Project Description  
- 🛠 The Steps Taken  
- 🗃 Creating Staging Tables  
- 🚫 Removing Duplicates  
- 🎯 Standardizing Data  
- 🧩 Handling NULL Values  
- 🧺 Removing Unnecessary Columns  
- 📊 Exploratory Data Analysis (EDA)  
- 🧠 Key SQL Queries  
- ✅ Conclusion  

## 📝 Project Description
This project demonstrates how to clean and prepare a **layoffs dataset** using **SQL**. The goal is to address data quality issues such as duplicates, missing values, inconsistent formats, and redundant columns. A clean and reliable version of the dataset is produced for further analysis.

## 🛠 The Steps Taken
- Create a staging table  
- Remove duplicate records  
- Standardize values and formats  
- Handle NULL and empty fields  
- Drop unnecessary columns  
- Perform basic EDA for insights

## 🗃 Creating Staging Tables
- Created `layoffs_staging` as a backup.
- Copied raw data using `CREATE TABLE ... LIKE` and `INSERT INTO ... SELECT *`.
- Verified data integrity before cleaning.

## 🚫 Removing Duplicates
- Used `ROW_NUMBER()` with `PARTITION BY` to detect duplicates.
- Retained the first occurrence and removed rows where `ROW_NUMBER() > 1`.

## 🎯 Standardizing Data
- Trimmed whitespaces using `TRIM()`.
- Standardized industry values (e.g., "Crypto" variations grouped).
- Cleaned country names (e.g., removed periods).
- Converted date strings to proper `DATE` using `STR_TO_DATE()`.

## 🧩 Handling NULL Values
- Converted empty fields to NULL.
- Filled missing `industry` fields based on company matches.
- Ensured numeric fields like `total_laid_off` were not left NULL if inferable.

## 🧺 Removing Unnecessary Columns
- Dropped columns like `row_num` after duplicate handling.

## 📊 Exploratory Data Analysis (EDA)
- Layoffs by company, industry, and country.
- Aggregated layoffs by date, month, year.
- Rolling totals with `SUM() OVER`.
- Top 5 companies per year based on layoffs.

## 🧠 Key SQL Queries
- `ROW_NUMBER()` to detect duplicates.
- `STR_TO_DATE()` to fix date formatting.
- `UPDATE`, `DELETE`, `TRIM()` for cleanup.
- `SUM()`, `AVG()`, `MAX()`, `DENSE_RANK()` for insights.

## ✅ Conclusion
The dataset was cleaned and standardized successfully using SQL, making it ready for advanced analytics or BI dashboards. The process improved data reliability for deeper insights into layoff trends across industries and time periods.
