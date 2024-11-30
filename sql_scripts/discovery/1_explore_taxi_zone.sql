-- This is auto-generated code
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://devsynpasedl.dfs.core.windows.net/nyc-taxi-data/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
    ) AS [result]


-- HEADER_ROW set to TRUE, ROWTERMINATOR and FIELDTERMINATOR set
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n'
    ) AS [result]


-- Examine the types of columns
EXEC sp_describe_first_result_set N'SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK ''abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/raw/taxi_zone.csv'',
        FORMAT = ''CSV'',
        PARSER_VERSION = ''2.0'',
        HEADER_ROW = TRUE
    ) AS [result]'


-- Get max length of each column
SELECT
    MAX(LEN(LocationID)) AS len_LocationId,
    MAX(LEN(Borough)) AS len_Borough,
    MAX(LEN(Zone)) AS len_Zone,
    MAX(LEN(service_zone)) AS len_service_zone
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) AS [result]


-- Use WITH clause to provide explicit data types
SELECT
    *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) 
    WITH(
        LocationID SMALLINT,
        Borough VARCHAR(15),
        Zone VARCHAR(50),
        service_zone VARCHAR(15)
    )AS [result]


-- Create Stored Procedures
EXEC sp_describe_first_result_set N'SELECT
    *
FROM
    OPENROWSET(
        BULK ''abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/raw/taxi_zone.csv'',
        FORMAT = ''CSV'',
        PARSER_VERSION = ''2.0'',
        HEADER_ROW = TRUE
    ) 
    WITH(
        LocationID SMALLINT,
        Borough VARCHAR(15),
        Zone VARCHAR(50),
        service_zone VARCHAR(15)
    )AS [result]'


-- Check collation
SELECT name, collation_name FROM sys.databases;


-- Specify UTF-8 Collation for VARCHAR characters 
SELECT
    *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) 
    WITH(
        LocationID SMALLINT,
        Borough VARCHAR(15) COLLATE Latin1_General_100_CI_AI_SC_UTF8,
        Zone VARCHAR(50) COLLATE Latin1_General_100_CI_AI_SC_UTF8,
        service_zone VARCHAR(15) COLLATE Latin1_General_100_CI_AI_SC_UTF8
    )AS [result]


-- Create a new database and set the collation for the entire database
CREATE DATABASE nyc_taxi_discovery;

USE nyc_taxi_discovery;

ALTER DATABASE nyc_taxi_discovery COLLATE Latin1_General_100_CI_AI_SC_UTF8;

-- Run the query using nyc_taxi_discovery database which is collated to UTF-8
SELECT
    *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) 
    WITH(
        LocationID SMALLINT,
        Borough VARCHAR(15),
        Zone VARCHAR(50),
        service_zone VARCHAR(15)
    )AS [result]


-- Select only subset of columns
SELECT
    *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) 
    WITH(
        Borough VARCHAR(15),
        Zone VARCHAR(50)
    )AS [result]


-- Read data from a file without header
SELECT
    *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/raw/taxi_zone_without_header.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
    ) 
    WITH(
        LocationID SMALLINT,
        Borough VARCHAR(15),
        Zone VARCHAR(50),
        service_zone VARCHAR(15)
    )AS [result]


-- Provide Ordinal Positions for the columns to be selected
SELECT
    *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/raw/taxi_zone_without_header.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
    ) 
    WITH(
        Zone VARCHAR(50) 3,
        Borough VARCHAR(15) 2
    )AS [result]


-- Fix Column names
SELECT
    *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        FIRSTROW = 2,
        PARSER_VERSION = '2.0'
    ) 
    WITH(
        location_id SMALLINT 1,
        borough VARCHAR(15) 2,
        zone VARCHAR(50) 3,
        service_zone VARCHAR(15) 4
    )AS [result]


-- Using PARSER_VERSION = 1.0 to identify the issue which does not get highlighted in the v2.0
SELECT
    *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        FIRSTROW = 2,
        PARSER_VERSION = '1.0'
    ) 
    WITH(
        location_id SMALLINT 1,
        borough VARCHAR(15) 2,
        zone VARCHAR(5) 3,
        service_zone VARCHAR(15) 4
    )AS [result]
-- Output: Bulk load data conversion error (truncation) for row 2, column 3 (zone) in https://devsynpasedl.dfs.core.windows.net/nyc-taxi-data/raw/taxi_zone.csv.


-- Create External Data Source
CREATE EXTERNAL DATA SOURCE nyc_taxi_data
WITH(
    LOCATION = 'abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/'
)

SELECT
    *
FROM
    OPENROWSET(
        BULK 'raw/taxi_zone.csv',
        DATA_SOURCE = 'nyc_taxi_data',
        FORMAT = 'CSV',
        FIRSTROW = 2,
        PARSER_VERSION = '2.0',
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n'
    ) 
    WITH(
        location_id SMALLINT 1,
        borough VARCHAR(15) 2,
        zone VARCHAR(50) 3,
        service_zone VARCHAR(15) 4
    )AS [result]


-- Creating the RAW data external data source
CREATE EXTERNAL DATA SOURCE nyc_taxi_data_raw
WITH(
    LOCATION = 'abfss://nyc-taxi-data@devsynpasedl.dfs.core.windows.net/raw'
)

SELECT
    *
FROM
    OPENROWSET(
        BULK 'taxi_zone.csv',
        DATA_SOURCE = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        FIRSTROW = 2,
        PARSER_VERSION = '2.0',
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n'
    ) 
    WITH(
        location_id SMALLINT 1,
        borough VARCHAR(15) 2,
        zone VARCHAR(50) 3,
        service_zone VARCHAR(15) 4
    )AS [result]


-- Drop data source
DROP EXTERNAL DATA SOURCE nyc_taxi_data;


-- Check which data source is the database pointing to
SELECT name, location FROM sys.external_data_sources;


