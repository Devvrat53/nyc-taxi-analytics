-- Change the database from master to nyc_taxi_discovery
USE nyc_taxi_discovery;

SELECT
    CAST(JSON_VALUE(jsonDoc, '$.payment_type') AS SMALLINT) payment_type,
    CAST(JSON_VALUE(jsonDoc, '$.payment_type_desc') AS VARCHAR(15)) payment_type_desc
FROM
    OPENROWSET(
        BULK 'payment_type.json',
        DATA_SOURCE = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '1.0',
        FIELDTERMINATOR = '0x0b',
        FIELDQUOTE = '0x0b',
        ROWTERMINATOR = '0x0a'
    ) 
    WITH(
        jsonDoc NVARCHAR(MAX)
    )AS payment_type;


-- Check the data type of the above query using Stored Procedure
EXEC sp_describe_first_result_set N'
SELECT
    CAST(JSON_VALUE(jsonDoc, ''$.payment_type'') AS SMALLINT) payment_type,
    CAST(JSON_VALUE(jsonDoc, ''$.payment_type_desc'') AS VARCHAR(15)) payment_type_desc
FROM
    OPENROWSET(
        BULK ''payment_type.json'',
        DATA_SOURCE = ''nyc_taxi_data_raw'',
        FORMAT = ''CSV'',
        PARSER_VERSION = ''1.0'',
        FIELDTERMINATOR = ''0x0b'',
        FIELDQUOTE = ''0x0b'',
        ROWTERMINATOR = ''0x0a''
    ) 
    WITH(
        jsonDoc NVARCHAR(MAX)
    )AS payment_type;
'


-- Using OPENJSON function
SELECT
    *
FROM
    OPENROWSET(
        BULK 'payment_type.json',
        DATA_SOURCE = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        FIELDTERMINATOR = '0x0b',
        FIELDQUOTE = '0x0b'
    ) 
    WITH(
        jsonDoc NVARCHAR(MAX)
    )AS payment_type
    CROSS APPLY OPENJSON(jsonDoc)
    WITH(
        payment_type        SMALLINT,
        payemnt_type_desc   VARCHAR(20)
    );


-- Selecting only payment_type and payment_type_desc field
SELECT
    payment_type, payment_type_desc
FROM
    OPENROWSET(
        BULK 'payment_type.json',
        DATA_SOURCE = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        FIELDTERMINATOR = '0x0b',
        FIELDQUOTE = '0x0b'
    ) 
    WITH(
        jsonDoc NVARCHAR(MAX)
    )AS payment_type
    CROSS APPLY OPENJSON(jsonDoc)
    WITH(
        payment_type        SMALLINT,
        payment_type_desc   VARCHAR(20)
    );


-- Giving column name
SELECT
    payment_type, description
FROM
    OPENROWSET(
        BULK 'payment_type.json',
        DATA_SOURCE = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        FIELDTERMINATOR = '0x0b',
        FIELDQUOTE = '0x0b'
    ) 
    WITH(
        jsonDoc NVARCHAR(MAX)
    )AS payment_type
    CROSS APPLY OPENJSON(jsonDoc)
    WITH(
        payment_type    SMALLINT,
        description     VARCHAR(20) '$.payment_type_desc'
    );


-- Reading data from JSON with arrays
SELECT
    CAST(JSON_VALUE(jsonDoc, '$.payment_type') AS SMALLINT) payment_type,
    CAST(JSON_VALUE(jsonDoc, '$.payment_type_desc[0].value') AS VARCHAR(15)) payment_type_desc_0,
    CAST(JSON_VALUE(jsonDoc, '$.payment_type_desc[1].value') AS VARCHAR(15)) payment_type_desc_1
FROM
    OPENROWSET(
        BULK 'payment_type_array.json',
        DATA_SOURCE = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '1.0',
        FIELDTERMINATOR = '0x0b',
        FIELDQUOTE = '0x0b',
        ROWTERMINATOR = '0x0a'
    ) 
    WITH(
        jsonDoc NVARCHAR(MAX)
    )AS payment_type;


-- Use OPENJSON to explore the array
SELECT
    *
FROM
    OPENROWSET(
        BULK 'payment_type_array.json',
        DATA_SOURCE = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '1.0',
        FIELDTERMINATOR = '0x0b',
        FIELDQUOTE = '0x0b',
        ROWTERMINATOR = '0x0a'
    ) 
    WITH(
        jsonDoc NVARCHAR(MAX)
    )AS payment_type
    CROSS APPLY OPENJSON(jsonDoc)
    WITH(
        payment_type SMALLINT,
        payment_type_desc NVARCHAR(MAX) AS JSON
    )
    CROSS APPLY OPENJSON(payment_type_desc)
    WITH(
        sub_type SMALLINT,
        payment_type_desc_value VARCHAR(20) '$.value'
    );

-- Only see relevant columns payment_type_desc and payment_type_desc_value
SELECT
    payment_type, payment_type_desc_value
FROM
    OPENROWSET(
        BULK 'payment_type_array.json',
        DATA_SOURCE = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '1.0',
        FIELDTERMINATOR = '0x0b',
        FIELDQUOTE = '0x0b',
        ROWTERMINATOR = '0x0a'
    ) 
    WITH(
        jsonDoc NVARCHAR(MAX)
    )AS payment_type
    CROSS APPLY OPENJSON(jsonDoc)
    WITH(
        payment_type SMALLINT,
        payment_type_desc NVARCHAR(MAX) AS JSON
    )
    CROSS APPLY OPENJSON(payment_type_desc)
    WITH(
        sub_type SMALLINT,
        payment_type_desc_value VARCHAR(20) '$.value'
    );
