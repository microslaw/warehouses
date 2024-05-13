USE schoolDW
GO

If (object_id('vETLDimStudents') is not null) Drop View vETLDimStudents;
go
CREATE VIEW vETLDimStudents
AS
SELECT DISTINCT
	[Pesel],
	[Student_Name],
	[Student_Surname],
	[CityDistrict],
	[Gender]
FROM schoolDB.dbo.Students;
go


MERGE INTO DimStudents as TT
	USING vETLDimStudents as ST
		ON TT.Pesel = ST.Pesel
			WHEN Not Matched
				THEN
					INSERT 
					VALUES (ST.Pesel, ST.Student_Name, ST.Student_Surname, ST.CityDistrict, ST.Gender,1)
			WHEN Matched 
				AND TT.CityDistrict <> ST.CityDistrict
					THEN
						UPDATE 
							SET TT.IsCurrent = 0
			WHEN Not Matched By Source
				Then
					DELETE
			;

INSERT INTO DimStudents(
	Pesel,
	Student_Name,
	Student_Surname,
	CityDistrict,
	Gender,
	IsCurrent)
	SELECT 
		Pesel,
		Student_Name,
		Student_Surname,
		CityDistrict,
		Gender,
		1
	FROM vETLDimStudents
	EXCEPT
	SELECT 
		Pesel,
		Student_Name,
		Student_Surname,
		CityDistrict,
		Gender,
		1
	FROM DimStudents;
Drop View vETLDimStudents;