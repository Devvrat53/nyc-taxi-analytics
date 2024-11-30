-- Connect to the nyc_taxi_ldw database
USE nyc_taxi_ldw
GO


-- Create Silver layer data for the calendar by converting the bronze CSV files to silver parquet files
IF OBJECT_ID('silver.trip_data_green') IS NOT NULL
    DROP EXTERNAL TABLE silver.trip_data_green
GO

CREATE EXTERNAL TABLE silver.trip_data_green
    WITH 
    (
        DATA_SOURCE = nyc_taxi_src,
        LOCATION = 'silver/trip_data_green',
        FILE_FORMAT = parquet_file_format
    )
AS
SELECT
    *
FROM
    bronze.trip_data_green_csv;

SELECT * FROM silver.trip_data_green;


-- If you want to differentiate the parquet files into different folders, e.g., split by year and month
-- Used Views instead of OPENROWSET function because Views have already partitioned columns in the 'create_bronze_views' files
-- The example below is a manual way of creating multiple files/folders for the PARQUET file format
/*
IF OBJECT_ID('silver.trip_data_green_2020_01') IS NOT NULL
    DROP EXTERNAL TABLE silver.trip_data_green_2020_01
GO

CREATE EXTERNAL TABLE silver.trip_data_green_2020_01
    WITH 
    (
        DATA_SOURCE = nyc_taxi_src,
        LOCATION = 'silver/trip_data_green/year=2020/month=01',
        FILE_FORMAT = parquet_file_format
    )
AS
SELECT
    *
FROM
    bronze.vw_trip_data_green_csv
WHERE
    year = '2020' AND month = '01';

SELECT * FROM silver.trip_data_green_2020_01;
*/


-- The efficient way to do this is using Stored Procedure
EXEC silver.usp_silver_trip_data_green '2020', '01';
EXEC silver.usp_silver_trip_data_green '2020', '02';
EXEC silver.usp_silver_trip_data_green '2020', '03';
EXEC silver.usp_silver_trip_data_green '2020', '04';
EXEC silver.usp_silver_trip_data_green '2020', '05';
EXEC silver.usp_silver_trip_data_green '2020', '06';
EXEC silver.usp_silver_trip_data_green '2020', '07';
EXEC silver.usp_silver_trip_data_green '2020', '08';
EXEC silver.usp_silver_trip_data_green '2020', '09';
EXEC silver.usp_silver_trip_data_green '2020', '10';
EXEC silver.usp_silver_trip_data_green '2020', '11';
EXEC silver.usp_silver_trip_data_green '2020', '12';
EXEC silver.usp_silver_trip_data_green '2021', '01';
EXEC silver.usp_silver_trip_data_green '2021', '02';
EXEC silver.usp_silver_trip_data_green '2021', '03';
EXEC silver.usp_silver_trip_data_green '2021', '04';
EXEC silver.usp_silver_trip_data_green '2021', '05';
EXEC silver.usp_silver_trip_data_green '2021', '06';


