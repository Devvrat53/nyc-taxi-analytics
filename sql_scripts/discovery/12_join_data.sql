-- Connect to the database
USE nyc_taxi_discovery;


-- Identify number of trips made from each bridge
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/',
        FORMAT = 'PARQUET',
        DATA_SOURCE = 'nyc_taxi_data_raw'
    ) AS [result]
    WHERE PULocationID IS NOT NULL;


-- JOIN
SELECT
    taxi_zone.*, trip_data.*
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/',
        FORMAT = 'PARQUET',
        DATA_SOURCE = 'nyc_taxi_data_raw'
    ) AS trip_data
    JOIN
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        FIRSTROW = 2,
        PARSER_VERSION = '2.0'
    ) 
    WITH(
        location_id SMALLINT 1,
        Borough VARCHAR(15) 2,
        zone VARCHAR(50) 3,
        service_zone VARCHAR(15) 4
    )AS taxi_zone
    ON trip_data.PULocationID = taxi_zone.location_id;


-- GROUP BY on Borough
SELECT
    taxi_zone.borough, COUNT(1) AS number_of_trips
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/',
        FORMAT = 'PARQUET',
        DATA_SOURCE = 'nyc_taxi_data_raw'
    ) AS trip_data
    JOIN
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        FIRSTROW = 2,
        PARSER_VERSION = '2.0'
    ) 
    WITH(
        location_id SMALLINT 1,
        Borough VARCHAR(15) 2,
        zone VARCHAR(50) 3,
        service_zone VARCHAR(15) 4
    )AS taxi_zone
    ON trip_data.PULocationID = taxi_zone.location_id
GROUP BY taxi_zone.Borough
ORDER BY number_of_trips;


