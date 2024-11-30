-- Use master database to create a new database
USE master
GO


-- Create database
CREATE DATABASE nyc_taxi_ldw
GO


-- Use UTF-8 collation for the entire database to handle string datatype
ALTER DATABASE nyc_taxi_ldw COLLATE Latin1_General_100_Bin2_UTF8
GO 


-- Switch to the new database
USE nyc_taxi_ldw
GO


-- Creating Schema for the Bronze, Silver and Gold architecture
CREATE SCHEMA bronze
GO

CREATE SCHEMA silver
GO

CREATE SCHEMA gold
GO







