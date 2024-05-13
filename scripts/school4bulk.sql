USE schoolDB
GO

BULK INSERT Teachers FROM 'C:\projects\warehouses\dbData\teachers.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Class FROM 'C:\projects\warehouses\dbData\classes.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Classroom FROM 'C:\projects\warehouses\dbData\classrooms.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Students FROM 'C:\projects\warehouses\dbData\students.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Course FROM 'C:\projects\warehouses\dbData\courses.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Exams FROM 'C:\projects\warehouses\dbData\exams.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Meeting FROM 'C:\projects\warehouses\dbData\meetings.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Surveys FROM 'C:\projects\warehouses\dbData\surveys.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
