-- 1. DATABASE SETUP
-- Creates a new database named 'youtube_proj' to store all project-related tables.
CREATE DATABASE youtube_proj;

-- Sets the current active database to 'youtube_proj'.
USE youtube_proj

-- 2. INITIAL DATA AUDIT
-- Displays all rows from the source table to verify initial data load.
SELECT  * from youtube_video;

-- Identifies rows with missing values in key metrics to pinpoint data gaps.
SELECT *
FROM youtube_video
WHERE impressions IS NULL
   OR likes IS NULL
   OR comments IS NULL;
   
   
-- Detects duplicate entries by counting occurrences of each 'post_id'.   
SELECT post_id, COUNT(*)
FROM youtube_video
GROUP BY post_id
HAVING COUNT(*) > 1

-- 3. FEATURE ENGINEERING
-- Disables safe update mode to allow bulk modifications for feature calculation.
SET SQL_SAFE_UPDATES = 0;

-- Adds 'estimated_views' to store calculated viewership data.
ALTER TABLE youtube_video
ADD COLUMN estimated_views BIGINT;

-- Calculates estimated views: (Impressions * CTR%).
UPDATE youtube_video
SET estimated_views = impressions * (ctr_percent / 100);

DESCRIBE youtube_video;

-- Renames column to better reflect that it stores duration rather than a timestamp.
ALTER TABLE youtube_video
CHANGE upload_date upload_duration VARCHAR(100);

-- Adds a 'viral_flag' to categorize high-performing videos (1 million+ views).
ALTER TABLE youtube_video
ADD COLUMN viral_flag INT;

UPDATE youtube_video
SET viral_flag =
CASE
    WHEN estimated_viewss >= 1000000 THEN 1
    ELSE 0
END;

-- 4. ENGAGEMENT METRICS
-- Adds 'engagement_rate' to measure interaction quality relative to reach.
ALTER TABLE youtube_video
ADD COLUMN engagement_rate DOUBLE;

UPDATE youtube_video
SET engagement_rate =
CASE 
    WHEN impressions = 0 THEN 0
    ELSE (likes + comments + shares) / impressions
END;

-- Adds 'watch_strength' to evaluate how long viewers stay per view.
ALTER TABLE youtube_video
ADD COLUMN watch_strength DOUBLE;

UPDATE youtube_video
SET watch_strength =
CASE
    WHEN estimated_views = 0 THEN 0
    ELSE total_watch_time_hours / estimated_views
END;

-- Retrieves and displays all records from the 'youtube_clean' table.
-- This allows for a final verification of the cleaned and filtered dataset.
SELECT * FROM youtube_clean;

-- Displays the 'estimated_views' for the first 10 rows of the 'youtube_video' table.
-- Using 'LIMIT 10' provides a quick sample of the data to verify that calculations worked correctly.
SELECT estimated_views 
FROM youtube_video 
LIMIT 10;

-- 5. FINAL TABLE CREATION FOR POWER BI
-- Creates the final processed dataset including all engineered features for visualization.
CREATE TABLE youtube_finall AS
SELECT
    post_id,
    video_duration_min,
    avg_view_duration_sec,
    avg_view_percentage,
    subscribers_gained,
    ctr_percentage,
    impressions,
    likes,
    comments,
    shares,
    engagement_rate,
    estimated_views,
    traffic_source,
    content_category,
FROM youtube_video;

-- Verification of the final cleaned dataset
select * from youtube_finall

