USE schoolDW
GO

INSERT INTO Classroom (RoomNumber, Floor)
VALUES (101, 'first');

INSERT INTO Classroom (RoomNumber, Floor)
VALUES (201, 'second');

INSERT INTO Classroom (RoomNumber, Floor)
VALUES (301, 'third');

INSERT INTO Course (Name, Year)
VALUES ('Mathematic', 2024);

INSERT INTO Course (Name, Year)
VALUES ('English', 2024);

INSERT INTO Course (Name, Year)
VALUES ('History', 2024);


INSERT INTO Teacher (Pesel, Teacher_Name, Teacher_Surname, CityDistrict, Gender, IsCurrent)
VALUES ('12345678901', 'Maciek', 'Jaworek', 'Jasien', 'Man', 1);

INSERT INTO Teacher (Pesel, Teacher_Name, Teacher_Surname, CityDistrict, Gender, IsCurrent)
VALUES ('23456789012', 'Kludia', 'Pimpek', 'Wrzeszcz', 'Woman', 1);

INSERT INTO Teacher (Pesel, Teacher_Name, Teacher_Surname, CityDistrict, Gender, IsCurrent)
VALUES ('34567890123', 'Jan', 'Pastucha', 'Morena', 'Other', 1);


INSERT INTO Students (Pesel, Student_Name, Teacher_Surname, CityDistrict, Gender, IsCurrent)
VALUES ('11111111111', 'Mi³osz', 'Grunwald', 'Jasien', 'Woman', 1);

INSERT INTO Students (Pesel, Student_Name, Teacher_Surname, CityDistrict, Gender, IsCurrent)
VALUES ('22222222222', 'Micha³', 'Baron', 'Wrzeszcz', 'Man', 1);

INSERT INTO Students (Pesel, Student_Name, Teacher_Surname, CityDistrict, Gender, IsCurrent)
VALUES ('33333333333', 'Lionel', 'Messi', 'Morena', 'Other', 1);


INSERT INTO [Time] ([Hour], TimeOfDay)
VALUES (8, 'Morning');

INSERT INTO [Time] ([Hour], TimeOfDay)
VALUES (13, 'Noon');

INSERT INTO [Time] ([Hour], TimeOfDay)
VALUES (18, 'Evening');




INSERT INTO [Date] ([Date], [Year], [Month], MonthNumber, DayNumber, [DayOfWeek], DayOfWeekNumber, WorkingDay, ExamDay)
VALUES ('2024-04-16', '2024', 'April', 4, 16, 'Friday', 5, 'working day', 'no');

INSERT INTO [Date] ([Date], [Year], [Month], MonthNumber, DayNumber, [DayOfWeek], DayOfWeekNumber, WorkingDay, ExamDay)
VALUES ('2024-04-17', '2024', 'April', 4, 17, 'Saturday', 6, 'day off', 'no');

INSERT INTO [Date] ([Date], [Year], [Month], MonthNumber, DayNumber, [DayOfWeek], DayOfWeekNumber, WorkingDay, ExamDay)
VALUES ('2024-04-18', '2024', 'April', 4, 18, 'Sunday', 7, 'day off', 'no');



INSERT INTO Class (ClassName, Specialization, IsCurrent)
VALUES ('A01', 'Mathematical',1);

INSERT INTO Class (ClassName, Specialization, IsCurrent)
VALUES ('B02', 'Linguistic',1);

INSERT INTO Class (ClassName, Specialization, IsCurrent)
VALUES ('C03', 'Sport',1);


INSERT INTO Circumstances (CatchUP, Excused, Late)
VALUES ('No', 'Yes', 'No');

INSERT INTO Circumstances (CatchUP, Excused, Late)
VALUES ('Yes', 'No', 'Yes');

INSERT INTO Circumstances (CatchUP, Excused, Late)
VALUES ('No', 'Yes', 'Yes');


INSERT INTO Exams (Score, RoomID, CourseID, DateID, StudentID, ClassID)
VALUES (90.5, 1, 1, 1, 1, 1);

INSERT INTO Exams (Score, RoomID, CourseID, DateID, StudentID, ClassID)
VALUES (85.0, 2, 2, 2, 2, 2);

INSERT INTO Exams (Score, RoomID, CourseID, DateID, StudentID, ClassID)
VALUES (88.2, 3, 3, 3, 3, 3);


INSERT INTO Meeting (AttendanceMax, AttendanceReal,AttendanceRate, DurationMinutes, TimeID, DateID, RoomID, ClassID, CourseID, TeacherID)
VALUES (30, 25, 83.33, 60, 1, 1, 1, 1, 1, 1);

INSERT INTO Meeting (AttendanceMax, AttendanceReal,AttendanceRate, DurationMinutes, TimeID, DateID, RoomID, ClassID, CourseID, TeacherID)
VALUES (35, 30,85.71, 75, 2, 2, 2, 2, 2, 2);

INSERT INTO Meeting (AttendanceMax, AttendanceReal,AttendanceRate, DurationMinutes, TimeID, DateID, RoomID, ClassID, CourseID, TeacherID)
VALUES (40, 35,87.50, 90, 3, 3, 3, 3, 3, 3);


INSERT INTO Surveys (Score, StudentID, DateID, ClassID)
VALUES (4.5, 1, 1, 1);

INSERT INTO Surveys (Score, StudentID, DateID, ClassID)
VALUES (4.2, 2, 2, 2);

INSERT INTO Surveys (Score, StudentID, DateID, ClassID)
VALUES (4.8, 3, 3, 3);


INSERT INTO Attendance (StudentID, TeacherID, CircumstancesID, TimeID, DateID)
VALUES (1, 1, 1, 1, 1);

INSERT INTO Attendance (StudentID, TeacherID, CircumstancesID, TimeID, DateID)
VALUES (2, 2, 2, 2, 2);

INSERT INTO Attendance (StudentID, TeacherID, CircumstancesID, TimeID, DateID)
VALUES (3, 3, 3, 3, 3);
