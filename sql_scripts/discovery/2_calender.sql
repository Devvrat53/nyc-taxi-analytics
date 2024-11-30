-- This is auto-generated code
USE nyc_taxi_discovery;

SELECT
    *
FROM
    OPENROWSET(
        BULK 'calendar.csv',
        DATA_SOURCE = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        HEADER_ROW = TRUE,
        PARSER_VERSION = '2.0'
    ) AS cal

-- Check data types
EXEC sp_describe_first_result_set N'SELECT
    *
FROM
    OPENROWSET(
        BULK ''calendar.csv'',
        DATA_SOURCE = ''nyc_taxi_data_raw'',
        FORMAT = ''CSV'',
        HEADER_ROW = TRUE,
        PARSER_VERSION = ''2.0''
    ) AS cal
'

-- Fixing the data types using WITH clause
SELECT
    *
FROM
    OPENROWSET(
        BULK 'calendar.csv',
        DATA_SOURCE = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        HEADER_ROW = TRUE,
        PARSER_VERSION = '2.0'
    ) 
    WITH(
        date_key        INT,
        date            DATE,
        year            SMALLINT,
        month           TINYINT,
        day_name        VARCHAR(10),
        day_of_year     SMALLINT,
        week_of_month   TINYINT,
        week_of_year    TINYINT,
        month_name      VARCHAR(10),
        year_month      INT,
        year_week       INT
    )AS cal;


