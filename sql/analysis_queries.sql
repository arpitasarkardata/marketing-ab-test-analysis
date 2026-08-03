-- ============================================
-- STEP 1: Create database and table
-- ============================================
CREATE DATABASE marketing_ab_test;
USE marketing_ab_test;

CREATE TABLE ab_test (
    user_id INT,
    test_group VARCHAR(10),
    converted TINYINT,
    total_ads INT,
    most_ads_day VARCHAR(15),
    most_ads_hour INT
);

-- ============================================
-- STEP 2: Load data
-- ============================================
-- Reset table and fix 'converted' column to hold text values ('True'/'False')
-- since the source CSV stores conversion as text, not 0/1
TRUNCATE TABLE marketing_ab_test.ab_test;
ALTER TABLE marketing_ab_test.ab_test MODIFY COLUMN converted VARCHAR(5);

-- Check MySQL's secure file directory before loading (diagnostic step)
SHOW VARIABLES LIKE 'secure_file_priv';

-- Load CSV data into the table
-- Replace the file path below with the path to marketing_AB.csv on your machine
-- (must be inside MySQL's secure_file_priv directory, or use LOCAL INFILE instead)
-- Note: CSV has an extra leading index column, mapped to @dummy and discarded
LOAD DATA INFILE 'PATH_TO/marketing_AB.csv'
INTO TABLE marketing_ab_test.ab_test
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@dummy, user_id, test_group, converted, total_ads, most_ads_day, most_ads_hour);

-- ============================================
-- STEP 3: Analysis queries
-- ============================================
USE marketing_ab_test;

-- Validity check: confirm group sizes aren't badly imbalanced
SELECT test_group, COUNT(*) AS group_size
FROM marketing_ab_test.ab_test
GROUP BY test_group;

-- Conversion rate by test group
-- (converted is stored as text 'True'/'False', so using SUM(CASE WHEN...) instead of AVG)
SELECT test_group, 
       SUM(CASE WHEN converted = 'True' THEN 1 ELSE 0 END) / COUNT(*) AS conversion_rate
FROM marketing_ab_test.ab_test
GROUP BY test_group;

-- Conversion rate by day and test group (feeds the trend chart)
SELECT most_ads_day, test_group,
       SUM(CASE WHEN converted = 'True' THEN 1 ELSE 0 END) / COUNT(*) AS conversion_rate
FROM marketing_ab_test.ab_test
GROUP BY most_ads_day, test_group;
