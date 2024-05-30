USE schoolDW
GO

DROP TABLE IF EXISTS Attendance

CREATE Table Attendance
(
	Student_Name Varchar(20) NOT NULL,
    Student_Surname Varchar(20) NOT NULL,
	sID INT NOT NULL,
	ClassName VARCHAR(5),
	StartHour time,
	EndHour time,
	CourseNameName Varchar(20) NOT NUll,
	mID INT,
	Teacher_Name Varchar(20) NOT NULL,
    Teacher_Surname Varchar(20) NOT NULL,
	tID INT NOT NULL,
	Excused Varchar(5),
	CATCHUP Varchar(100),
	Late Varchar(5)
)

BULK INSERT Attendance FROM 'C:\projects\warehouses\dbData\attendance.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
