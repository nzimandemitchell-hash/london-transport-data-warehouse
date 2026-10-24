
USE LondonTransportDW;
GO

-- Load unique reporting periods into DimPeriod
INSERT INTO dbo.DimPeriod (
    PeriodLabel,
    ReportingPeriod,
    DaysInPeriod,
    PeriodBeginning,
    PeriodEnding
)
SELECT DISTINCT
    s.PeriodLabel,
    s.ReportingPeriod,
    s.DaysInPeriod,
    s.PeriodBeginning,
    s.PeriodEnding
FROM dbo.StgTransportJourneys s
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.DimPeriod d
    WHERE d.PeriodLabel = s.PeriodLabel
      AND d.PeriodBeginning = s.PeriodBeginning
      AND d.PeriodEnding = s.PeriodEnding
);

-- Load unique transport modes into DimTransportMode
INSERT INTO dbo.DimTransportMode (TransportModeName)
SELECT DISTINCT
    s.TransportModeName
FROM dbo.StgTransportJourneys s
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.DimTransportMode m
    WHERE m.TransportModeName = s.TransportModeName
);
GO
