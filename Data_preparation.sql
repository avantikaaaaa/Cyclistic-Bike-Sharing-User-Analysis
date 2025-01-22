-- Data Combining

DROP TABLE IF EXISTS `bike_share.data2020_21_new`;

-- combining all the 12 months data tables into a single table containing data from June 2020 to June 2021.

CREATE TABLE IF NOT EXISTS `bike_share.data2020_21_new` AS (
  SELECT * FROM `bike_share.data2020_6_new`
  UNION ALL
  SELECT * FROM `bike_share.data2020_7_new`
  UNION ALL
  SELECT * FROM `bike_share.data2020_8_new`
  UNION ALL
  SELECT * FROM `bike_share.data2020_9_new`
  UNION ALL
  SELECT * FROM `bike_share.data2020_10_new`
  UNION ALL
  SELECT * FROM `bike_share.data2020_11_new`
  UNION ALL
  SELECT * FROM `bike_share.data2020_12_new`
  UNION ALL
  SELECT * FROM `bike_share.data2021_1_new`
  UNION ALL
  SELECT * FROM `bike_share.data2021_2_new`
  UNION ALL
  SELECT * FROM `bike_share.data2021_3_new`
  UNION ALL
  SELECT * FROM `bike_share.data2021_4_new`
  UNION ALL
  SELECT * FROM `bike_share.data2021_5_new`
  UNION ALL
  SELECT * FROM `bike_share.data2021_6_new`
);

-- checking no of rows which are 4803156

SELECT COUNT(*)
FROM `bike_share.data2020_21_new`;

-- checking for number of null values in all columns
												
select COUNT(*) from `bike_share.data2020_21_new` where ride_id is null;
select COUNT(*) from `bike_share.data2020_21_new` where rideable_type is null;
select COUNT(*) from `bike_share.data2020_21_new` where started_at is null;
select COUNT(*) from `bike_share.data2020_21_new` where ended_at is null;
select COUNT(*) from `bike_share.data2020_21_new` where start_station_name is null;
select COUNT(*) from `bike_share.data2020_21_new` where start_station_id is null;
select COUNT(*) from `bike_share.data2020_21_new` where end_station_name is null;
select COUNT(*) from `bike_share.data2020_21_new` where end_station_id is null;
select COUNT(*) from `bike_share.data2020_21_new` where start_lat is null;
select COUNT(*) from `bike_share.data2020_21_new` where start_lng is null;
select COUNT(*) from `bike_share.data2020_21_new` where end_lat is null;
select COUNT(*) from `bike_share.data2020_21_new` where end_lng is null;
select COUNT(*) from `bike_share.data2020_21_new` where member_casual is null;

-- checking for duplicate rows

SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM `bike_share.data2020_21_new`;

-- ride_id - all have length of 16

SELECT LENGTH(ride_id) AS length_ride_id, COUNT(ride_id) AS no_of_rows
FROM `bike_share.data2020_21_new`
GROUP BY length_ride_id;

-- adding new column ride length

CREATE TABLE IF NOT EXISTS `bike_share.data2020_21_new2` AS (
  SELECT *, timestamp_diff(ended_at, started_at, second) / 60 as ride_len 
  from `bike_share.data2020_21_new`);

-- checking for abnormal ride length

select count(*) from `bike_share.data2020_21_new2` where ride_len<=0; 

-- adding new column day_of_week, month and time_distribution from deep analysis

-- add the new column day of week:

CREATE TABLE `bike_share.data2020_21_new3` AS (
select *,
 CASE
    WHEN dayofweek(started_at) = 1 THEN 'Sunday'
    WHEN dayofweek(started_at) = 2 THEN 'Monday'
    WHEN dayofweek(started_at) = 3 THEN 'Tuesday'
    WHEN dayofweek(started_at) = 4 THEN 'Wednesday'
    WHEN dayofweek(started_at) = 5 THEN 'Thursday'
    WHEN dayofweek(started_at) = 6 THEN 'Friday'
    WHEN dayofweek(started_at) = 7 THEN 'Saturday'
END as Day_of_week from `bike_share.data2020_21_new2`);

-- add the new column month:
CREATE TABLE `bike_share.data2020_21_new4` AS (
select *,
case when format_date('%b',started_at) = 'Jan' then 'Jan'
 when format_date('%b',started_at) = 'Feb' then 'Feb'
 when format_date('%b',started_at) = 'Mar' then 'Mar'
 when format_date('%b',started_at) = 'Apr' then 'Apr'
 when format_date('%b',started_at) = 'May' then 'May'
 when format_date('%b',started_at) = 'Jun' then 'Jun'
 when format_date('%b',started_at) = 'Jul' then 'Jul'
 when format_date('%b',started_at) = 'Aug' then 'Aug'
 when format_date('%b',started_at) = 'Sep' then 'Sep'
 when format_date('%b',started_at) = 'Oct' then 'Oct'
 when format_date('%b',started_at) = 'Nov' then 'Nov'
 when format_date('%b',started_at) = 'Dec' then 'Dec' 
 End  as month from `bike_share.data2020_21_new3`);
 
 -- add the new column time_distribution:

CREATE TABLE `bike_share.data2020_21_new6` AS (
select *, 
CASE
    WHEN HOUR(started_at) BETWEEN 0 AND 4 THEN 'Midnight'
    WHEN HOUR(started_at) BETWEEN 5 AND 11 THEN 'Morning'
    WHEN HOUR(started_at) BETWEEN 12 AND 16 THEN 'Afternoon'
    WHEN HOUR(started_at) BETWEEN 17 AND 20 THEN 'Evening'
    WHEN HOUR(started_at) BETWEEN 21 AND 23 THEN 'Night'
END as Time_distributiion from `bike_share.data2020_21_new5`);