
USE LondonTransportDW;
GO

-- 1. Check total staging records and missing journey values
SELECT
    COUNT(*) AS TotalRecords,
    COUNT(JourneysMillions) AS NonNullJourneyValues,
    COUNT(*) - COUNT(JourneysMillions) AS MissingJourneyValues
FROM dbo.StgTransportJourneys;
GO

-- 2. Check distinct reporting periods and transport modes
SELECT
    COUNT(DISTINCT PeriodLabel) AS DistinctPeriodLabels,
    COUNT(DISTINCT TransportModeName) AS DistinctTransportModes
FROM dbo.StgTransportJourneys;
GO

-- 3. Check for duplicate staging records
SELECT
    PeriodLabel,
    PeriodBeginning,
    PeriodEnding,
    TransportModeName,
    COUNT(*) AS DuplicateCount
FROM dbo.StgTransportJourneys
GROUP BY
    PeriodLabel,
    PeriodBeginning,
    PeriodEnding,
    TransportModeName
HAVING COUNT(*) > 1;
GO

-- 4. Preview the staged records
SELECT TOP 10
    PeriodLabel,
    PeriodBeginning,
    PeriodEnding,
    TransportModeName,
    JourneysMillions
FROM dbo.StgTransportJourneys
ORDER BY PeriodBeginning, TransportModeName;
GO
