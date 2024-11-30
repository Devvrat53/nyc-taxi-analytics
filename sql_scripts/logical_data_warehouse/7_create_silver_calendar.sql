-- Connect to the database nyc_taxi_src
USE nyc_taxi_ldw
GO


-- Create Silver layer data for the calendar by converting the bronze CSV files to silver parquet files
IF OBJECT_ID('silver.calendar') IS NOT NULL
    DROP EXTERNAL TABLE silver.calendar
GO

CREATE EXTERNAL TABLE silver.calendar
    WITH 
    (
        DATA_SOURCE = nyc_taxi_src,
        LOCATION = 'silver/calendar',
        FILE_FORMAT = parquet_file_format
    )
AS
SELECT
    *
FROM
    bronze.calendar
GO

SELECT * FROM silver.calendar
GO



