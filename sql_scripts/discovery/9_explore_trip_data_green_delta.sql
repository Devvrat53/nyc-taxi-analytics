USE nyc_taxi_discovery;

-- Delta tables are parquet files with special delta logs which indicate they are delta tables.
-- Delta tables gives you additonal columns separted by the folder names, in this case - year and month.
-- It will look for delta_log folder which contains delta log.
SELECT
    *
FROM
    OPENROWSET(
        BULK 'trip_data_green_delta/',
        FORMAT = 'DELTA',
        DATA_SOURCE = 'nyc_taxi_data_raw'
    ) AS trip_data;


-- Querying data inside year=2020 and it throws an error:
-- Content of directory on path 'https://devsynpasedl.dfs.core.windows.net/nyc-taxi-data/raw/trip_data_green_delta/year=2020/_delta_log/*.*' cannot be listed.
SELECT
    *
FROM
    OPENROWSET(
        BULK 'trip_data_green_delta/year=2020/',
        FORMAT = 'DELTA',
        DATA_SOURCE = 'nyc_taxi_data_raw'
    ) AS trip_data;


-- Execute stored procedure to see the data types
EXECUTE sp_describe_first_result_set N'
SELECT
    *
FROM
    OPENROWSET(
        BULK ''trip_data_green_delta/'',
        FORMAT = ''DELTA'',
        DATA_SOURCE = ''nyc_taxi_data_raw''
    ) AS trip_data;
'


-- Changing data types to optimize the query result
SELECT
    *
FROM
    OPENROWSET(
        BULK 'trip_data_green_delta/',
        FORMAT = 'DELTA',
        DATA_SOURCE = 'nyc_taxi_data_raw'
    ) WITH (
        VendorID INT,
        lpep_pickup_datetime datetime2(7),
        lpep_dropoff_datetime datetime2(7),
        store_and_fwd_flag CHAR(1),
        RatecodeID INT,
        PULocationID INT,
        DOLocationID INT,
        passenger_count INT,
        trip_distance FLOAT,
        fare_amount FLOAT,
        extra FLOAT,
        mta_tax FLOAT,
        tip_amount FLOAT,
        tolls_amount FLOAT,
        ehail_fee INT,
        improvement_surcharge FLOAT,
        total_amount FLOAT,
        payment_type INT,
        trip_type INT,
        congestion_surcharge FLOAT,
        year VARCHAR(4),
        month VARCHAR(2)
    ) AS trip_data;


-- Querying selected column using 
SELECT
    *
FROM
    OPENROWSET(
        BULK 'trip_data_green_delta/',
        FORMAT = 'DELTA',
        DATA_SOURCE = 'nyc_taxi_data_raw'
    ) WITH (
        tip_amount FLOAT,
        trip_type INT,
        year VARCHAR(4),
        month VARCHAR(2)
    ) AS trip_data;


-- 
SELECT 
    COUNT(DISTINCT payment_type)
FROM
    OPENROWSET(
        BULK 'trip_data_green_delta/',
        FORMAT = 'DELTA',
        DATA_SOURCE = 'nyc_taxi_data_raw'
    ) AS trip_data
    WHERE year = '2020' and month = '01';


