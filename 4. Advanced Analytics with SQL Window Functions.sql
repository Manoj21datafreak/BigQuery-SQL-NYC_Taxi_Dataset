-- 1. Running Total of Revenue
WITH daily AS (
  SELECT
    DATE(pickup_datetime) AS trip_date,
    SUM(total_amount) AS daily_revenue
  FROM `telecom-analytics-485606.nyc_taxi.clean_trips_2022`
  GROUP BY trip_date
)

SELECT
  trip_date,
  daily_revenue,
  SUM(daily_revenue) OVER (
    ORDER BY trip_date
  ) AS running_revenue
FROM daily
ORDER BY trip_date;

--2. Month-over-Month Revenue Growth
WITH monthly AS (
  SELECT
    FORMAT_DATE('%Y-%m', DATE(pickup_datetime)) AS month,
    SUM(total_amount) AS revenue
  FROM `telecom-analytics-485606.nyc_taxi.clean_trips_2022`
  GROUP BY month
)

SELECT
  month,
  revenue,
  LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
  ROUND(
    (revenue - LAG(revenue) OVER (ORDER BY month))
    / LAG(revenue) OVER (ORDER BY month) * 100,
    2
  ) AS growth_pct
FROM monthly
ORDER BY month;

--3. Rank Busiest Hours by Demand

WITH hourly AS (
  SELECT
    EXTRACT(HOUR FROM pickup_datetime) AS hour,
    COUNT(*) AS trips
  FROM `telecom-analytics-485606.nyc_taxi.clean_trips_2022`
  GROUP BY hour
)

SELECT
  hour,
  trips,
  DENSE_RANK() OVER (ORDER BY trips DESC) AS demand_rank
FROM hourly
ORDER BY demand_rank;

--4. Top 5 Days by Revenue

WITH daily AS (
  SELECT
    DATE(pickup_datetime) AS trip_date,
    SUM(total_amount) AS revenue
  FROM `telecom-analytics-485606.nyc_taxi.clean_trips_2022`
  GROUP BY trip_date
)

SELECT
  trip_date,
  revenue,
  RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM daily
ORDER BY revenue_rank
LIMIT 5;
