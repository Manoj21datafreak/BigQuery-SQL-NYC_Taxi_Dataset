CREATE SCHEMA IF NOT EXISTS `telecom-analytics-485606.nyc_taxi`;

CREATE OR REPLACE VIEW `telecom-analytics-485606.nyc_taxi.clean_trips_2022` AS
SELECT
  *
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
WHERE
  total_amount > 0
  AND trip_distance > 0
  AND passenger_count IS NOT NULL
  AND passenger_count > 0;

SELECT COUNT(*) 
FROM `telecom-analytics-485606.nyc_taxi.clean_trips_2022`;
