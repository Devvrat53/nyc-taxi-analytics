-- Switch the database from master to nyc_taxi_ldw
USE nyc_taxi_ldw;

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'nyc_taxi_src')
CREATE EXTERNAL DATA SOURCE nyc_taxi_src
WITH (
    LOCATION = 'https://devsynpasedl.dfs.core.windows.net/nyc-taxi-data'
);

