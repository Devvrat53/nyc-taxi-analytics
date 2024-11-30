-- Connect to the nyc_taxi_ldw database
USE nyc_taxi_ldw
GO


-- Create a Silver layer taxi_zone dataset converting csv file to parquet
IF OBJECT_ID('silver.taxi_zone') IS NOT NULL
    DROP EXTERNAL TABLE silver.taxi_zone
GO

CREATE EXTERNAL TABLE silver.taxi_zone
    WITH 
    (
        DATA_SOURCE = nyc_taxi_src,
        LOCATION = 'silver/taxi_zone',
        FILE_FORMAT = parquet_file_format
    )
AS
SELECT
    *
FROM
    bronze.taxi_zone
GO

SELECT * FROM silver.taxi_zone
GO
