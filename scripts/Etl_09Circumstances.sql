USE schoolDW
GO

DROP View IF EXISTS Circumstances
GO

CREATE VIEW Circumstances AS
(SELECT CASE WHEN Excused = 'False' THEN 'No' ELSE 'Yes' END AS Excused,
CASE WHEN Late = 'False' THEN 'No' ELSE 'Yes' END AS Late,
CATCHUP AS CatchUp
FROM
Attendance
GROUP BY
Excused, Late, CATCHUP);
GO

SELECT * FROM Circumstances

MERGE INTO DimCircumstances as DimensionTable
	USING Circumstances as NewData
		ON DimensionTable.CatchUp = NewData.CatchUp
		AND DimensionTable.Late = NewData.Late
		AND DimensionTable.Excused = NewData.Excused
			WHEN Not Matched
				THEN
					INSERT
					Values (
					NewData.CatchUp,
					NewData.Late,
					NewData.Excused
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;


GO
DROP VIEW Circumstances;