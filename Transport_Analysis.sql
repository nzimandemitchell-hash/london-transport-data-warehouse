
USE LondonTransportDW;
GO

-- Compare journeys across transport modes
SELECT
    m.TransportModeName,
    COUNT(*) AS ReportingRecords,
    COUNT(f.JourneysMillions) AS RecordsWithValues,
    SUM(f.JourneysMillions) AS TotalJourneysMillions,
    AVG(f.JourneysMillions) AS AverageJourneysMillions
FROM dbo.FactTransportJourneys f
INNER JOIN dbo.DimTransportMode m
    ON f.TransportModeKey = m.TransportModeKey
GROUP BY
    m.TransportModeName
ORDER BY
    TotalJourneysMillions DESC;
GO
