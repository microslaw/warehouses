USE schoolDW
GO

Declare @CurrentHour int = 0;

While @CurrentHour < 24
	Begin

	INSERT INTO DimTime
	(
	[Hour],
	TimeOfDay
	)
	VALUES
	(
	@CurrentHour,
	CASE
		WHEN @CurrentHour BETWEEN 7 AND 9 THEN 'Early Morning'
		WHEN @CurrentHour BETWEEN 9 AND 12 THEN 'Morning'
		WHEN @CurrentHour BETWEEN 12 AND 16 THEN 'Noon'
		WHEN @CurrentHour BETWEEN 16 AND 21 THEN 'Evening'
		ELSE 'Night'
	END
		
	)

	Set @CurrentHour = @CurrentHour + 1
	End

