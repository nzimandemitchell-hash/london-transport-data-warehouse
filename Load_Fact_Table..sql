
USE LondonTransportDW;
GO

-- Load journey records into the fact table
INSERT INTO dbo.FactTransportJourneys (
    PeriodKey,
    TransportModeKey,
    JourneysMillions
)
SELECT
    p.PeriodKey,
    m.TransportModeKey,
    s.JourneysMillions
FROM dbo.StgTransportJourneys s
INNER JOIN dbo.DimPeriod p
    ON p.PeriodLabel = s.PeriodLabel
    AND p.PeriodBeginning = s.PeriodBeginning
    AND p.PeriodEnding = s.PeriodEnding
INNER JOIN dbo.DimTransportMode m
    ON m.TransportModeName = s.TransportModeName;
GO
