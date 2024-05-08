USE schoolDW
GO

If (object_id('vETLDimClass') is not null) Drop View vETLDimClass;
go
CREATE VIEW vETLDimClass
AS
SELECT DISTINCT
	[ClassName],
	[Specialization]
FROM schoolDB.dbo.Class;
go

MERGE INTO DimClass as TT
	USING vETLDimClass as ST
		ON TT.ClassName = ST.ClassName
			WHEN Not Matched
				THEN
					INSERT 
					VALUES (ST.ClassName, ST.Specialization,1)
			WHEN Matched 
				AND ST.Specialization <> ST.Specialization
					THEN
						UPDATE 
							SET TT.IsCurrent = 0
			WHEN Not Matched By Source
				Then
					DELETE
			;

INSERT INTO DimClass(
	ClassName,
	Specialization,
	IsCurrent)
	SELECT 
		ClassName,
		Specialization,
		1
	FROM vETLDimClass
	EXCEPT
	SELECT 
		ClassName,
		Specialization,
		1
	FROM DimClass;
Drop View vETLDimClass;