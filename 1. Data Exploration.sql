-- 1. Sample rows
SELECT *
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
LIMIT 20;

-- 2. Table schema
SELECT
  column_name,
  data_type
FROM `bigquery-public-data.new_york_taxi_trips.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'tlc_yellow_trips_2022';

-- 3. Date range
SELECT
  MIN(pickup_datetime) AS min_date,
  MAX(pickup_datetime) AS max_date
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`;

-- 4. Null value check
SELECT
  COUNTIF(passenger_count IS NULL) AS null_passengers,
  COUNTIF(total_amount IS NULL) AS null_total_amount,
  COUNTIF(trip_distance IS NULL) AS null_distance
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`;

-- 5. Invalid values
SELECT
  COUNTIF(total_amount < 0) AS negative_fares,
  COUNTIF(trip_distance <= 0) AS zero_or_negative_distance,
  COUNTIF(passenger_count <= 0) AS zero_or_negative_passengers
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`;

--6. Basic statistics
SELECT
  AVG(total_amount) AS avg_fare,
  MIN(total_amount) AS min_fare,
  MAX(total_amount) AS max_fare,
  AVG(trip_distance) AS avg_distance
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`;





