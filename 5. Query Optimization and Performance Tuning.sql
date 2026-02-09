-- 1. Column Pruning

SELECT
  pickup_datetime,
  trip_distance,
  total_amount
FROM `telecom-analytics-485606.nyc_taxi.clean_trips_2022`;

--2. Partition Filters

SELECT
  COUNT(*) AS trips
FROM `telecom-analytics-485606.nyc_taxi.clean_trips_2022`
WHERE pickup_datetime >= '2022-06-01'
  AND pickup_datetime < '2022-07-01';

--3. Pre-Aggregate with Views
CREATE OR REPLACE VIEW `telecom-analytics-485606.nyc_taxi.monthly_revenue` AS
SELECT
  FORMAT_DATE('%Y-%m', DATE(pickup_datetime)) AS month,
  SUM(total_amount) AS revenue
FROM `telecom-analytics-485606.nyc_taxi.clean_trips_2022`
GROUP BY month;

SELECT * FROM `telecom-analytics-485606.nyc_taxi.monthly_revenue`;

--4. Reduce Re-Scanning with CTEs

WITH base AS (
  SELECT total_amount
  FROM `telecom-analytics-485606.nyc_taxi.clean_trips_2022`
)
SELECT
  AVG(total_amount),
  MAX(total_amount)
FROM base;

--5. Use Approx Functions

SELECT
  APPROX_COUNT_DISTINCT(vendor_id) AS vendors
FROM `telecom-analytics-485606.nyc_taxi.clean_trips_2022`;
