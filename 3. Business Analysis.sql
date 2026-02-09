-- 1 Peak Time Analysis
SELECT
  EXTRACT(HOUR FROM pickup_datetime) AS hour,
  COUNT(*) AS total_trips
FROM `telecom-analytics-485606.nyc_taxi.clean_trips_2022`
GROUP BY hour
ORDER BY hour;

