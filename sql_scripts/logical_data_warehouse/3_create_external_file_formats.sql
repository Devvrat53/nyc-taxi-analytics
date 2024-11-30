-- Connect to nyc_taxi_ldw database
USE nyc_taxi_ldw;

-- https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/develop-tables-external-tables?tabs=native
-- https://learn.microsoft.com/en-us/sql/t-sql/statements/create-external-file-format-transact-sql?view=azure-sqldw-latest&preserve-view=true&tabs=delimited#syntax
-- Create an external file format for DELIMITED (CSV/TSV) files.

-- CSV file format for parser version 2.0
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'csv_file_format')
CREATE EXTERNAL FILE FORMAT csv_file_format
WITH (
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS ( 
        FIELD_TERMINATOR = ',',
        STRING_DELIMITER = '"',
        FIRST_ROW = 2,
        USE_TYPE_DEFAULT = FALSE,
        ENCODING = 'UTF8',
        PARSER_VERSION = '2.0' )
);


-- CSV file format for parser version 1.0
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'csv_file_format_pv1')
CREATE EXTERNAL FILE FORMAT csv_file_format_pv1
WITH (
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS ( 
        FIELD_TERMINATOR = ',',
        STRING_DELIMITER = '"',
        FIRST_ROW = 2,
        USE_TYPE_DEFAULT = FALSE,
        ENCODING = 'UTF8',
        PARSER_VERSION = '1.0' )
);


-- TSV file format for parser version 2.0
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'tsv_file_format')
CREATE EXTERNAL FILE FORMAT tsv_file_format
WITH (
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS ( 
        FIELD_TERMINATOR = '\t',
        STRING_DELIMITER = '"',
        FIRST_ROW = 2,
        USE_TYPE_DEFAULT = FALSE,
        ENCODING = 'UTF8',
        PARSER_VERSION = '2.0' )
);


-- TSV file format for parser version 1.0
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'tsv_file_format_pv1')
CREATE EXTERNAL FILE FORMAT tsv_file_format_pv1
WITH (
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS ( 
        FIELD_TERMINATOR = '\t',
        STRING_DELIMITER = '"',
        FIRST_ROW = 2,
        USE_TYPE_DEFAULT = FALSE,
        ENCODING = 'UTF8',
        PARSER_VERSION = '1.0' )
);


-- Create external file format for the parquet files
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'parquet_file_format')
CREATE EXTERNAL FILE FORMAT parquet_file_format
WITH (
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
    );


-- Create external file format for the delta files
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'delta_file_format')
CREATE EXTERNAL FILE FORMAT delta_file_format
WITH (
    FORMAT_TYPE = DELTA,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
    );













