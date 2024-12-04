-- Connect to the database nyc_taxi_src
USE nyc_taxi_ldw
GO


-- Create Stored Procedure for Silver layer calendar data by converting the bronze CSV files to silver parquet files
CREATE OR ALTER PROCEDURE silver.usp_silver_calendar
AS
BEGIN
    IF OBJECT_ID('silver.calendar') IS NOT NULL
        DROP EXTERNAL TABLE silver.calendar;

    CREATE EXTERNAL TABLE silver.calendar
        WITH 
        (
            DATA_SOURCE = nyc_taxi_src,
            LOCATION = 'silver/calendar',
            FILE_FORMAT = parquet_file_format
        )
    AS
    SELECT * FROM bronze.calendar;
END;

