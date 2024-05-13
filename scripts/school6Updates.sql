USE schoolDB
GO

Update Class SET tID = '1' WHERE ClassName = 'A18';
Update Class SET tID = '4' WHERE ClassName = 'A15';
Update Class SET tID = '6' WHERE ClassName = 'B14';
Update Class SET tID = '7' WHERE ClassName = 'C16';
Update Class SET tID = '8' WHERE ClassName = 'C14';

Update Students SET CityDistrict = 'Orunia' WHERE sID = 7;
Update Students SET CityDistrict = 'Wejherowo' WHERE sID = 1;
Update Students SET CityDistrict = 'Orlowo' WHERE sID = 2;
Update Students SET CityDistrict = 'Reda' WHERE sID = 3;
Update Students SET CityDistrict = 'Przymorze' WHERE sID = 10;

Update Students SET ClassName = 'C14' WHERE sID = 4;
Update Students SET ClassName = 'A15' WHERE sID = 2;
Update Students SET ClassName = 'B17' WHERE sID = 7;

