-- Connect to the database nyc_taxi_src
USE nyc_taxi_ldw
GO


-- Create Silver layer data for the calendar by converting the bronze CSV files to silver parquet files
IF OBJECT_ID('silver.trip_type') IS NOT NULL
    DROP EXTERNAL TABLE silver.trip_type
GO

CREATE EXTERNAL TABLE silver.trip_type
    WITH 
    (
        DATA_SOURCE = nyc_taxi_src,
        LOCATION = 'silver/trip_type',
        FILE_FORMAT = parquet_file_format
    )
AS
SELECT
    *
FROM
    bronze.trip_type
GO

SELECT * FROM silver.trip_type
GO
