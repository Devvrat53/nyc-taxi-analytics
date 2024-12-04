-- Connect to the database nyc_taxi_src
USE nyc_taxi_ldw
GO


-- Create Stored Procedure for Silver layer calendar data by converting the bronze CSV files to silver parquet files
CREATE OR ALTER PROCEDURE silver.usp_silver_trip_type
AS 
BEGIN
    IF OBJECT_ID('silver.trip_type') IS NOT NULL
        DROP EXTERNAL TABLE silver.trip_type;

    CREATE EXTERNAL TABLE silver.trip_type
        WITH 
        (
            DATA_SOURCE = nyc_taxi_src,
            LOCATION = 'silver/trip_type',
            FILE_FORMAT = parquet_file_format
        )
    AS
    SELECT * FROM bronze.trip_type
END;
