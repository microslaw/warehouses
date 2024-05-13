
BEGIN TRY
use master
alter database schoolDB set single_user with rollback immediate
drop database schoolDB
END TRY
BEGIN CATCH
END CATCH

CREATE DATABASE schoolDB collate Latin1_General_CI_AS;
GO

USE schoolDB
GO

CREATE TABLE Classroom (
    RoomNumber INT PRIMARY KEY,
    Floor INT not null,
    MaxCapacity INT not null,
	CONSTRAINT CHK_Floor2 CHECK (Floor>=0 AND Floor<=10)
);


CREATE TABLE Teachers (
    tID INT PRIMARY KEY,
    Teacher_Name VARCHAR(20) not null,
    Teacher_Surname VARCHAR(20) not null,
    CityDistrict VARCHAR(20) not null,
    Birthdate DATE not null,
    Gender VARCHAR(10) not null,
	CONSTRAINT chk_Teacher_Gender2 CHECK (Gender IN ('Man','Woman','Other')),
	Pesel VARCHAR(11) not null
);
CREATE TABLE Course (
    cID INT PRIMARY KEY,
    Course_Name VARCHAR(20) not null,
    Year INT not null,
    tID INT not null,
    FOREIGN KEY (tID) REFERENCES Teachers(tID)
);
CREATE TABLE Class (
    ClassName VARCHAR(5) PRIMARY KEY,
    Specialization VARCHAR(20) not null,
    tID INT not null,
    FOREIGN KEY (tID) REFERENCES Teachers(tID),
	CONSTRAINT chk_Specialization2 CHECK (Specialization IN ('Mathematical','Humanistic','Scientific','Linguistic','Artistic','Sport'))
);


CREATE TABLE Students (
    sID INT PRIMARY KEY,
    Student_Name VARCHAR(20) not null,
    Student_Surname VARCHAR(20) not null,
    CityDistrict VARCHAR(20) not null,
    Birthdate DATE not null,
    Gender VARCHAR(6) not null,
    ClassName VARCHAR(5) not null,
    FOREIGN KEY (ClassName) REFERENCES Class(ClassName),
	CONSTRAINT chk_Student_Gender2 CHECK (Gender IN ('Man','Woman','Other')),
	Pesel VARCHAR(11) not null
);

CREATE TABLE Meeting (
    mID INT PRIMARY KEY,
    Date DATETIME not null,
    RoomNumber INT not null,
    cID INT not null,
    ClassName VARCHAR(5) not null,
	DurationMinutes INT not null,
    FOREIGN KEY (RoomNumber) REFERENCES Classroom(RoomNumber),
    FOREIGN KEY (cID) REFERENCES Course(cID),
    FOREIGN KEY (ClassName) REFERENCES Class(ClassName),
	CONSTRAINT chk_DurationMinutes2 CHECK (DurationMinutes >= 1 AND DurationMinutes <= 60)
);

CREATE TABLE Exams (
    sID INT,
    mID INT,
    Score FLOAT not null,
    PRIMARY KEY (sID, mID),
    FOREIGN KEY (sID) REFERENCES Students(sID),
    FOREIGN KEY (mID) REFERENCES Meeting(mID),
	CONSTRAINT chk_Exam_Score2 CHECK (Score >= 0 AND Score <= 50)
);


CREATE TABLE Surveys (
    mID INT,
    sID INT,
    Score FLOAT not null,
    PRIMARY KEY (mID, sID),
    FOREIGN KEY (mID) REFERENCES Meeting(mID),
    FOREIGN KEY (sID) REFERENCES Students(sID),
	CONSTRAINT chk_Survey_Score2 CHECK (Score >= 0 AND Score <= 20)
);




