-- Connect to the database nyc_taxi_src
USE nyc_taxi_ldw
GO


-- Create Silver layer data for the calendar by converting the bronze CSV files to silver parquet files
IF OBJECT_ID('silver.vendor') IS NOT NULL
    DROP EXTERNAL TABLE silver.vendor
GO

CREATE EXTERNAL TABLE silver.vendor
    WITH 
    (
        DATA_SOURCE = nyc_taxi_src,
        LOCATION = 'silver/vendor',
        FILE_FORMAT = parquet_file_format
    )
AS
SELECT
    *
FROM
    bronze.vendor
GO

SELECT * FROM silver.vendor
GO
