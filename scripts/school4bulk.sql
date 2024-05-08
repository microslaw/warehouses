USE schoolDB
GO

BULK INSERT Teachers FROM 'C:\politechnika\warehouses\etl\warehousesMajlosz\dbData\teachers.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Class FROM 'C:\politechnika\warehouses\etl\warehousesMajlosz\dbData\classes.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Classroom FROM 'C:\politechnika\warehouses\etl\warehousesMajlosz\dbData\classrooms.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Students FROM 'C:\politechnika\warehouses\etl\warehousesMajlosz\dbData\students.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Course FROM 'C:\politechnika\warehouses\etl\warehousesMajlosz\dbData\courses.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Exams FROM 'C:\politechnika\warehouses\etl\warehousesMajlosz\dbData\exams.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Meeting FROM 'C:\politechnika\warehouses\etl\warehousesMajlosz\dbData\meetings.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Surveys FROM 'C:\politechnika\warehouses\etl\warehousesMajlosz\dbData\surveys.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );