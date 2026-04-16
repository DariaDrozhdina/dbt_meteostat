WITH hourly_data AS (
    SELECT * 
    FROM {{ref('staging_weather_daily')}}
),
add_features AS (
    SELECT *
		, timestamp::DATE AS date               -- only date (year:month:day) as DATE data type
		, timestamp::TIME AS time  -- only time (hours:minutes:seconds) as TIME data type
        , TO_CHAR(timestamp,'HH24:MI') as hour  -- time (hours:minutes) as TEXT data type
        , TO_CHAR(timestamp, 'FMmonth') AS month_name   -- month name as a TEXT
      	, date_part('day', timestamp ) AS date_day 		-- number of the day of month
		, date_part('month', timestamp) AS date_month 	-- number of the month of year
		, date_part('year', timestamp) AS date_year 		-- number of year
		, DATE_PART('week', timestamp)AS cw 			-- number of the week of year
		, TO_CHAR(timestamp, 'FMmon') AS month_name 	-- name of the month
		, TO_CHAR(timestamp, 'FMdy') AS weekday 
    FROM hourly_data
),
add_more_features AS (
    SELECT *,
             (CASE 
    			WHEN time BETWEEN '00:00:00' AND '05:59:00' THEN 'night'
    			WHEN time BETWEEN '06:00:00' AND '18:00:00' THEN 'day'
    			WHEN time BETWEEN '18:00:00' AND '23:59:00' THEN 'evening'
    		END) AS day_part
        FROM add_features
)
SELECT *
FROM add_more_features