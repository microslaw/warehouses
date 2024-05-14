USE schoolDB
GO

BULK INSERT Students FROM 'C:\projects\warehouses\dbData\students2.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Meeting FROM 'C:\projects\warehouses\dbData\meetings2.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Exams FROM 'C:\projects\warehouses\dbData\exams2.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
BULK INSERT Surveys FROM 'C:\projects\warehouses\dbData\surveys2.csv' WITH (FIELDTERMINATOR=',', rowterminator = '\n' );
