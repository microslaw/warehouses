
SELECT COUNT(*), DATEADD(dd, DATEDIFF(dd, 0, Meeting.[Date]), 0)
 FROM schoolDB.dbo.Exams
JOIN schoolDB.dbo.Meeting ON Exams.mID = Meeting.mID
GROUP BY DATEADD(dd, DATEDIFF(dd, 0, Meeting.[Date]), 0)
ORDER BY DATEADD(dd, DATEDIFF(dd, 0, Meeting.[Date]), 0)


SELECT COUNT(*), DimDate.[Date] FROM schoolDW.dbo.FExams
JOIN schoolDW.dbo.DimDate ON DimDate.DateID = FExams.DateID
GROUP BY DimDate.[Date]
ORDER BY DimDate.[Date]



-- ABC

SELECT * --DATEADD(dd, DATEDIFF(dd, 0, Meeting.[Date]), 0)
 FROM schoolDB.dbo.Exams
JOIN schoolDB.dbo.Meeting ON Exams.mID = Meeting.mID
WHERE DATEADD(dd, DATEDIFF(dd, 0, Meeting.[Date]), 0) = '2020-06-30 00:00:00.000'
ORDER BY Score


SELECT * FROM schoolDW.dbo.FExams
JOIN schoolDW.dbo.DimDate ON DimDate.DateID = FExams.DateID
WHERE DimDate.[Date] = '2020-06-30 00:00:00.000'
ORDER BY Score


SELECT * FROM schoolDW.dbo.DimStudents
SELECT * FROM schoolDB.dbo.Students
SELECT * FROM schoolDW.dbo.DimClass




SELECT COUNT(*) FROM schoolDB.dbo.Exams
SELECT COUNT(*) FROM schoolDW.dbo.FExams
--To check:
--Exams
--Meeting
--Surveys
--Attendance


--SELECT * FROM schoolDB.dbo.Meeting
--JOIN schoolDB.dbo.Exams on Exams.mID = Meeting.mID
--WHERE Exams.mID NOT in
--(
--SELECT Distinct mID FROM vETLFExams
--)


SELECT * FROM schoolDB.dbo.Exams
WHERE mID NOT IN (SELECT mID from schoolDB.dbo.Meeting)


SELECT DISTINCT Date FROM schoolDW.dbo.FExams
JOIN schoolDW.dbo.DimDate ON DimDate.DateID = FExams.DateID


SELECT COUNT(*) FROM schoolDB.dbo.Class
SELECT COUNT(*) FROM schoolDW.dbo.DimClass


SELECT COUNT(*) FROM schoolDB.dbo.Classroom
SELECT COUNT(*) FROM schoolDW.dbo.DimClassroom

SELECT COUNT(*) FROM schoolDB.dbo.Course
SELECT COUNT(*) FROM schoolDW.dbo.DimCourse

SELECT COUNT(*) FROM schoolDB.dbo.Exams
SELECT COUNT(*) FROM schoolDW.dbo.FExams

SELECT COUNT(*) FROM schoolDB.dbo.Attendance
SELECT * FROM schoolDW.dbo.FAttendance



SELECT * FROM Exams JOIN Meeting ON Exams.mID = Meeting.mID






