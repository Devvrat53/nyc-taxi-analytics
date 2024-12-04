-- Connect to the nyc_taxi_ldw database
USE nyc_taxi_ldw
GO


-- Create a Silver layer taxi_zone Stored Procedure
CREATE OR ALTER PROCEDURE silver.usp_silver_taxi_zone
AS
BEGIN
    -- Query to create the external table
    IF OBJECT_ID('silver.taxi_zone') IS NOT NULL
        DROP EXTERNAL TABLE silver.taxi_zone;

    CREATE EXTERNAL TABLE silver.taxi_zone
        WITH 
        (
            DATA_SOURCE = nyc_taxi_src,
            LOCATION = 'silver/taxi_zone',
            FILE_FORMAT = parquet_file_format
        )
    AS
    SELECT * FROM bronze.taxi_zone;
END;