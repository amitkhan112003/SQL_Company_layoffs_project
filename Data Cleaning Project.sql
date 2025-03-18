-- SQL Project - Data Cleaning

-- now when we are data cleaning we usually follow a few steps
-- 1. Check for duplicates and remove any
-- 2. Standardize data and fix errors
-- 3. Look at null values and see what 
-- 4. Remove any columns and rows that are not necessary - few ways

Select *
From layoffs;


-- first thing we want to do is create a staging table. This is the one we will work in and clean the data. We want a table with the raw data in case something happens

CREATE TABLE layoffs_staging 
LIKE layoffs;

INSERT layoffs_staging 
SELECT * FROM layoffs;

Select * 
From layoffs_staging; 

-- 1. Remove Duplicates

# First let's check for duplicates


SELECT *
FROM layoffs_staging;


SELECT *,
		ROW_NUMBER() OVER (
			PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
	FROM layoffs_staging;
    
With duplicate_cte AS
(
SELECT *,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
	FROM layoffs_staging
)
Select *
From duplicate_cte
Where row_num > 1;

-- let's just look at oda to confirm

SELECT *
FROM layoffs_staging
WHERE company = 'Oda';


-- Oda doesnt have duplicate values so lets check for casper

SELECT *
FROM layoffs_staging
WHERE company = 'Casper';

-- it looks like these are all legitimate entries and shouldn't be deleted. We need to really look at every single row to be accurate

-- these are our real duplicates 

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Select *
From layoffs_staging2;


Insert into layoffs_staging2
SELECT *,
		ROW_NUMBER() OVER (
			PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
	FROM layoffs_staging;
    
    
Select *
From layoffs_staging2
Where row_num > 1;   

Delete
From layoffs_staging2
Where row_num > 1;   

Select *
From layoffs_staging2;

-- 2.Standardizing Data

Select company, Trim(company)
From layoffs_staging2;

Update layoffs_staging2
Set company = Trim(company);

Select industry
From layoffs_staging2;

Select  distinct industry
From layoffs_staging2
Order By 1;

Select  *
From layoffs_staging2
Where industry LIKE 'Crypto%';

Update layoffs_staging2
Set industry = 'Crypto'
Where industry LIKE 'Crypto%';

Select  *
From layoffs_staging2
Where industry LIKE 'Crypto%';

Select  DISTINCT industry
From layoffs_staging2;

Select  *
From layoffs_staging2;

Select  DISTINCT location
From layoffs_staging2
Order BY 1;

Select  *
From layoffs_staging2
Order BY 1;

Select  DISTINCT country
From layoffs_staging2
Order BY 1;

Select  *
From layoffs_staging2
Where country LIKE 'United States%'
Order By 1;

Select  DISTINCT country, Trim(Trailing '.' From Country)
From layoffs_staging2
Order BY 1;

Update layoffs_staging2
Set country = Trim(Trailing '.' From Country)
Where country Like 'United States%';


Select  DISTINCT country, Trim(Trailing '.' From Country)
From layoffs_staging2
Order BY 1;

Select  `date`
From layoffs_staging2;

SELECT `date`,
    STR_TO_DATE(`date`, '%m/%d/%Y') AS formatted_date
FROM layoffs_staging2;

Update layoffs_staging2
SET `date` =  STR_TO_DATE(`date`, '%m/%d/%Y');

Select  `date`
From layoffs_staging2;

Alter Table layoffs_staging2
Modify Column `date` DATE;

Select *
From layoffs_staging2;

-- 3.Removingg Null Values

Select *
From layoffs_staging2
Where total_laid_off IS NULL
AND percentage_laid_off IS NULL;

Update layoffs_staging2
SET industry = NULL
Where industry = '';

Select *
From layoffs_staging2
Where industry Is Null
Or industry = '';


Select *
From layoffs_staging2
Where company = 'Airbnb';

Select *
From layoffs_staging2 t1
Join layoffs_staging2 t2
	ON t1.company = t2.company
Where (t1.industry IS NULL OR  t1.industry = '')  
AND t2.industry IS NOT NULL;

Select t1.industry, t2.industry
From layoffs_staging2 t1
Join layoffs_staging2 t2
	ON t1.company = t2.company
Where (t1.industry IS NULL OR  t1.industry = '')  
AND t2.industry IS NOT NULL;

Update layoffs_staging2 t1
Join layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry 
Where t1.industry IS NULL
AND t2.industry IS NOT NULL;


Select *
From layoffs_staging2
Where company LIKE 'Bally%';

Select *
From layoffs_staging2;

Select *
From layoffs_staging2
Where total_laid_off IS NULL
AND percentage_laid_off IS NULL;

Select *
From layoffs_staging2;

-- Removing rows or column

Delete 
From layoffs_staging2
Where total_laid_off IS NULL
AND percentage_laid_off IS NULL;

Alter Table layoffs_staging2
Drop Column row_num;

-- Exploratory Data Analysis

Select *
From layoffs_staging2;

Select MAX(total_laid_off), Max(percentage_laid_off)
From layoffs_staging2;

Select *
From layoffs_staging2
Where percentage_laid_off = 1 ;

Select *
From layoffs_staging2
Where percentage_laid_off = 1 
Order By total_laid_off DESC;

Select company, SUM(total_laid_off)
From layoffs_staging2
group by company 
Order By 2 DESC;

Select MIN(`date`), MAX(`date`)
From layoffs_staging2;

Select industry, SUM(total_laid_off)
From layoffs_staging2
group by industry 
Order By 2 DESC;

Select *
From layoffs_staging2;

Select country, SUM(total_laid_off)
From layoffs_staging2
group by country
Order By 2 DESC;

Select `date`, SUM(total_laid_off)
From layoffs_staging2
group by `date`
Order By 1 DESC;

Select Year(`date`), SUM(total_laid_off)
From layoffs_staging2
group by Year(`date`)
Order By 1 DESC;

Select stage, SUM(total_laid_off)
From layoffs_staging2
group by stage
Order By 2 DESC;

Select company, SUM(percentage_laid_off)
From layoffs_staging2
group by company 
Order By 2 DESC;

Select company, AVG(percentage_laid_off)
From layoffs_staging2
group by company 
Order By 2 DESC;

Select *
From layoffs_staging2;

Select substring(`date`,6,2) AS `MONTH`, SUM(total_laid_off)
From layoffs_staging2
group by substring(`date`,6,2);

Select substring(`date`,6,2) AS `MONTH`, SUM(total_laid_off)
From layoffs_staging2
group by `MONTH`;

Select substring(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
From layoffs_staging2
group by `MONTH`;

Select substring(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
From layoffs_staging2
Where  substring(`date`,1,7) IS NOT NULL
group by `MONTH`
Order By 1 ASC;

WITH Rolling_total AS
 (
    SELECT 
        SUBSTRING(`date`, 1, 7) AS `MONTH`,  -- Extracting Year-Month (YYYY-MM)
        SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
    GROUP BY `MONTH`
    ORDER BY `MONTH` ASC
)
SELECT `MONTH`, total_laid_off,
 SUM(total_laid_off) OVER (ORDER BY `MONTH` ) AS rolling_total
FROM Rolling_total;

Select company, SUM(total_laid_off)
From layoffs_staging2
group by company 
Order By 2 DESC;

Select company, YEAR(`date`), SUM(total_laid_off)
From layoffs_staging2
group by company, YEAR(`date`)
ORDER BY 3 DESC; 

WITH Company_Year (company, years, total_laid_off) AS
(
Select company, YEAR(`date`), SUM(total_laid_off)
From layoffs_staging2
group by company, YEAR(`date`)
), Company_Year_Rank AS
(SELECT *, 
Dense_rank() Over (PARTITION BY years Order By total_laid_off DESC) AS Ranking
From Company_Year
Where Years IS NOT NULL
)
SELECT *
From  Company_Year_Rank
Where Ranking <= 5;

Select * 
From layoffs_staging2;
