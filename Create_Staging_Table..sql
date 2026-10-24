
USE LondonTransportDW;
GO

-- Create the staging table if it does not already exist
IF OBJECT_ID('dbo.StgTransportJourneys', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.StgTransportJourneys (
        PeriodLabel VARCHAR(50) NULL,
        ReportingPeriod INT NULL,
        DaysInPeriod INT NULL,
        PeriodBeginning DATE NULL,
        PeriodEnding DATE NULL,
        TransportModeName VARCHAR(100) NULL,
        JourneysMillions DECIMAL(10,2) NULL
    );
END;
GO
