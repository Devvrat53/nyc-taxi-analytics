USE nyc_taxi_discovery;

-- Import data from trip csv file
SELECT
    *
FROM
    OPENROWSET(
        BULK 'trip_type.tsv',
        DATA_SOURCE = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        HEADER_ROW = TRUE,
        PARSER_VERSION = '2.0',
        FIELDTERMINATOR = '\t'
    ) AS trip_type;


