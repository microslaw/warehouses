USE schoolDW
GO

If (object_id('vETLDimTeachers') is not null) Drop View vETLDimTeachers;
go
CREATE VIEW vETLDimTeachers
AS
SELECT DISTINCT
	[Pesel],
	[Teacher_Name],
	[Teacher_Surname],
	[CityDistrict],
	[Gender]
FROM schoolDB.dbo.Teachers;
go

MERGE INTO DimTeacher as TT
	USING vETLDimTeachers as ST
		ON TT.Pesel = ST.Pesel
			WHEN Not Matched
				THEN
					INSERT 
					VALUES (ST.Pesel, ST.Teacher_Name, ST.Teacher_Surname, ST.CityDistrict, ST.Gender,1)
			WHEN Matched 
				AND TT.CityDistrict <> ST.CityDistrict
					THEN
						UPDATE 
							SET TT.IsCurrent = 0
			WHEN Not Matched By Source
				Then
					DELETE
			;

INSERT INTO DimTeacher(
	Pesel,
	Teacher_Name,
	Teacher_Surname,
	CityDistrict,
	Gender,
	IsCurrent)
	SELECT 
		Pesel,
		Teacher_Name,
		Teacher_Surname,
		CityDistrict,
		Gender,
		1
	FROM vETLDimTeachers
	EXCEPT
	SELECT 
		Pesel,
		Teacher_Name,
		Teacher_Surname,
		CityDistrict,
		Gender,
		1
	FROM DimTeacher;
Drop View vETLDimTeachers;