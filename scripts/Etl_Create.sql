
BEGIN TRY
use master
alter database schoolDW set single_user with rollback immediate
drop database schoolDW
END TRY
BEGIN CATCH
END CATCH


CREATE DATABASE schoolDW collate Latin1_General_CI_AS;
GO

USE schoolDW
GO

CREATE TABLE DimClassroom
(
	RoomID INTEGER IDENTITY(1,1) PRIMARY KEY,
	RoomNumber INTEGER UNIQUE NOT NULL,
	Floor Varchar(10) NOT NULL,
    CONSTRAINT chk_Floor CHECK (Floor IN ('first','second','third','fourth', 'fifth', 'sixth', 'seventh','eighth','ninth','tenth'))
)
GO

CREATE TABLE DimCourse
(
    CourseID INTEGER IDENTITY(1,1) PRIMARY KEY,
	cID INTEGER NOT NULL,
    Name Varchar(20) NOT NUll,
    Year INTEGER NOT NULL,
)
GO


CREATE TABLE DimTeacher
(
	TeacherID INTEGER IDENTITY(1,1) PRIMARY KEY,
    Pesel Varchar(11) NOT NULL,
	Teacher_Name Varchar(20) NOT NULL,
    Teacher_Surname Varchar(20) NOT NULL,
    CityDistrict Varchar(20) NOT NULL,
    Gender Varchar(6) NOT NUll,
    IsCurrent BIT,
    CONSTRAINT chk_Teacher_Gender CHECK (Gender IN ('Male','Female','Other'))
)
GO

CREATE TABLE DimStudents
(
	StudentID INTEGER IDENTITY(1,1) PRIMARY KEY,
    Pesel Varchar(11) NOT NULL,
	Student_Name Varchar(20) NOT NULL,
    Student_Surname Varchar(20) NOT NULL,
    CityDistrict Varchar(20) NOT NULL,
    Gender Varchar(6) NOT NUll,
    IsCurrent BIT,
    CONSTRAINT chk_Student_Gender CHECK (Gender IN ('Male','Female','Other'))
)

GO

CREATE TABLE DimTime
(
	TimeID INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Hour] INTEGER NOT NULL,
	TimeOfDay Varchar(25) NOT NULL,
	CONSTRAINT chk_TimeOfDay CHECK (TimeOfDay IN ('Early Morning', 'Morning', 'Noon', 'Evening', 'Night'))
)

GO
CREATE TABLE DimDate
(
    DateID INTEGER IDENTITY(1,1) PRIMARY KEY,
    [Date] datetime unique,
	[Year] varchar(4),
	[Month] varchar(10),
	MonthNumber	tinyint,
	DayNumber int,
	[DayOfWeek] varchar(10),
	DayOfWeekNumber tinyint,
	WorkingDay varchar(15),
	ExamDay varchar(3),
	CONSTRAINT chk_Month CHECK ([Month] IN ('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')),
	CONSTRAINT chk_DayOfWeek CHECK ([DayOfWeek] IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')),
	CONSTRAINT chk_WorkingDay CHECK (WorkingDay IN ('day off', 'working day')),
	CONSTRAINT chk_ExamDay CHECK (ExamDay IN ('yes','no'))
)

GO
CREATE TABLE DimClass
(
	ClassID INTEGER IDENTITY(1,1) PRIMARY KEY,
	ClassName Varchar(3) UNIQUE NOT NULL,
	Specialization Varchar(20) NOT NULL,
	IsCurrent BIT,
	CONSTRAINT chk_Specialization CHECK (Specialization IN ('Mathematical', 'Humanistic', 'Scientific', 'Linguistic', 'Artistic','Sport'))
)
GO

CREATE TABLE DimCircumstances
(
	CircumstancesID INTEGER IDENTITY(1,1) PRIMARY KEY,
	CatchUP Varchar(30),
	Excused Varchar(3) NOT NULL,
	Late Varchar(3) NOT NULL,
	CONSTRAINT chk_Excused CHECK (Excused IN ('Yes', 'No')),
	CONSTRAINT chk_Late CHECK (Late IN ('Yes', 'No'))
)
GO


CREATE TABLE FExams
(
	Score Float NOT NULL,
	RoomID INTEGER FOREIGN KEY REFERENCES DimClassroom,
    CourseID INTEGER FOREIGN KEY REFERENCES DimCourse,
	DateID INTEGER FOREIGN KEY REFERENCES DimDate,
	StudentID INTEGER FOREIGN KEY REFERENCES DimStudents,
	ClassID INTEGER FOREIGN KEY REFERENCES DimClass,
	CONSTRAINT composite_pke PRIMARY KEY (
		RoomID,
		CourseID,
		DateID,
		StudentID,
		ClassID
		)
)

GO


CREATE TABLE FMeeting
(
	AttendanceMax INT NOT NULL,
	AttendanceReal INT NOT NULL,
	AttendanceRate Float NOT NULL,
	DurationMinutes INT NOT NULL,
	TimeID INTEGER FOREIGN KEY REFERENCES DimTime,
	DateID INTEGER FOREIGN KEY REFERENCES DimDate,
	RoomID INTEGER FOREIGN KEY REFERENCES DimClassroom,
	ClassID INTEGER FOREIGN KEY REFERENCES DimClass,
    CourseID INTEGER FOREIGN KEY REFERENCES DimCourse,
	TeacherID INTEGER FOREIGN KEY REFERENCES DimTeacher,
	CONSTRAINT composite_pkm PRIMARY KEY (
		TimeID,
		DateID,
		RoomID,
		ClassID,
		CourseID,
		TeacherID
		)
)

GO

CREATE TABLE FSurveys
(
	Score Float NOT NULL,
	StudentID INTEGER FOREIGN KEY REFERENCES DimStudents,
    DateID INTEGER FOREIGN KEY REFERENCES DimDate,
	ClassID INTEGER FOREIGN KEY REFERENCES DimClass,
	CONSTRAINT composite_pks PRIMARY KEY (
		StudentID,
		DateID,
		ClassID
		)
)

GO
CREATE TABLE FAttendance
(
	StudentID INTEGER FOREIGN KEY REFERENCES DimStudents,
	TeacherID INTEGER FOREIGN KEY REFERENCES DimTeacher,
	CircumstancesID INTEGER FOREIGN KEY REFERENCES DimCircumstances,
	TimeID INTEGER FOREIGN KEY REFERENCES DimTime,
    DateID INTEGER FOREIGN KEY REFERENCES DimDate,
	CONSTRAINT composite_pka PRIMARY KEY (
		StudentID,
		TeacherID,
		CircumstancesID,
		TimeID,
		DateID
		)
)


