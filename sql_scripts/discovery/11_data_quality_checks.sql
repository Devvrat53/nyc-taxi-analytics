USE nyc_taxi_discovery;

-- Identify any data quality issues in trip total amount
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/',
        FORMAT = 'PARQUET',
        DATA_SOURCE = 'nyc_taxi_data_raw'
    ) AS [result]


-- Check min, max and avg total_amount
SELECT
    min(total_amount) AS min_total_amount,
    max(total_amount) AS max_total_amount,
    avg(total_amount) AS avg_total_amount,
    COUNT(1) AS number_of_records,
    COUNT(total_amount) AS not_null_total_number_of_records
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/',
        FORMAT = 'PARQUET',
        DATA_SOURCE = 'nyc_taxi_data_raw'
    ) AS [result]


-- Check the discrepancies in the min total_amount
SELECT
    payment_type,
    COUNT(1) AS number_of_records
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/',
        FORMAT = 'PARQUET',
        DATA_SOURCE = 'nyc_taxi_data_raw'
    ) AS [result]
    WHERE total_amount < 0
    GROUP BY payment_type 
    ORDER BY payment_type;


