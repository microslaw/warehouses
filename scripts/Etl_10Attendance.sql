USE schoolDW
GO

CREATE VIEW vEtlAttendance AS
(
SELECT DimStudents.StudentID, DimTeacher.TeacherID, DimCircumstances.CircumstancesID, DimTime.TimeID, DimDate.DateID  
-- SELECT *
FROM Attendance
JOIN schoolDB.dbo.Students ON Attendance.sID = Students.sID
JOIN DimStudents ON schoolDB.dbo.Students.Pesel = DimStudents.Pesel
JOIN schoolDB.dbo.Teachers ON Attendance.tID = Teachers.tID
JOIN DimTeacher ON Teachers.Pesel = DimTeacher.Pesel
JOIN schoolDB.dbo.Meeting ON Meeting.mID = Attendance.mID
JOIN dbo.DimTime ON dbo.DimTime.Hour = DATEPART(HOUR, Meeting.[Date])
JOIN DimDate ON CONVERT(VARCHAR(10), Meeting.[Date], 111) = CONVERT(VARCHAR(10), DimDate.[Date], 111)
JOIN DimCircumstances ON Attendance.CATCHUP = DimCircumstances.CatchUP
WHERE ((Attendance.Excused = 'True' AND DimCircumstances.Excused = 'Yes') OR
	(Attendance.Excused = 'False' AND DimCircumstances.Excused = 'No'))
	AND
	((Attendance.Late = 'True' AND DimCircumstances.Late = 'Yes') OR
	(Attendance.Late = 'False' AND DimCircumstances.Late = 'No'))
	)
	
GO

SELECT * FROM vEtlAttendance

MERGE INTO FAttendance as FactTable
	USING vEtlAttendance as NewData
		ON FactTable.StudentID = NewData.StudentID
		AND FactTable.TimeID = NewData.TimeID
		AND FactTable.DateID = NewData.DateID
			WHEN Not Matched
				THEN
					INSERT
					Values (
					 NewData.StudentID,
					 NewData.TeacherID,
					 NewData.CircumstancesID,
					 NewData.TimeID,
					 NewData.DateID
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;

DROP VIEW vEtlAttendance;

SELECT * FROM FAttendance
