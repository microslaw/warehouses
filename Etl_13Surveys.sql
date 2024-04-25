USE schoolDW;
GO

IF OBJECT_ID('vETLFSurveys') IS NOT NULL
    DROP VIEW vETLFSurveys;
GO

CREATE VIEW vETLFSurveys
AS
SELECT 
    Score,
    DimDate.DateID,
    DimStudents.StudentID,
    DimClass.ClassID
FROM Surveys
    JOIN Students ON Students.sID = Surveys.sID
    JOIN Meeting ON Meeting.mID = Surveys.mID
    JOIN Class ON  Class.ClassName = Students.ClassName 
    JOIN DimDate ON CONVERT(VARCHAR(10), Meeting.[Date], 111) = CONVERT(VARCHAR(10), DimDate.[Date], 111)
JOIN DimStudents ON DimStudents.Pesel = Students.Pesel
JOIN DimClass ON DimClass.ClassName = Class.ClassName

GO
MERGE INTO FSurveys AS TT
USING vETLFSurveys AS ST
ON     
    TT.DateID = ST.DateID
    AND TT.StudentID = ST.StudentID
    AND TT.ClassID = ST.ClassID
WHEN NOT MATCHED THEN
    INSERT
    VALUES (ST.Score, ST.DateID, ST.StudentID, ST.ClassID); 

Drop view vETLFSurveys;