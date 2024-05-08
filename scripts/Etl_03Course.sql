USE schoolDW
GO

If (object_id('vETLDimCourse') is not null) Drop View vETLDimCourse;
go
CREATE VIEW vETLDimCourse
AS
SELECT DISTINCT
	[cID],
    [Course_Name],
	[Year]
FROM schoolDB.dbo.Course;
go

MERGE INTO DimCourse as TT
	USING vETLDimCourse as ST
		ON TT.cID = ST.cID
			WHEN Not Matched
				THEN
					INSERT 
					VALUES (ST.cID, ST.Course_Name, ST.YEAR
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;

Drop View vETLDimCourse;