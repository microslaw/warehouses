USE schoolDW
GO

DROP VIEW IF EXISTS ClassCounts
DROP VIEW IF EXISTS MissingStudents
DROP VIEW IF EXISTS vEtlMeeting


GO
CREATE VIEW ClassCounts AS
SELECT COUNT(sID) as ClassSize,
    Class.ClassName
FROM schoolDB.dbo.Class
    JOIN schoolDB.dbo.Students ON Class.ClassName = Students.ClassName
GROUP BY Class.ClassName

GO
CREATE VIEW MissingStudents AS
SELECT Attendance.mID,
    COUNT(Attendance.sID) as MissingCount
FROM schoolDB.dbo.Meeting
    LEFT JOIN Attendance ON Attendance.mID = Meeting.mID
GROUP BY Attendance.mID

GO
CREATE VIEW vEtlMeeting AS
SELECT ClassCounts.ClassSize,
    ISNULL(MissingStudents.MissingCount, 0) AS Missing,
    Meeting.DurationMinutes,
    DimDate.DateID,
    DimTime.TimeID,
    DimClassroom.RoomID,
    DimClass.ClassID,
    DimCourse.CourseID,
    DimTeacher.TeacherID
FROM schoolDB.dbo.Meeting
    JOIN dbo.DimTime ON dbo.DimTime.Hour = DATEPART(HOUR, Meeting.[Date])
    JOIN DimDate ON CONVERT(VARCHAR(10), Meeting.[Date], 111) = CONVERT(VARCHAR(10), DimDate.[Date], 111)
    JOIN DimClassroom ON DimClassroom.RoomNumber = Meeting.RoomNumber
    JOIN DimClass ON DimClass.ClassName = Meeting.ClassName
    JOIN DimCourse ON DimCourse.cID = Meeting.cID
    JOIN schoolDB.dbo.Course ON Course.cID = Meeting.cID
    JOIN schoolDB.dbo.Teachers ON Teachers.tID = Course.tID
    JOIN DimTeacher ON DimTeacher.Pesel = Teachers.Pesel
    LEFT JOIN MissingStudents ON Meeting.mID = MissingStudents.mID
    JOIN ClassCounts ON DimClass.ClassName = ClassCounts.ClassName
GO



MERGE INTO FMeeting as FactTable
	USING vEtlMeeting as NewData
		ON 	FactTable.DateID = NewData.DateID
		AND FactTable.TimeID = NewData.TimeID
		AND FactTable.RoomID = NewData.RoomID
		AND FactTable.TeacherID = NewData.TeacherID
		AND FactTable.CourseID = NewData.CourseID
		AND FactTable.ClassID = NewData.ClassID

			WHEN Not Matched
				THEN
					INSERT
					Values (
						NewData.ClassSize,
						NewData.ClassSize - NewData.Missing,
						CAST(NewData.ClassSize - NewData.Missing AS float) / CAST(NewData.ClassSize AS float),
						NewData.DurationMinutes,
						NewData.TimeID,
						NewData.DateID,
						NewData.RoomID,
						NewData.ClassID,
						NewData.CourseID,
						NewData.TeacherID
					)
			;


DROP VIEW ClassCounts
DROP VIEW MissingStudents
DROP VIEW vEtlMeeting

