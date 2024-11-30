USE nyc_taxi_discovery;


-- Import data from unqoted csv file
SELECT
    *
FROM
    OPENROWSET(
        BULK 'vendor_unquoted.csv',
        DATA_SOURCE = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        HEADER_ROW = TRUE,
        PARSER_VERSION = '2.0'
    ) AS vendor;


-- Import data from the escaped character file
SELECT
    *
FROM
    OPENROWSET(
        BULK 'vendor_escaped.csv',
        DATA_SOURCE = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        HEADER_ROW = TRUE,
        PARSER_VERSION = '2.0',
        ESCAPECHAR = '\\'
    ) AS vendor;


-- Import data from the quoted character file
SELECT
    *
FROM
    OPENROWSET(
        BULK 'vendor.csv',
        DATA_SOURCE = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        HEADER_ROW = TRUE,
        PARSER_VERSION = '2.0',
        FIELDQUOTE = '"'
    ) AS vendor;

