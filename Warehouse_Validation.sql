
USE LondonTransportDW;
GO

-- 1. Validate warehouse record counts and missing values
SELECT
    (SELECT COUNT(*) FROM dbo.DimPeriod)
        AS TotalPeriods,
    (SELECT COUNT(*) FROM dbo.DimTransportMode)
        AS TotalTransportModes,
    (SELECT COUNT(*) FROM dbo.FactTransportJourneys)
        AS TotalFactRecords,
    (
        SELECT COUNT(*)
        FROM dbo.FactTransportJourneys
        WHERE JourneysMillions IS NULL
    ) AS MissingJourneyValues;
GO

-- 2. Preview records joined across all warehouse tables
SELECT TOP 10
    p.PeriodLabel,
    p.PeriodBeginning,
    p.PeriodEnding,
    m.TransportModeName,
    f.JourneysMillions
FROM dbo.FactTransportJourneys f
INNER JOIN dbo.DimPeriod p
    ON f.PeriodKey = p.PeriodKey
INNER JOIN dbo.DimTransportMode m
    ON f.TransportModeKey = m.TransportModeKey
ORDER BY
    p.PeriodBeginning,
    m.TransportModeName;
GO
