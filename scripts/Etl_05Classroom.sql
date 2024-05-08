USE schoolDW
GO

If (object_id('vETLDimClassroom') is not null) Drop View vETLDimClassroom;
go
CREATE VIEW vETLDimClassroom
AS
SELECT DISTINCT
	[RoomNumber],
	CASE
		WHEN [Floor] = 1 THEN 'first'
		WHEN [Floor] = 2 THEN 'second'
		WHEN [Floor] = 3 THEN 'third'
		WHEN [Floor] = 4 THEN 'fourth'
		WHEN [Floor] = 5 THEN 'fifth'
		WHEN [Floor] = 6 THEN 'sixth'
		WHEN [Floor] = 7 THEN 'seventh'
		WHEN [Floor] = 8 THEN 'eighth'
		WHEN [Floor] = 9 THEN 'ninth'
		WHEN [Floor] = 10 THEN 'tenth'
		ELSE 'first'
	END AS [Floor_String]
FROM schoolDB.dbo.Classroom;
go


MERGE INTO DimClassroom as TT
	USING vETLDimClassroom as ST
		ON TT.RoomNumber = ST.RoomNumber
			WHEN Not Matched
				THEN
					INSERT 
					VALUES (ST.RoomNumber, ST.Floor_String
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;

Drop View vETLDimClassroom;



