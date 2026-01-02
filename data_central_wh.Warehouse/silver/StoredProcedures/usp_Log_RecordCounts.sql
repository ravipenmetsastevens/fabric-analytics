CREATE   PROCEDURE silver.usp_Log_RecordCounts
    @OnlyEnabled BIT = 1
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @run_id UNIQUEIDENTIFIER = NEWID();

    IF OBJECT_ID('tempdb..#targets') IS NOT NULL DROP TABLE #targets;

    SELECT
        ROW_NUMBER() OVER (ORDER BY object_schema, object_name) AS rn,
        object_schema,
        object_name
    INTO #targets
    FROM silver.RecordCount_config
    WHERE (@OnlyEnabled = 0 OR is_enabled = 1);

    DECLARE
        @i             INT = 1,
        @n             INT,
        @object_schema VARCHAR(128),
        @object_name   VARCHAR(128),
        @stmt          NVARCHAR(MAX),
        @params        NVARCHAR(100),
        @record_count  BIGINT,
        @started_utc   DATETIME2(3),
        @finished_utc  DATETIME2(3),
        @duration_ms   INT,
        @is_zero       BIT,
        @err_msg       VARCHAR(4000);

    SELECT @n = MAX(rn) FROM #targets;
    IF @n IS NULL RETURN;

    WHILE @i <= @n
    BEGIN
        SELECT
            @object_schema = object_schema,
            @object_name   = object_name
        FROM #targets
        WHERE rn = @i;

        SET @started_utc = SYSUTCDATETIME();
        SET @record_count = NULL;
        SET @err_msg = NULL;

        BEGIN TRY
            -- sanitize brackets
            SET @object_schema = REPLACE(@object_schema, ']', '');
            SET @object_name   = REPLACE(@object_name,   ']', '');

            -- dynamic count statement must be NVARCHAR
            SET @stmt =
                N'SELECT @rc = COUNT_BIG(1) 
                  FROM [' + CAST(@object_schema AS NVARCHAR(128)) + N'].[' 
                          + CAST(@object_name   AS NVARCHAR(128)) + N'];';

            SET @params = N'@rc BIGINT OUTPUT';

            EXEC sp_executesql 
                @stmt = @stmt,
                @params = @params,
                @rc = @record_count OUTPUT;

            SET @finished_utc = SYSUTCDATETIME();
            SET @duration_ms  = DATEDIFF(MILLISECOND, @started_utc, @finished_utc);
            SET @is_zero      = CASE WHEN @record_count = 0 THEN 1 ELSE 0 END;

            INSERT INTO silver.RecordCount_log
            (run_id, object_schema, object_name, run_datetime_utc,
             record_count, is_zero_count, duration_ms, status, error_message)
            VALUES
            (@run_id, @object_schema, @object_name, @finished_utc,
             @record_count, @is_zero, @duration_ms, 'OK', NULL);
        END TRY
        BEGIN CATCH
            SET @finished_utc = SYSUTCDATETIME();
            SET @duration_ms  = DATEDIFF(MILLISECOND, @started_utc, @finished_utc);
            SET @err_msg      = LEFT(ERROR_MESSAGE(), 4000);

            INSERT INTO silver.RecordCount_log
            (run_id, object_schema, object_name, run_datetime_utc,
             record_count, is_zero_count, duration_ms, status, error_message)
            VALUES
            (@run_id, @object_schema, @object_name, @finished_utc,
             NULL, 0, @duration_ms, 'ERROR', @err_msg);
        END CATCH;

        SET @i += 1;
    END
END;