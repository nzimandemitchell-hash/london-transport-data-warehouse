
IF DB_ID('LondonTransportDW') IS NULL
BEGIN
    CREATE DATABASE LondonTransportDW;
END;
GO

USE LondonTransportDW;
GO

-- Dimension table: reporting periods
IF OBJECT_ID('dbo.DimPeriod', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.DimPeriod (
        PeriodKey INT IDENTITY(1,1) PRIMARY KEY,
        PeriodLabel VARCHAR(50),
        ReportingPeriod INT,
        DaysInPeriod INT,
        PeriodBeginning DATE NOT NULL,
        PeriodEnding DATE NOT NULL
    );
END;
GO

-- Dimension table: transport modes
IF OBJECT_ID('dbo.DimTransportMode', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.DimTransportMode (
        TransportModeKey INT IDENTITY(1,1) PRIMARY KEY,
        TransportModeName VARCHAR(100) NOT NULL UNIQUE
    );
END;
GO

-- Fact table: transport journeys
IF OBJECT_ID('dbo.FactTransportJourneys', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.FactTransportJourneys (
        JourneyKey INT IDENTITY(1,1) PRIMARY KEY,
        PeriodKey INT NOT NULL,
        TransportModeKey INT NOT NULL,
        JourneysMillions DECIMAL(10,2) NULL,
        CONSTRAINT FK_Fact_Period
            FOREIGN KEY (PeriodKey)
            REFERENCES dbo.DimPeriod(PeriodKey),
        CONSTRAINT FK_Fact_TransportMode
            FOREIGN KEY (TransportModeKey)
            REFERENCES dbo.DimTransportMode(TransportModeKey)
    );
END;
GO
