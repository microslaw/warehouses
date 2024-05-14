USE schoolDW;
GO

IF OBJECT_ID('vETLFExams') IS NOT NULL
    DROP VIEW vETLFExams;
GO

CREATE VIEW vETLFExams
AS
SELECT 
    Score,
    DimClassroom.RoomID,
    DimCourse.CourseID,
    DimDate.DateID,
    DimStudents.StudentID,
    DimClass.ClassID
FROM schoolDB.dbo.Exams
JOIN schoolDB.dbo.Students ON Students.sID = Exams.sID
JOIN schoolDB.dbo.Meeting ON Meeting.mID = Exams.mID
JOIN schoolDB.dbo.Class ON  Class.ClassName = Students.ClassName 
JOIN schoolDB.dbo.Classroom ON Classroom.RoomNumber = Meeting.RoomNumber 
JOIN schoolDB.dbo.Course ON Course.cID = Meeting.cID
JOIN DimDate ON CONVERT(VARCHAR(10), Meeting.[Date], 111) = CONVERT(VARCHAR(10), DimDate.[Date], 111)
JOIN DimClassroom ON DimClassroom.RoomNumber = Classroom.RoomNumber
JOIN DimCourse ON DimCourse.cID = Course.cID
JOIN DimStudents ON DimStudents.Pesel = Students.Pesel
JOIN DimClass ON DimClass.ClassName = Class.ClassName
WHERE DimStudents.IsCurrent = 1

GO
DELETE FROM FExams

GO
MERGE INTO FExams AS TT
USING vETLFExams AS ST
ON     
    TT.RoomID = ST.RoomID
    AND TT.CourseID = ST.CourseID
    AND TT.DateID = ST.DateID
    AND TT.StudentID = ST.StudentID
    AND TT.ClassID = ST.ClassID
WHEN NOT MATCHED THEN
    INSERT
    VALUES (ST.Score, ST.RoomID, ST.CourseID, ST.DateID, ST.StudentID, ST.ClassID); 

Drop view vETLFExams;

