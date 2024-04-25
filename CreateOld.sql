CREATE DATABASE schoolDW collate Latin1_General_CI_AS;
GO

USE schoolDW
GO

CREATE TABLE Classroom
(
	RoomID INTEGER IDENTITY(1,1) PRIMARY KEY,
	RoomNumber INTEGER UNIQUE NOT NULL,
	Floor Varchar(10) NOT NULL,
    CONSTRAINT chk_Floor CHECK (Floor IN ('first','second','third','fourth', 'fifth', 'sixth', 'seventh','eighth','ninth','tenth'))
)
GO

CREATE TABLE Course
(
    CourseID INTEGER IDENTITY(1,1) PRIMARY KEY,
    Name Varchar(20) NOT NUll,
    Year INTEGER NOT NULL,
)
GO


CREATE TABLE Teacher
(
	TeacherID INTEGER IDENTITY(1,1) PRIMARY KEY,
    Pesel Varchar(11) NOT NULL,
	Teacher_Name Varchar(20) NOT NULL,
    Teacher_Surname Varchar(20) NOT NULL,
    CityDistrict Varchar(20) NOT NULL,
    Gender Varchar(6) NOT NUll,
    IsCurrent BIT,
    CONSTRAINT chk_Teacher_Gender CHECK (Gender IN ('Man','Woman','Other'))
)
GO

CREATE TABLE Students
(
	StudentID INTEGER IDENTITY(1,1) PRIMARY KEY,
    Pesel Varchar(11) NOT NULL,
	Student_Name Varchar(20) NOT NULL,
    Teacher_Surname Varchar(20) NOT NULL,
    CityDistrict Varchar(20) NOT NULL,
    Gender Varchar(6) NOT NUll,
    IsCurrent BIT,
    CONSTRAINT chk_Student_Gender CHECK (Gender IN ('Man','Woman','Other'))
)

GO

CREATE TABLE [Time]
(
	TimeID INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Hour] INTEGER NOT NULL,
	TimeOfDay Varchar(25) NOT NULL,
	CONSTRAINT chk_TimeOfDay CHECK (TimeOfDay IN ('Early Morning', 'Morning', 'Noon', 'Evening', 'Night'))
)

GO
CREATE TABLE [Date]
(
    DateID INTEGER IDENTITY(1,1) PRIMARY KEY,
    [Date] date unique,
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
CREATE TABLE Class
(
	ClassID INTEGER IDENTITY(1,1) PRIMARY KEY,
	ClassName Varchar(3) UNIQUE NOT NULL,
	Specialization Varchar(20) NOT NULL,
	IsCurrent BIT,
	CONSTRAINT chk_Specialization CHECK (Specialization IN ('Mathematical', 'Humanistic', 'Scientific', 'Linguistic', 'Artistic','Sport'))
)
GO

CREATE TABLE Circumstances
(
	CircumstancesID INTEGER IDENTITY(1,1) PRIMARY KEY,
	CatchUP Varchar(30) NOT NULL,
	Excused Varchar(3) NOT NULL,
	Late Varchar(3) NOT NULL,
	CONSTRAINT chk_Excused CHECK (Excused IN ('Yes', 'No')),
	CONSTRAINT chk_Late CHECK (Late IN ('Yes', 'No'))
)
GO


CREATE TABLE Exams
(
	Score Float NOT NULL,
	RoomID INTEGER FOREIGN KEY REFERENCES Classroom,
    CourseID INTEGER FOREIGN KEY REFERENCES Course,
	DateID INTEGER FOREIGN KEY REFERENCES [Date],
	StudentID INTEGER FOREIGN KEY REFERENCES Students,
	ClassID INTEGER FOREIGN KEY REFERENCES Class,

	Constraint composite_ek Primary key(
	RoomID,
	CourseID,
	DateID,
	StudentID,
	ClassID
	)
)

GO


CREATE TABLE Meeting
(
	AttendanceMax INT NOT NULL,
	AttendanceReal INT NOT NULL,
	AttendanceRate Float NOT NULL,
	DurationMinutes INT NOT NULL,
	TimeID INTEGER FOREIGN KEY REFERENCES [Time],
	DateID INTEGER FOREIGN KEY REFERENCES [Date],
	RoomID INTEGER FOREIGN KEY REFERENCES Classroom,
	ClassID INTEGER FOREIGN KEY REFERENCES Class,
    CourseID INTEGER FOREIGN KEY REFERENCES Course,
	TeacherID INTEGER FOREIGN KEY REFERENCES Teacher,

	
	Constraint composite_mk Primary key(
	TimeID,
	DateID,
	RoomID,
	ClassID,
	CourseID,
	TeacherID
	)
)


GO

CREATE TABLE Surveys
(
	Score Float NOT NULL,
	StudentID INTEGER FOREIGN KEY REFERENCES Students,
    DateID INTEGER FOREIGN KEY REFERENCES [Date],
	ClassID INTEGER FOREIGN KEY REFERENCES Class,

	Constraint composite_sk Primary key(
	StudentID,
	DateID,
	ClassID
	)
)

GO
CREATE TABLE Attendance
(
	StudentID INTEGER FOREIGN KEY REFERENCES Students,
	TeacherID INTEGER FOREIGN KEY REFERENCES Teacher,
	CircumstancesID INTEGER FOREIGN KEY REFERENCES Circumstances,
	TimeID INTEGER FOREIGN KEY REFERENCES [Time],
    DateID INTEGER FOREIGN KEY REFERENCES [Date],


	Constraint composite_ek Primary key(
	StudentID,
	TeacherID,
	CircumstancesID,
	TimeID,
	DateID
	)
)


